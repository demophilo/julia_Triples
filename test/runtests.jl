using Test
using Triples

@testset "Triples Tests" begin
    @test Triples.generate_triples_test(1, 2) == [3, 4, 5]
end
