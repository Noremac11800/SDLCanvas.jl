module Utils

export MouseRegion
export RectRegion
export CircleRegion
export is_contained

using ..Events

abstract type MouseRegion end

mutable struct RectRegion <: MouseRegion
    x::Int
    y::Int
    w::Int
    h::Int
    RectRegion(x, y, w, h) = new(x, y, w, h)
end

mutable struct CircleRegion <: MouseRegion
    x::Int
    y::Int
    r::Int
    CircleRegion(x, y, r) = new(x, y, r)
end

function is_contained(region::RectRegion; pos=(-1, -1))
    mx, my = pos
    if mx == -1 || my == -1
        mx, my = get_mouse_pos()
    end
    x, y, w, h = region.x, region.y, region.w, region.h
    return (x <= mx <= x + w) && (y <= my <= y + h)
end

function is_contained(region::CircleRegion; pos=(-1, -1))
    mx, my = pos
    if mx == -1 || my == -1
        mx, my = get_mouse_pos()
    end
    x, y, r = region.x, region.y, region.r
    return (mx-x)^2 + (my-y)^2 <= r^2
end

end