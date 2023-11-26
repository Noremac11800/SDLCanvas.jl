module Colours

using ..Colour

export NAMED_COLOURS
export BLACK
export WHITE
export RED
export GREEN
export BLUE

export random_colour
export random_named_colour

BLACK = ColourRGBA(0, 0, 0)
WHITE = ColourRGBA(255, 255, 255)
RED = ColourRGBA(255, 0, 0)
GREEN = ColourRGBA(0, 255, 0)
BLUE = ColourRGBA(0, 0, 255)
NAMED_COLOURS = [
    BLACK,
    WHITE,
    RED,
    GREEN,
    BLUE,
]

function random_colour(a::Int=255)::ColourRGBA
    return ColourRGBA(rand(0:255), rand(0:255), rand(0:255), a)
end

function random_named_colour()::ColourRGBA
    return rand(NAMED_COLOURS)
end

end
