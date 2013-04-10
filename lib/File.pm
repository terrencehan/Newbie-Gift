package File;
use strict;
use warnings;
use base qw(Object);
use Array;
use Hashtable;
use Time;
use File::Find;
use File::Copy::Recursive;

sub new {
    my $pkg = shift;
    return bless {}, $pkg;
}

=head1 read_file
    my $filepath = '/home/chenryn/test.conf';
    my $content = read_file($filepath);
    say $content;

    read_file($filepath, sub {
        my ($content) = @_;
        say $content->get(1);
    });
=cut
sub read_file {
    my ( $self, $filepath, $cb ) = @_;
    open my $fh, '<', $filepath;
    my $content = new Array;
    while(<$fh>){
    	chomp;
    	$content->push($_);
    }
    if ( defined $cb ) {
        $cb->($content);
    }
    else {
        return join("\n", @$content);
    }
}

=head1 read_dir
    read_dir('/root')->each(sub { 
        my $file = shift;
        read_file( $file, sub {
            ...
        })
    });
    read_dir(qw(/root /tmp), sub{
        my ($dir, $file) = @_;
        ...
    });
=cut
sub read_dir {
    my $self = shift;
    if (ref($_[-1]) eq 'CODE' ) {
        my $cb = pop @_;
        my @dirpath = @_;
        File::Find::find(sub {
            $cb->($File::Find::dir, $_);
        }, @dirpath)
    }
    else {
        my $dirpath = shift;
        return Array->new( glob("$dirpath/*") );
    }
}

sub mkdir_p { shift; File::Copy::Recursive::pathmk(@_) }

sub rm_r { shift; File::Copy::Recursive::pathrm(@_) }

sub cp_r { shift; File::Copy::Recursive::rcopy(@_) }

=head1
     0 dev      device number of filesystem
     1 ino      inode number
     2 mode     file mode  (type and permissions)
     3 nlink    number of (hard) links to the file
     4 uid      numeric user ID of file's owner
     5 gid      numeric group ID of file's owner
     6 rdev     the device identifier (special files only)
     7 size     total size of file, in bytes
     8 atime    last access time in seconds since the epoch
     9 mtime    last modify time in seconds since the epoch
    10 ctime    inode change time in seconds since the epoch (*)
    11 blksize  preferred block size for file system I/O
    12 blocks   actual number of blocks allocated
=cut
sub fstat {
    my ($self, $file) = @_;
    my $ret = Array->new(stat($file));
    return Hashtable->new(
        dev => $ret->get(0),
        inode => $ret->get(1),
        mode => sprintf("%04o", $ret->get(2) & 07777),
        nlink => $ret->get(3),
        uid => $ret->get(4),
        gid => $ret->get(5),
        rdev => $ret->get(6),
        size => $ret->get(7),
        atime => Time->new->from_epoch($ret->get(8)),
        mtime => Time->new->from_epoch($ret->get(9)),
        ctime => Time->new->from_epoch($ret->get(10)),
        blksize => $ret->get(11),
        blocks => $ret->get(12),
    );
}

1;
