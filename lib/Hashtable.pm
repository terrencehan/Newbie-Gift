use NG;
use Array;

def_class Hashtable => Object => ['data'] => {
    build => sub {
        my ( $self, $args ) = @_;
        $self->data = {@$args};
    },
    put => sub {
        my ( $self, $key, $val ) = @_;
        $self->data->{$key} = $val;
        return $self;
    },

    get => sub {
        my ( $self, $key ) = @_;
        return $self->data->{$key};
    },
    keys => sub {
        my ($self) = @_;
        return new Array( sort keys %{ $self->data } );
    },

    values => sub {
        my ($self) = @_;
        return new Array( sort values %{ $self->data } );
    },
    remove => sub {
        my ( $self, $key ) = @_;
        delete $self->data->{$key};
        return $self;
    },
    each => sub {
        my ( $self, $sub ) = @_;
        $self->keys->each(
            sub {
                my ($key) = @_;
                $sub->( $key, $self->get($key) );
            }
        );
        return $self;
      }
};

