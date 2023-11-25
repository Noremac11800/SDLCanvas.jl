module Colours

using ..Colour

export BLACK
export WHITE
export RED
export GREEN
export BLUE

BLACK = ColourRGBA(0, 0, 0)
WHITE = ColourRGBA(255, 255, 255)
RED = ColourRGBA(255, 0, 0)
GREEN = ColourRGBA(0, 255, 0)
BLUE = ColourRGBA(0, 0, 255)

end