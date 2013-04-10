use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';

use Array;
use HTTP::DOM;

my $html = '<html><meta content="haha"><head></head><body><div id="mid">testcontent</div></body></html>';

$hd = new HTTP::DOM->new($html);
isa_ok $hd, HTTP::DOM;

is $hd->find('#mid')->text->get(0), 'testcontent';

cmp_deeply $hd->find('meta')->attr('content'), Array->new( 'haha' );
