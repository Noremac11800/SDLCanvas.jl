module Draw

include("common.jl")

# Colour and Display modules are already brought into scope in JLGame.jl.
# Re-including them with include() is unnecessary. Just use the .. using syntax.
using ..Colour
using ..Display

export draw_line
export draw_filled_circle

function draw_line(window::Window, x1::Int, y1::Int, x2::Int, y2::Int, colour::Tuple{Int, Int, Int, Int}; thickness::Int=1)
    angle = SDL_atan2(y2-y1, x2-x1)
    dx = floor(Int, sin(angle) * thickness / 2.0)
    dy = floor(Int, -cos(angle) * thickness / 2.0)
    SDL_SetRenderDrawColor(window.renderer, colour...)
    for i in 0:thickness-1
        SDL_RenderDrawLine(window.renderer, x1 + i*dx, y1 + i*dy, x2 + i*dx, y2 + i*dy)
    end
end

function draw_line(window::Window, x1::Int, y1::Int, x2::Int, y2::Int, colour::Tuple{Int, Int, Int}; kwargs...)
    draw_line(window, x1, y1, x2, y2, (colour..., 255); kwargs...)
end

function draw_line(window::Window, x1::Int, y1::Int, x2::Int, y2::Int, colour::ColourRGBA; kwargs...)
    draw_line(window, x1, y1, x2, y2, (colour.r, colour.g, colour.b, colour.a); kwargs...)
end

function draw_filled_circle(window::Window, x::Int, y::Int, r::Int, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
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