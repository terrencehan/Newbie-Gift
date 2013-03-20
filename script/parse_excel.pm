use strict;
use warnings;

use lib '../lib';

use Data::Dumper qw/Dumper/;
use Array;
use Excel;
use Excel::Sheet;
use Excel::Cell;
use Spreadsheet::ParseExcel;

sub parse_excel {
    my ( $filepath, $cb ) = @_;
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse($filepath);
    if ( !defined $workbook ) {
        die $parser->error() . "\n";
    }
    my $ng_sheet_arr = Array->new;
    for my $sheet ( $workbook->worksheets() ) {
        my ( $row_min, $row_max ) = $sheet->row_range();
        my ( $col_min, $col_max ) = $sheet->col_range();

        my $ng_sheet = Excel::Sheet->new(
            name      => $sheet->get_name(),
            row_count => $row_max + 1,
            col_count => $col_max + 1,
        );

        for my $row ( $row_min .. $row_max ) {
            for my $col ( $col_min .. $col_max ) {
                my $cell = $sheet->get_cell( $row, $col );
                next unless $cell;

                my $ng_cell = Excel::Cell->new( value => $cell->value(), );
                $ng_sheet->{cells}->[$row][$col] = $ng_cell;
            }
        }
        $ng_sheet_arr->push($ng_sheet);
    }

    my $ng_excel = Excel->new($ng_sheet_arr);
    if ( defined $cb ) {
        $cb->($ng_excel);
        $ng_excel->save($filepath);
    }
    else {
        return $ng_excel;
    }
}

#demo
parse_excel(
    "../t/test.xls",
    sub {
        my ($excel) = @_;
        $excel->sheet(1)->get( 2, 'B' )->value('fuck');
    }
);
