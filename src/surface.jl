module Surfaces

include("common.jl")

export Surface
export get_size
export get_center
export blit

using ..Display

struct Surface
    surface::Ptr{SDL_Surface}
    Surface(surface) = new(surface)
end

function get_size(window::Window, surface::Surface)
    texture = SDL_CreateTextureFromSurface(window.renderer, surface.surface)
    w, h = Ref{Int32}(), Ref{Int32}()
    SDL_QueryTexture(texture, C_NULL, C_NULL, w, h)
    return w[], h[]
end

function get_center(window::Window, surface::Surface)
    w, h = get_size(window, surface)
    return w ÷ 2, h ÷ 2
end

function blit(window::Window, surface::Surface, x::Int, y::Int; centered=true)
    texture = SDL_CreateTextureFromSurface(window.renderer, surface.surface)
    w, h = Ref{Int32}(), Ref{Int32}()
    SDL_QueryTexture(texture, C_NULL, C_NULL, w, h)
    w, h = w[], h[]
    if centered
        rect = SDL_Rect(x - w÷2, y - h÷2, w, h)
    else
        rect = SDL_Rect(x, y, w, h)
    end
    SDL_RenderCopy(window.renderer, texture, C_NULL, Ref(rect))
end

end