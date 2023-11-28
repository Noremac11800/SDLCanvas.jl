module Colours

using ..Colour

export NAMED_COLOURS
export BLACK
export WHITE
export RED
export GREEN
export BLUE
export GREY
export LIGHTGREY
export DARKGREY
export YELLOW

export random_colour
export random_named_colour
export lighter
export darker

BLACK = ColourRGBA(0, 0, 0)
WHITE = ColourRGBA(255, 255, 255)
RED = ColourRGBA(255, 0, 0)
GREEN = ColourRGBA(0, 255, 0)
BLUE = ColourRGBA(0, 0, 255)
GREY = ColourRGBA(150, 150, 150)
LIGHTGREY = ColourRGBA(200, 200, 200)
DARKGREY = ColourRGBA(100, 100, 100)
YELLOW = ColourRGBA(242, 189, 41)
NAMED_COLOURS = [
    BLACK,
    WHITE,
    RED,
    GREEN,
    BLUE,
    GREY,
    LIGHTGREY,
    DARKGREY,
    YELLOW,
]

function random_colour(a::Int=255)::ColourRGBA
    return ColourRGBA(rand(0:255), rand(0:255), rand(0:255), a)
end

function random_named_colour()::ColourRGBA
    return rand(NAMED_COLOURS)
end

function lighter(colour::ColourRGBA, a::Int)::ColourRGBA
    return ColourRGBA(colour.r, colour.g, colour.b, colour.a - a)
end

function darker(colour::ColourRGBA, a::Int)::ColourRGBA
    return lighter(colour, -a)
end

end
