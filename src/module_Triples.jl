module Trojan

export generate_pyt_triple,
	generate_trojan_triple_120,
	calc_angle_by_cos_law,
	generate_trojan_triple_vector,
	get_ext_trojan_triple_vector,
	add_angles_to_triple_vector


"""
	generate_pyt_triple(big_num::Int, small_num::Int)::NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}

generates a named pythagorean triple
Input: two intergers
Output: sorted named pythagorean triple
"""
function generate_pyt_triple(big_num::Int, small_num::Int)::NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}
	a::Int = big_num^2 - small_num^2
	b::Int = big_num^2 + small_num^2
	c::Int = 2 * big_num * small_num
	gcd_abc = foldl(gcd, [a, b, c])
	if gcd_abc > 1
		a ÷= gcd_abc
		b ÷= gcd_abc
		c ÷= gcd_abc
	end
	triple = sort([a, b, c])
	return (a = triple[1], b = triple[2], c = triple[3])
end


"""
	generate_trojan_triple_120(big_num::Int, small_num::Int)::NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}

generates a trojan triple with one angle of 120°
Input: two intergers
Output: sorted named trojan triple
"""
function generate_trojan_triple_120(big_num::Int, small_num::Int)::NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}
	a::Int = big_num^2 + small_num^2 - big_num * small_num
	b::Int = abs(big_num^2 - 2 * big_num * small_num)
	c::Int = abs(small_num^2 - 2 * big_num * small_num)
	gcd_abc = foldl(gcd, [a, b, c])
	if gcd_abc > 1
		a ÷= gcd_abc
		b ÷= gcd_abc
		c ÷= gcd_abc
	end
	triple_new = sort([a, b, c])
	return (a = triple_new[1], b = triple_new[2], c = triple_new[3])
end

"""
	calc_angle_by_cos_law(a, b, c)

input: 3 edges of a triangle
Output: angle opposite to the first edge in degrees
"""
function calc_angle_by_cos_law(a, b, c)
	angle::Real = acosd((b^2 + c^2 - a^2) / (2 * b * c))
	return angle
end

"""
	generate_trojan_triple_vector(num::Int)
Input: number
Output: Vector of named tuples with the trojan triples up to the given number
"""
function generate_trojan_triple_vector(num::Int)
	triple_set = Set{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}}()
	for big_num in 3:num
		for small_num::Int in 1:(big_num-1)÷2
			trip = generate_trojan_triple_120(big_num, small_num)
			push!(triple_set, (a = trip.a, b = trip.b, c = trip.c))
		end

	end
	triple_vector = collect(triple_set)

	sort!(triple_vector, by = x -> (x.c, x.b))
	return triple_vector
end

"""
	get_ext_trojan_triples(num::Int)

Input: number
Output: Vector of named tuples with the trojan triples up to the given number extended with the numbers they where generated from
"""
function get_ext_trojan_triple_vector(num::Int)
	triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = []
	ext_triples::Vector{NamedTuple{(:p, :q, :a, :b, :c), Tuple{Int, Int, Int, Int, Int}}} = []
	for big_num::Int in 3:num
		for small_num::Int in 1:floor((big_num - 1) / 2)
			triple = generate_trojan_triple_120(big_num, small_num)
			if triple ∉ triples
				push!(triples, (a = triple.a, b = triple.b, c = triple.c))
				push!(ext_triples, (p = big_num, q = small_num, a = triple.a, b = triple.b, c = triple.c))
			end
		end
	end
	sort!(ext_triples, by = x -> (x.c, x.b))
	return ext_triples
end


"""
	add_angles(triples::Vector{<:NamedTuple})

Input: vector of named tuples containing a,b,c
Output: vector of named tuple with the angles α, β, γ
"""
function add_angles_to_triple_vector(triples::Vector{<:NamedTuple})
	ext_triples =  []
	for item in triples

		α = calc_angle_by_cos_law(item.a, item.b, item.c)
		β = calc_angle_by_cos_law(item.b, item.a, item.c)
		γ = calc_angle_by_cos_law(item.c, item.a, item.b)

		new_item = (; item..., α = α, β = β, γ = γ)


		push!(ext_triples, new_item)
	end
	return ext_triples
end



end # module Trojan
