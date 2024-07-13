module Triples

export generate_triples

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
            _triple = generate_trojan_triple(big_num, small_num)
            if _triple ∉ _triples
                push!(_triples, _triple)
            end
        end
    end
    sort!(_triples, by = x -> (x.c, x.b))
    return _triples
end




function add_angles(triples::Vector{NamedTuple{(:a, :b, :c), Tuple{Int, Int, Int}}})
    
    _ext_triples = []
    for item in triples
        a,b,c = item
        α = angle_by_cos_law(a, b, c)
        β = angle_by_cos_law(b, a, c)
        γ = angle_by_cos_law(c, a, b)
        push!(_ext_triples, (a=a, b=b, c=c, α=α, β=β, γ=γ))
    end
    return _ext_triples
end

triples = get_trojan_triples(20)
ext_triples = add_angles(triples)

for item in ext_triples
    a,b,c,α,β,γ = item      
    println("$a  $b  $c  $α   $β   $γ")
end



end # module Triples
