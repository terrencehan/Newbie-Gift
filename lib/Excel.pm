package Excel;

use strict;
use warnings;
use base qw(Object);
use Array;

sub new {
    my ( $pkg, $sheet_arr ) = @_;
    return bless $sheet_arr, $pkg;
}

sub sheet {
    my ( $self, $sheet_num ) = @_;
    return $self->[ $sheet_num - 1 ];
}

sub sheets { return Array->new(@{+shift}); }

sub save {
    my ( $self, $to_file ) = @_;
}

1;
