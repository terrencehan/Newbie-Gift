use Test::More 'no_plan';
use lib '../lib';
use Array;
use Log;
$log = new Log;

isa_ok $log, Log;

my $logpath = './log.txt';
$log->process_log($logpath, sub {
    my ($fields) = @_;    # 第一个参数是 Array 类型
    isa_ok $fields, Array;
    ok $fields->get(1) ~~ /^\d{3}&abc$/;  # 获取第2个字段
});

$log->process_log($logpath, sub {
    my ($fields) = @_;
    is $fields->get(1), 'abc', 'split using &';
}, '&');
