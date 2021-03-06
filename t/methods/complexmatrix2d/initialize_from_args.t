INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::ComplexMatrix2D::InitializeFromArgs, Pla::MatrixFactory::ComplexMatrix2D);

class Test::ComplexMatrix2D::InitializeFromArgs is Pla::Methods::InitializeFromArgs {

    method test_initialize_from_args_complex() {
        my $m := $!context.factory.matrix2x2("1+1i", "2+2i",
                                "3+3i", "4+4i");
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(2, 2, "1+1i", "2+2i",
                                      "3+3i", "4+4i");
        $!assert.equal($n, $m, "cannot initialize_from_args with complex matrix");
    }

	method test_initialize_from_args_array() {
        my $m := $!context.factory.matrix2x2("1+1i", "2+2i",
                                "3+3i", "4+4i");
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(2, 2, (1,1), (2,2),
                                      (3,3), (4,4));
        $!assert.equal($n, $m, "cannot initialize_from_args with array");
    }

    method test_null_pad_extra_spaces_complex() {
        my $m := $!context.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", $!context.factory.nullvalue,     $!context.factory.nullvalue,
                                $!context.factory.nullvalue,     $!context.factory.nullvalue,     $!context.factory.nullvalue);
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(3, 3, "1+1i", "2+2i", "3+3i",
                                      "4+4i");
        $!assert.equal($n, $m, "cannot initalize from args with zero padding with complex matrix");
    }

    method test_ignore_extra_values_complex() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := "1+1i";
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(1, 1, "1+1i", "2+2i",
                                      "3+3i", "4+4i");
        $!assert.equal($n, $m, "cannot initialize from args undersized with complex matrix");
    }
}
