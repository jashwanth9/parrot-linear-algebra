INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::ComplexMatrix2D::GetBlock, Pla::MatrixFactory::ComplexMatrix2D);

class Test::ComplexMatrix2D::GetBlock is Pla::Methods::GetBlock {

    # TODO: Other tests for this method with other argument combinations and
    #       boundary checks.
    method test_get_block_complex_1() {
        my $m := $!context.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $n := $!context.factory.matrix2x2("1+1i", "2+2i",
                                "4+4i", "5+5i");
        my $o := $m.get_block(0, 0, 2, 2);
        $!assert.equal($n, $o, "cannot get block with complex matrix");
    }

    method test_get_block_complex_2() {
        my $m := $!context.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $n := $!context.factory.matrix2x2("5+5i", "6+6i",
                                "8+8i", "9+9i");
        my $o := $m.get_block(1, 1, 2, 2);
        $!assert.equal($n, $o, "cannot get block with complex matrix");
    }
}
