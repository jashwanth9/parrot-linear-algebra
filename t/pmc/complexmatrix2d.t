#! parrot-nqp
our @ARGS;
MAIN();

sub MAIN () {
    Q:PIR {
        .local pmc c
        load_language 'parrot'
        c = compreg 'parrot'
        c.'import'('Test::More')

        .local pmc pla
        pla = loadlib 'linalg_group'
        if pla goto pla_library_loaded
        say "Cannot load linalg_group"
        exit 1
      pla_library_loaded:
    };

    plan(4);

    create_complexmatrix2d();
    op_does_matrix();
    vtable_get_number_keyed();
    vtable_get_integer_keyed();
    vtable_get_string_keyed();
    vtable_get_pmc_keyed();
    vtable_set_pmc_keyed();
    vtable_get_string();
    vtable_get_attr_string();
    vtable_clone();
    vtable_is_equal();
    method_resize();
    method_fill();
    method_transpose();
    method_mem_transpose();
    method_iterate_function_inplace();
}

sub create_complexmatrix2d() {
    Q:PIR {
        push_eh can_not_create
        $P0 = new ['ComplexMatrix2D']
        $I0 = isnull $P0
        $I0 = not $I0
        'ok'($I0, "Can create a new ComplexMatrix2D")
        .return()
      can_not_create:
        'ok'(0, "Could not create a ComplexMatrix2D")
        .return()
    }
}

sub op_does_matrix() {
    Q:PIR {
        $P0 = new ['ComplexMatrix2D']
        $I0 = does $P0, 'matrix'
        ok($I0, "ComplexMatrix2D does matrix")
        $I0 = does $P0, 'gobbledegak'
        $I0 = not $I0
        ok($I0, "...and only does matrix")
    }
}

sub vtable_get_number_keyed() {}
sub vtable_get_integer_keyed() {}
sub vtable_get_string_keyed() {}
sub vtable_get_pmc_keyed() {}
sub vtable_set_pmc_keyed() {}
sub vtable_get_string() {}
sub vtable_get_attr_string() {}
sub vtable_clone() {}
sub vtable_is_equal() {}
sub method_resize() {}
sub method_fill() {}
sub method_transpose() {}
sub method_mem_transpose() {}
sub method_iterate_function_inplace() {
    Q:PIR {
        $P0 = new ['ComplexMatrix2D']
        $P1 = new ['Complex']
        $P1 = "1+1i"
        $P0[0;0] = $P1
        $P1 = "2+2i"
        $P0[0;1] = $P1
        $P1 = "3+3i"
        $P0[1;0] = $P1
        $P1 = "4+4i"
        $P0[1;1] = $P1
        
        $P2 = new ['ComplexMatrix2D']
        $P1 = "3.5+1i"
        $P2[0;0] = $P1
        $P1 = "4.5+2i"
        $P2[0;1] = $P1
        $P1 = "5.5+3i"
        $P2[1;0] = $P1
        $P1 = "6.5+4i"
        $P2[1;1] = $P1
        
        .local pmc helper
        helper = get_global "_iterate_inplace_helper"
        $P0.'iterate_function_inplace'(helper)
        $I0 = $P0 == $P2
        ok($I0, "can iterate a function in place with no args")
    }
}

sub _iterate_inplace_helper($matrix, $value, $row, $col) 
{
    return ($value + 2.5);
}
