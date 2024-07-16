using Test

include("../src/Triples.jl")
include("../src/module_Triples.jl")
import .Trojan as T
@testset "Pythagorean triples generation Tests" begin
	@test T.generate_pyt_triple(2, 1) == (a = 3, b = 4, c = 5)
	@test T.generate_pyt_triple(3, 1) == (a = 3, b = 4, c = 5)
	@test T.generate_pyt_triple(3, 1) != (a = 6, b = 8, c = 10)
	@test T.generate_pyt_triple(3, 2) == (a = 5, b = 12, c = 13)
end

@testset "generate_trojan_triple_120" begin
	@test T.generate_trojan_triple_120(3, 1) == (a = 3, b = 5, c = 7)
	@test T.generate_trojan_triple_120(6, 2) == (a = 3, b = 5, c = 7)
	@test T.generate_trojan_triple_120(6, 2) != (a = 12, b = 20, c = 28)
	@test T.generate_trojan_triple_120(5, 2) == (a = 5, b = 16, c = 19)
end
@testset "calc_angle_by_cos_law" begin
    @test T.calc_angle_by_cos_law(5, 4, 3) ≈ 90.0 atol = 1e-10
    @test T.calc_angle_by_cos_law(7, 5, 3) ≈ 120.0 atol = 1e-10
    @test T.calc_angle_by_cos_law(13, 12, 5) ≈ 90.0 atol = 1e-10
end
@testset "generate_trojan_triple_vector" begin
    triple = T.generate_trojan_triple_vector(6)
    @test length(triple) == 4
    @test typeof(triple) == Vector{@NamedTuple{a::Int64, b::Int64, c::Int64}}
    @test triple == [(a = 3, b = 5, c = 7), (a = 7, b = 8, c = 13), (a = 5, b = 16, c = 19), (a = 11, b = 24, c = 31)]
end