module Triples

export generate_pyt_triple, generate_trojan_triple_120

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
	triple = sort([a, b, c])
	return (a = triple[1], b = triple[2], c = triple[3])
end






end # module Triples
