use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';
use Hashtable;
use File;
use Time;
$f = new File;

isa_ok $f, File;

my $stat = $f->fstat( '/tmp' );
isa_ok $stat, Hashtable;

is $stat->{mode}, '1777';
is $stat->{uid}, 0;
isa_ok $stat->{atime}, Time;
is $stat->{atime}->day, Time->new->now->day;
