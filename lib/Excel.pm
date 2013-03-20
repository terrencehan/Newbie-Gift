package Excel;

use strict;
use warnings;
use base qw(Object);
use Array;
use Spreadsheet::WriteExcel;

sub new {
    my ( $pkg, $sheet_arr ) = @_;
    return bless $sheet_arr, $pkg;
}

sub sheet {
    my ( $self, $sheet_num ) = @_;
    return $self->[ $sheet_num - 1 ];
}

sub sheets { return Array->new( @{ +shift } ); }

sub save {
    my ( $self, $to_file ) = @_;
    unlink $to_file if -e $to_file;
    my $workbook = Spreadsheet::WriteExcel->new($to_file);
    $self->sheets->each(
        sub {
            my ( $sheet, $i ) = @_;
            my $worksheet = $workbook->add_worksheet( $sheet->name );
            for my $row ( 1 .. $sheet->row_count ) {
                for my $col ( 1 .. $sheet->col_count ) {
                    my $cell = $sheet->get($row, $col);
                    if($cell){
                        my $value = $cell->value;
                        $worksheet->write($row-1, $col-1, $value);
                    }
                }
            }

        }
    );
}

1;
