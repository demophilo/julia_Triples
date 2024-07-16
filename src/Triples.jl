module Triples

export generate_pyt_triple

using StatsBase # Für countmap

function generate_pyt_triple(big_num::Int, small_num::Int)
	_a::Int = big_num^2 - small_num^2
	_b::Int = big_num^2 + small_num^2
	_c::Int = 2 * big_num * small_num
	_triple = sort([_a, _b, _c])
	return _triple

end

function generate_trojan_triple(big_num::Int, small_num::Int)::NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}
	_a::Int = big_num^2 + small_num^2 - big_num * small_num
	_b::Int = abs(big_num^2 - 2 * big_num * small_num)
	_c::Int = abs(small_num^2 - 2 * big_num * small_num)

	_triple = sort([_a, _b, _c])
	return (a = _triple[1], b = _triple[2], c = _triple[3])
end

function angle_by_cos_law(a, b, c)
	_angle = acosd((b^2 + c^2 - a^2) / (2 * b * c))
	return _angle
end

function get_ext_trojan_triples(num::Int)
	_triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = []
	_ext_triples::Vector{NamedTuple{(:p, :q, :a, :b, :c), Tuple{Int, Int, Int, Int, Int}}} = []
	for big_num::Int in 3:num
		for small_num::Int in 1:floor((big_num - 1) / 2)
			_triple = generate_trojan_triple(big_num, small_num)
			if _triple ∉ _triples
				push!(_triples, (a = _triple.a, b = _triple.b, c = _triple.c))
				push!(_ext_triples, (p = big_num, q = small_num, a = _triple.a, b = _triple.b, c = _triple.c))
			end
		end
	end
	sort!(_ext_triples, by = x -> (x.c, x.b))
	return _ext_triples
end

function get_trojan_triples(num::Int)
	_triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = []
	for big_num::Int in 3:num
		for small_num::Int in 1:floor((big_num - 1) / 2)
			_triple = generate_trojan_triple(big_num, small_num)
			if _triple ∉ _triples
				push!(_triples, (a = _triple.a, b = _triple.b, c = _triple.c))
			end
		end
	end
	sort!(_triples, by = x -> (x.c, x.b))
	return _triples
end

function add_angles(triples::Vector{<:NamedTuple})
	_ext_triples = []
	for item in triples

		α = angle_by_cos_law(item.a, item.b, item.c)
		β = angle_by_cos_law(item.b, item.a, item.c)
		γ = angle_by_cos_law(item.c, item.a, item.b)

		new_item = merge(item, (α = α, β = β, γ = γ))


		push!(_ext_triples, new_item)
	end
	return _ext_triples
end

function analyze_c_frequencies(ext_triples, max_num)
	c_values = [item.c for item in ext_triples if item.c < max_num^2 * 3 / 4 + 1]
	c_frequencies = countmap(c_values)
	frequency_counts = Dict()
	for freq in values(c_frequencies)
		frequency_counts[freq] = get(frequency_counts, freq, 0) + 1
	end

	return frequency_counts
end

"""
    get_trojan_triples_for_a_number(num::Int)::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}}

Input: number
Output: vector of all possible named trojan triples, which have an edge of the size of the input number
"""
function get_trojan_triples_for_a_number(num::Int)::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}}
	big_num::Int = ceil(sqrt(4 * num / 3 + 1))
	triples_vector = get_trojan_triples(big_num)
	every_triple_vector = expand_trojan_triple_vector(triples_vector)
	right_triple_set::Set{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = []
	for item in every_triple_vector
		for edge in item
			if num % edge == 0
				a = item.a * num / edge
				b = item.b * num / edge
				c = item.c * num / edge
				triple = (a = a, b = b, c = c)
				push!(right_triple_set, triple)
			end
		end

	end
	right_triple_vector::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = Vector(every_triple_set)
	sort!(right_triple_vector, by = x -> (x.c, x.b))
	return right_triple_vector
end

"""
	get_every_trojan_triple(triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}})

Input: vector of named trojan triples with one angle of 120°
Output: vector of named trojan triples with all possible angles and the same hypothenuse
"""
function expand_trojan_triple_vector(triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}})
	every_triple_set::Set{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = []
	for item in triples
		first_triple = (a = item.a, b = item.c, c = item.a + item.b)
		second_triple = (a = item.b, b = item.c, c = item.a + item.b)
		push!(every_triple_set, first_triple)
		push!(every_triple_set, second_triple)
		push!(every_triple_set, item)
	end
	every_triple_vector = Vector(every_triple_set)
	sort!(every_triple_vector, by = x -> (x.c, x.b))
	return every_triple_vector
end
triples = get_trojan_triples_for_a_number(111)
println(triples)
end # module
