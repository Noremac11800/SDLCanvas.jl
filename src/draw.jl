module Draw

include("common.jl")
include("colour.jl")
include("display.jl")

using ..Colour
using ..Display

export draw_filled_circle

println(typeof(ColourRGBA(255, 0, 0)))

function draw_filled_circle(window::Window, x::Int, y::Int, r::Int, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...);
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    for dy in -r:r
        for dx in -r:r
            if (dx^2 + dy^2 <= r^2)
                SDL_RenderDrawPoint(window.renderer, x+dx, y+dy)
            end
        end
    end
end

function draw_filled_circle(window::Window, x::Int, y::Int, r::Int, colour::Tuple{Int, Int, Int})
    draw_filled_circle(window, x, y, r, (colour..., 255))
end

function draw_filled_circle(window::Window, x::Int, y::Int, r::Int, colour::ColourRGBA)
    draw_filled_circle(window, x, y, r, (colour.r, colour.g, colour.b, colour.a))
end

end
