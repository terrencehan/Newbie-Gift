
use Test::More;
use lib '../lib';

use NG;


def_class Animal=>undef=>['name']=>{
    run => sub{
        my $self = shift;
        print "a " . $self->name . " is running\n";
    }
};

def_class Dog=>Animal=>['type']=>{
    build => sub{
        my $self = shift;
        $self->name = 'dog';
    }
};


my $dog = new Dog;

$dog->run;


