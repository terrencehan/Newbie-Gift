use Test::More 'no_plan';
use Test::Deep;
use lib '../lib';

use HTTP::Client;
$hc = new HTTP::Client;

isa_ok $hc, HTTP::Client;

my $url = 'http://www.baidu.com/';
my $got = $hc->web_get($url);
like $got, qr/<.*>/, 'return HTML format-like strings';

my @urls = qw(http://www.baidu.com http://www.sina.com.cn);
$hc->web_get(@urls, sub {
    my ($content, $code, $res_headers) = @_;   # $res_headers 是 SHashtable 类型
    is $code, 200, 'HTTP code ok';
    isa_ok $res_headers, SHashtable;
    print $res_headers->{URL}," tested\n";
});
