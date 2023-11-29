module Colours

using ..Colour

export NAMED_COLOURS
export BLACK
export WHITE
export RED
export LIGHTRED
export GREEN
export LIGHTGREEN
export BLUE
export LIGHTBLUE
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
LIGHTRED = ColourRGBA(252, 106, 106, 255)
GREEN = ColourRGBA(0, 255, 0)
LIGHTGREEN = ColourRGBA(106, 252, 113, 255)
BLUE = ColourRGBA(0, 0, 255)
LIGHTBLUE = ColourRGBA(106, 186, 252, 255)
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
    r = colour.r + a <= 255 ? colour.r + a : 255
    g = colour.g + a <= 255 ? colour.g + a : 255
    b = colour.b + a <= 255 ? colour.b + a : 255
    if r < 0 r = 0 end
    if g < 0 g = 0 end
    if b < 0 b = 0 end
    return ColourRGBA(r, g, b, colour.a)
end

function darker(colour::ColourRGBA, a::Int)::ColourRGBA
    return lighter(colour, -a)
end

end
