module Images

include("common.jl")

export Image
export load_image
export blit

using ..Display
using ..Surfaces

# This is necessary when two different modules export the same function name
import ..Surfaces: blit

struct Image
    surface::Surface
    Image(path::String) = load_image(path)
    Image(surface::Surface) = new(surface)
end

function load_image(path::String)::Image
    surface = IMG_Load(path)
    if surface == C_NULL
        throw(error("Image could not be loaded"))
    end
    return Image(Surface(surface))
end

function blit(window::Window, image::Image, x::Int, y::Int; kwargs...)
    blit(window, image.surface, x, y; kwargs...)
end

end
