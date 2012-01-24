INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::PMCMatrix2D::ConvertToComplexMatrix, Pla::MatrixFactory::PMCMatrix2D);

class Test::PMCMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {

}
