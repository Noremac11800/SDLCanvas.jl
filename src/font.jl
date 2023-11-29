module Fonts

include("common.jl")

export Font
export render_font

using ..Colour
using ..Display
using ..Surfaces

struct Font
    font::Ptr{TTF_Font}
    size::Int
    Font(fontname, size) = new(get_font(fontname, size), size)
end

function get_font(path::String, size::Int)::Ptr{TTF_Font}
    @assert TTF_Init() == 0 "Error initialising font backend"
    # path = joinpath("..", pwd(), "assets", fontname*".ttf")
    font::Ptr{TTF_Font} = TTF_OpenFont(path, size)
    if font == C_NULL
        throw(error("font was null and couldn't be found at: $(path)"))
    end
    return font
end

function render_font(font::Font, text::String, colour::ColourRGBA; antialiased=true)::Surface
    colour = SDL_Color(colour.r, colour.g, colour.b, colour.a)
    if antialiased
        return Surface(TTF_RenderText_Blended(font.font, text, colour))
    else
        return Surface(TTF_RenderText_Solid(font.font, text, colour))
    end
end

end
