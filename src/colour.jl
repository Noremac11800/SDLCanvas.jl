module Colour

include("common.jl")

export ColourRGBA

struct ColourRGBA
    r::Int
    g::Int
    b::Int
    a::Int
    ColourRGBA(r, g, b) = new(r, g, b, 255)
    ColourRGBA(r, g, b, a) = new(r, g, b, a)
end

end
