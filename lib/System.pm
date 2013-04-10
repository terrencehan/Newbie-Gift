package System;
use warnings;
use strict;
use autodie;
use base 'Object';
use Array;
use IPC::Run qw(run timeout);

sub new {
    my $pkg = shift;
    return bless {}, $pkg;
}

=head1 local_run
    local_run "ls", sub {
	    my ($out, $out) = @_;
	    $out->each(sub{
	       ...
	    })
	    ...
    }
=cut
sub local_run {
	my $self = shift;
	my ($in, $out, $err, $cb);
	if ( ref($cb) ne 'CODE' ) {
		$cb = pop @_;
	}
	my @commands = @_;

	my $ret = run(\@commands, \$in, \$out, \$err, timeout(10));

	if (defined $cb) {
		my $stdout = Array->new(split/\n/, $out);
		my $stderr = Array->new(split/\n/, $err);
		$cb->($stdout, $stderr);
		return $ret;
	}
	else {
		return Array->new(split/\n/, $out);
	}
}

=head1 local_run
TODO: async ssh command
=cut
sub remote_run {
	my $self = shift;
}

1;