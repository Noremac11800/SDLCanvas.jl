module Buttons

include("../common.jl")

export Button
export signals
export draw

using ..Colour
using ..Colours
using ..Display
using ..Fonts
using ..Draw
using ..Surfaces
using ..Events
using ..GUI
using ..Utils

import ..GUI: draw

mutable struct Button <: AbstractGUIElement
    label::String
    x::Int
    y::Int
    w::Int
    h::Int
    on_clicked::Function
    colour::ColourRGBA
    hover_colour::ColourRGBA
    pressed_colour::ColourRGBA
    border::Int
    border_colour::ColourRGBA
    visible::Bool
    active::Bool
    font_size::Int
    font::Font
    padding::Int
    pressed::Bool
    hovered::Bool
    _mouse_region::RectRegion
    _signals::Dict{String, Function}
    _draw::Function
end

function pressed(button::Button, event::SDL_Event)::Bool
    mx, my = get_mouse_pos()
    if is_contained(button._mouse_region)
        button.hovered = true
    else
        button.hovered = false
    end
    if is_mouse_held()
        if is_contained(button._mouse_region) && is_contained(button._mouse_region; pos=GLOBALS[].mouse_last_clicked_position)
            button.pressed = true
        end
    else
        if is_contained(button._mouse_region) && button.pressed && is_contained(button._mouse_region; pos=GLOBALS[].mouse_last_clicked_position)
            button.on_clicked(button)
        end
        button.pressed = false
    end
    return button.pressed
end

signals = Dict(
    "pressed" => pressed,
)

function Button(label::String, x::Int, y::Int;
                w::Int = 0,
                h::Int = 0,
                on_clicked::Function = (button::Button) -> (),
                colour::ColourRGBA = WHITE,
                hover_colour::ColourRGBA = LIGHTGREY,
                pressed_colour::ColourRGBA = DARKGREY,
                border::Int = 1,
                border_colour::ColourRGBA = BLACK,
                visible::Bool = true,
                active::Bool = true,
                font_size::Int = 20,
                font::Font = Font(joinpath(dirname(dirname(@__DIR__)), "assets", "sunnyspells.ttf"), font_size),
                padding::Int=10,
                pressed::Bool=false,
                hovered::Bool=false)

    return Button(label, x, y, w, h, on_clicked, colour, lighter(colour, 30), darker(colour, 30), border, border_colour, visible, active, font_size, font, padding, pressed, hovered, RectRegion(x, y, w, h), signals, draw)
end

function draw(window::Window, button::Button)
    text_surface = render_font(button.font, button.label, BLACK)
    if button.w == 0 || button.h == 0
        button.w, button.h = get_size(window, text_surface) .+ (button.padding*2, button.padding*2)
        button._mouse_region.x = button.x - button.padding
        button._mouse_region.y = button.y - button.padding
        button._mouse_region.w = button.w
        button._mouse_region.h = button.h
    end
    if button.label == ""
        button.padding = 0
    end
    if button.pressed
        draw_filled_rect(window,  button.x-button.padding, button.y-button.padding, button.w, button.h, button.pressed_colour)
    elseif button.hovered
        draw_filled_rect(window,  button.x-button.padding, button.y-button.padding, button.w, button.h, button.hover_colour)
    else
        draw_filled_rect(window,  button.x-button.padding, button.y-button.padding, button.w, button.h, button.colour)
    end
    draw_rect(window, button.x-button.padding, button.y-button.padding, button.w, button.h, button.border_colour)
    blit(window, text_surface, button.x, button.y)
end

end
