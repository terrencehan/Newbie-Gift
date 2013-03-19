package Excel::Cell;

use strict;
use warnings;
use base qw(Object);

sub new {
    my ( $pkg, @config ) = @_;
    my $cell = {
        value => "",
        width => 35,

        border_left => {
            width => 1,
            style => 'solid',
            color => 0x00dd00,
        },
        border_bottom => {
            width => 1,
            style => 'solid',
            color => 0x00dd00,
        },

        #end of default config
        @config,
    };
    return bless $cell, $pkg;
}

sub value {
    my ( $self, $new_val ) = @_;
    if ( defined $new_val ) {
        $self->{value} = $new_val;
        return $self;
    }
    else {
        return $self->{value};
    }
}

sub border_left {
    my ( $self, $width, $style, $color ) = @_;
    if ( scalar(@_) > 1 ) {
        $self->{border_left} = {
            width => $width,
            style => $style,
            color => $color,
        };
        return $self;
    }
    else {
        my$border_left = $self->{border_left};
        return
            $border_left->{width} . ', '
          . $border_left->{style} . ', '
          . sprintf("0x%.6x", $border_left->{color});
    }

}

sub border_bottom {

    my ( $self, $width, $style, $color ) = @_;
    if ( scalar(@_) > 1 ) {
        $self->{border_left} = {
            width => $width,
            style => $style,
            color => $color,
        };
        return $self;
    }
    else {
       my $border_bottom = $self->{border_bottom};
        return
            $border_bottom->{width} . ', '
          . $border_bottom->{style} . ', '
          . sprintf("0x%.6x", $border_bottom->{color});
    }
}

sub width {
    my ( $self, $new_val ) = @_;
    if ( defined $new_val ) {
        return $self;
        $self->{width} = $new_val;
    }
    else {
        return $self->{width};
    }
}

1;
