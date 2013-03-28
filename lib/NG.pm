package NG;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(def_class);

sub def_class{
    my ($class, $parent, $attrs, $methods) = @_;


    *t = eval('*'.$class.'::ISA');
    @t = ($parent);

    for(keys %$methods){
        *t = eval('*'.$class.'::'.$_);
        *t = $methods->{$_};
    }

    for(@$attrs){
        *t = eval('*'.$class.'::'.$_);
        *t = sub :lvalue{
            my ($self) = shift;
            $self->{$_};
        };
    }

    *t = eval('*'.$class.'::new');
    my $o;
    if($parent ne 'undef' ){
        $p_attrs = new $parent;
        $o = bless {(map {($_, undef)} @$attrs), %$p_attrs }, $class;
    }
    else{
        $o = bless {map {($_, undef)} @$attrs}, $class;
    }
    *t = sub {
        my ($class, $args) = @_;
        if(defined $methods->{build}){
            $o->build($args);
        }
        $o;
    };


}


1;
