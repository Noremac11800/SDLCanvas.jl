module Draw

using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

export draw_filled_circle

function draw_filled_circle(renderer::Ptr{SDL_Renderer}, x::Int, y::Int, radius::Int)
    for dy in -radius:radius
        for dx in -radius:radius
            if (dx^2 + dy^2 <= radius^2)
                SDL_RenderDrawPoint(renderer, x+dx, y+dy)
            end
        end
    end
end

end