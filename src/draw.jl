module Draw

include("common.jl")

# Colour and Display modules are already brought into scope in JLGame.jl.
# Re-including them with include() is unnecessary. Just use the .. using syntax.
using ..Colour
using ..Display

export draw_pixel
export draw_line
export draw_arc
export draw_filled_arc
export draw_circle
export draw_filled_circle
export draw_ellipse
export draw_filled_ellipse
export draw_rect
export draw_filled_rect

function draw_pixel(window::Window, x::Int, y::Int, colour::Tuple{Int,Int,Int,Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    SDL_RenderDrawPoint(window.renderer, x, y)
end

function draw_pixel(window::Window, x::Int, y::Int, colour::Tuple{Int,Int,Int})
    draw_pixel(window, x, y, (colour..., 255))
end

function draw_pixel(window::Window, x::Int, y::Int, colour::ColourRGBA)
    draw_pixel(window, x, y, (colour.r, colour.g, colour.b, colour.a))
end

function draw_line(window::Window, x1::Int, y1::Int, x2::Int, y2::Int, colour::Tuple{Int, Int, Int, Int}; thickness::Int=1)
    angle = SDL_atan2(y2-y1, x2-x1)
    dx = floor(Int, sin(angle) * thickness / 2.0)
    dy = floor(Int, -cos(angle) * thickness / 2.0)
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
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

function draw_arc(window::Window, x::Int, y::Int, r::Int, start_angle::Real, end_angle::Real, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    for theta in start_angle:0.01:end_angle
        px, py = r*cos(theta) + x, -r*sin(theta) + y
        SDL_RenderDrawPoint(window.renderer, round(Int, px), round(Int, py))
    end
end

function draw_arc(window::Window, x::Int, y::Int, r::Int, start_angle::Real, end_angle::Real, colour::Tuple{Int, Int, Int})
    draw_arc(window, x, y, r, start_angle, end_angle, (colour..., 255))
end

function draw_arc(window::Window, x::Int, y::Int, r::Int, start_angle::Real, end_angle::Real, colour::ColourRGBA)
    draw_arc(window, x, y, r, start_angle, end_angle, (colour.r, colour.g, colour.b, colour.a))
end

function draw_filled_arc(window::Window, x::Int, y::Int, r::Int, start_angle::Real, end_angle::Real, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    for dx in -r:r
        for dy in -r:r
            if dx^2 + dy^2 <= r^2
                angle_to_x_axis = atan(-dy, dx)
                angle_to_x_axis = angle_to_x_axis < 0 ? angle_to_x_axis + 2pi : angle_to_x_axis
                if start_angle <= angle_to_x_axis <= end_angle
                    SDL_RenderDrawPoint(window.renderer, x+dx, y+dy)
                end
            end
        end
    end
end

function draw_filled_arc(window::Window, x::Int, y::Int, r::Int, start_angle::Real, end_angle::Real, colour::Tuple{Int, Int, Int})
    draw_filled_arc(window, x, y, r, start_angle, end_angle, (colour..., 255))
end

function draw_filled_arc(window::Window, x::Int, y::Int, r::Int, start_angle::Real, end_angle::Real, colour::ColourRGBA)
    draw_filled_arc(window, x, y, r, start_angle, end_angle, (colour.r, colour.g, colour.b, colour.a))
end

# function draw_eliptic_arc(window::Window, x::Int, y::Int, major::Int, minor::Int, colour::ColourRGBA)
#     for theta in 0:0.01:2pi
# end

function draw_circle(window::Window, x::Int, y::Int, r::Int, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    draw_arc(window, x, y, r, 0, 2pi, colour)
end

function draw_circle(window::Window, x::Int, y::Int, r::Int, colour::Tuple{Int, Int, Int})
    draw_circle(window, x, y, r, (colour..., 255))
end

function draw_circle(window::Window, x::Int, y::Int, r::Int, colour::ColourRGBA)
    draw_circle(window, x, y, r, (colour.r, colour.g, colour.b, colour.a))
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

function draw_ellipse(window::Window, x::Int, y::Int, major::Int, minor::Int, colour::Tuple{Int, Int, Int, Int}; rotation::Real=0)
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    for theta in 0:0.01:2pi
        px = major*cos(theta)*cos(rotation) - minor*sin(theta)*sin(rotation) + x
        py = major*cos(theta)*sin(rotation) + minor*sin(theta)*cos(rotation) + y
        SDL_RenderDrawPoint(window.renderer, round(Int, px), round(Int, py))
    end
end

function draw_filled_ellipse(window::Window, x::Int, y::Int, major::Int, minor::Int, colour::Tuple{Int, Int, Int, Int}; rotation::Real=0)
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    r = max(major, minor)
    for dx in -r:r
        for dy in -r:r
            ddx = dx*cos(rotation) + dy*sin(rotation)
            ddy = dy*cos(rotation) - dx*sin(rotation)
            if (ddx/major)^2 + (ddy/minor)^2 <= 1
                SDL_RenderDrawPoint(window.renderer, round(Int, x + dx), round(Int, y + dy))
            end
        end
    end
end

function draw_rect(window::Window, x::Int, y::Int, w::Int, h::Int, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    draw_line(window, x, y, x+w, y, colour)
    draw_line(window, x+w, y, x+w, y+h, colour)
    draw_line(window, x, y+h, x+w, y+h, colour)
    draw_line(window, x, y, x, y+h, colour)
end

function draw_rect(window::Window, x::Int, y::Int, w::Int, h::Int, colour::Tuple{Int, Int, Int})
    draw_rect(window, x, y, w, h, (colour..., 255))
end

function draw_rect(window::Window, x::Int, y::Int, w::Int, h::Int, colour::ColourRGBA)
    draw_rect(window, x, y, w, h, (colour.r, colour.g, colour.b, colour.a))
end

function draw_filled_rect(window::Window, x::Int, y::Int, w::Int, h::Int, colour::Tuple{Int, Int, Int, Int})
    SDL_SetRenderDrawColor(window.renderer, colour...)
    SDL_SetRenderDrawBlendMode(window.renderer, SDL_BLENDMODE_BLEND)
    for px in x:x+w
        for py in y:y+h
            SDL_RenderDrawPoint(window.renderer, px, py)
        end
    end
end

function draw_filled_rect(window::Window, x::Int, y::Int, w::Int, h::Int, colour::Tuple{Int, Int, Int})
    draw_filled_rect(window, x, y, w, h, (colour..., 255))
end

function draw_filled_rect(window::Window, x::Int, y::Int, w::Int, h::Int, colour::ColourRGBA)
    draw_filled_rect(window, x, y, w, h, (colour.r, colour.g, colour.b, colour.a))
end

end
