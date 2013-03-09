use strict;
use warnings;

use lib '../lib';

use Excel;
use Spreadsheet::ParseExcel;

sub parse_excel {
    my ( $filepath, $cb ) = @_;
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse($filepath);
    if(!defined $workbook){
        die $parser->error() . "\n";
    }

    for my $sheet ($workbook->worksheets()){

    }
}

