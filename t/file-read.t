use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';
use Array;
use File;
use Data::Dumper;

$f = new File;

isa_ok $f, File;

my $log = './log.txt';
my $got = $f->read_file($log);
is $got, "line1 123&abc\nline2 321&abc";

$f->read_file($log, sub {
    my ($line) = @_;
    cmp_deeply $line, Array->new( 'line1 123&abc', 'line2 321&abc' );
});

my $list = $f->read_dir('/');
isa_ok $list, Array;

$f->read_dir('.', sub {
    my ($dir, $file) = @_;
    is $dir, '.';
    ok $file, 'is file' if -f $dir.$file;
});
