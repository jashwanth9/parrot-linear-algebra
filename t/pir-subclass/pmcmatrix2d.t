#!parrot

.sub setup :anon :init
    $P0 = load_bytecode "rosella/core.pbc"
    $P1 = get_root_global [ 'parrot' ; 'Rosella' ], 'initialize_rosella'
    #$P1 = get_root_global ["Rosella"], "initialize_rosella"
    $P1("test")
    $P2 = get_root_global ['parrot' ; "Rosella"], "load_bytecode_file"
    $P2('t/testlib/pla_test.pbc', "load")
    $P3 = loadlib "./dynext/linalg_group"
.end

.HLL 'PMCMatrix2D_SUBCLASS_TEST'

.sub test :main
    $P0 = get_class 'Integer'
    $P1 = subclass $P0, 'TestInteger'
    $P2 = getinterp
    $P2.'hll_map'($P0, $P1)

    $P3 = box 0
    set_hll_global ['Test'], '_count', $P3

    say "1..3"
    test_get_attr_str()
.end

.sub is_TestInteger
    .param pmc arg

    $S0 = typeof arg
    if $S0 == 'TestInteger' goto are_equal
    print "not "
  are_equal:
    print "ok "
    $P0 = get_hll_global ['Test'], '_count'
    inc $P0
    say $P0
.end

.sub test_get_attr_str
    $P0 = new ['PMCMatrix2D']
    $P0.'initialize_from_args'(2, 2, 1, 2, 3, 4)

    $P1 = getattribute $P0, 'rows'
    is_TestInteger($P1)

    $P1 = getattribute $P0, 'cols'
    is_TestInteger($P1)

    $P1 = getattribute $P0, 'size'
    is_TestInteger($P1)
.end

