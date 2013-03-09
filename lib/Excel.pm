package Excel;

use strict;
use warnings;
use base qw(Object);
use Array;

sub new {
    my $pkg = shift;
    return bless Array->new(@_), $pkg;
}

sub sheet {
    my ($self, $sheet_num) = @_;
    return $self->[$sheet_num];
}

sub sheets {
    my ($self) = @_;
    return $self;
}

1;
