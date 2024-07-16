using Test

include("../src/Triples.jl")
include("../src/module_Triples.jl")
using .Triples
@testset "Pythagorean triples generation Tests" begin
	@test generate_pyt_triple(2, 1) == (a = 3, b = 4, c = 5)
	@test generate_pyt_triple(3, 1) == (a = 3, b = 4, c = 5)
	@test generate_pyt_triple(3, 1) != (a = 6, b = 8, c = 10)
	@test generate_pyt_triple(3, 2) == (a = 5, b = 12, c = 13)
end

@testset "generate_trojan_triple_120" begin
	@test generate_trojan_triple_120(3, 1) == (a = 3, b = 5, c = 7)
	@test generate_trojan_triple_120(6, 2) == (a = 3, b = 5, c = 7)
	@test generate_trojan_triple_120(6, 2) != (a = 12, b = 20, c = 28)
	@test generate_trojan_triple_120(5, 2) == (a = 5, b = 16, c = 19)
end
@testset "calc_angle_by_cos_law" begin
    @test calc_angle_by_cos_law(5, 4, 3) ≈ 90.0 atol = 1e-10
    @test calc_angle_by_cos_law(7, 5, 3) ≈ 120.0 atol = 1e-10
    @test calc_angle_by_cos_law(13, 12, 5) ≈ 90.0 atol = 1e-10
end