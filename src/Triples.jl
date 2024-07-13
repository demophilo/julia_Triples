module Triples

export generate_triples

function generate_triple(big_num::Int, small_num::Int)
    _a::Int = big_num^2 - small_num^2
    _b::Int = big_num^2 + small_num^2
    _c::Int = 2 * big_num * small_num
    _triple = sort([_a, _b, _c])
    return _triple
    
end

function generate_trojan_triples(big_num::Int, small_num::Int)::NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}
    _a::Int = big_num^2 + small_num^2 - big_num * small_num
    _b::Int = abs(big_num^2 - 2 * big_num * small_num)
    _c::Int = abs(small_num^2 - 2 * big_num * small_num)

    _triple = sort([_a, _b, _c])
    return (a=_triple[1], b=_triple[2], c=_triple[3])
end



function angle_by_cos_law(a, b, c)
    _angle = acosd((b^2 + c^2 - a^2) / (2 * b * c))
    return _angle
end

function get_trojan_triples(num::Int)
    _triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}} = []
    for big_num::Int in 3:num
        for small_num::Int in 1:floor((big_num-1)/2)
            _triple = generate_trojan_triples(big_num, small_num)
            if _triple ∉ _triples
                push!(_triples, _triple)
            end
        end
    end
    sort!(_triples, by = x -> (x.c, x.b))
    return _triples
end

triples = get_trojan_triples(20)
for item in triples
    println(item)
end




for big_num::Int in 3:20
    for small_num::Int in 1:floor((big_num-1)/2)
        a,b,c = generate_trojan_triples(big_num, small_num)
        α = angle_by_cos_law(a, b, c)
        β = angle_by_cos_law(b, a, c)
        γ = angle_by_cos_law(c, a, b)
        println("$big_num  $small_num  $a  $b  $c  $α   $β   $γ")
    end
end



end # module Triples
