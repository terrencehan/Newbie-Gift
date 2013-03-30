use strict;
use warnings;
use Data::Dumper qw(Dumper);
use NG;

def_class Object => undef => [] => {
    dump => sub {
        return Dumper(shift);
      }
};

1;
