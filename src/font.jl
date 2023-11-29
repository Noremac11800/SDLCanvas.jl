module Font

include("common.jl")

export get_font
export render_font
export blit

using ..Colour
using ..Display

function get_font(fontname::String, size::Int)::Ptr{TTF_Font}
    @assert TTF_Init() == 0 "Error initialising font backend"
    path = joinpath("..", pwd(), "assets", fontname*".ttf")
    font::Ptr{TTF_Font} = TTF_OpenFont(path, size)
    if font == C_NULL
        throw(error("font was null and couldn't be found at: $(path)"))
    end
    return font
end

function render_font(font::Ptr{TTF_Font}, text::String, colour::ColourRGBA)::Ptr{SDL_Surface}
    colour = SDL_Color(colour.r, colour.g, colour.b, colour.a)
    return TTF_RenderText_Solid(font, text, colour)
end

function blit(window::Window, surface::Ptr{SDL_Surface}, x::Int, y::Int)
    texture = SDL_CreateTextureFromSurface(window.renderer, surface)
    w, h = Ref{Int32}(), Ref{Int32}()
    SDL_QueryTexture(texture, C_NULL, C_NULL, w, h)
    rect = SDL_Rect(x, y, w[], h[])
    SDL_RenderCopy(window.renderer, texture, C_NULL, Ref(rect))
end

end
