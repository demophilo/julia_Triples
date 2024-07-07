module Triples
export generate_triples()
function generate_triple(big_num::Int, small_num::Int)
    _a::Int = big_num^2 - small_num^2
    _b::Int = big_num^2 + small_num^2
    _c::Int = 2 * big_num * small_num
    _triple = sort([_a, _b, _c])
    return _triple
    
end


end # module Triples
