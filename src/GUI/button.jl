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
    _signals::Dict{String, Function}
    _draw::Function
end

function pressed(button::Button, event::SDL_Event)::Bool
    mx, my = get_mouse_pos()
    x, y, w, h = button.x, button.y, button.w, button.h
    p = button.padding
    if x-p < mx < x+w-p && y-p < my < y+h-p
        button.hovered = true
    else
        button.hovered = false
    end
    if is_mouse_held()
        if x-p < mx < x+w-p && y-p < my < y+h-p
            button.pressed = true
        end
    else
        if x-p < mx < x+w-p && y-p < my < y+h-p && button.pressed
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
                on_clicked::Function = () => (),
                colour::ColourRGBA = WHITE,
                hover_colour::ColourRGBA = LIGHTGREY,
                pressed_colour::ColourRGBA = DARKGREY,
                border::Int = 1,
                border_colour::ColourRGBA = BLACK,
                visible::Bool = true,
                active::Bool = true,
                font_size::Int = 20,
                font::Font = Font("/Users/cam/Documents/GitBucket/JLGame/assets/sunnyspells.ttf", font_size),
                padding::Int=10,
                pressed::Bool=false,
                hovered::Bool=false)

    return Button(label, x, y, w, h, on_clicked, colour, lighter(colour, 50), darker(colour, 50), border, border_colour, visible, active, font_size, font, padding, pressed, hovered, signals, draw)
end

function draw(window::Window, button::Button)
    text_surface = render_font(button.font, button.label, BLACK)
    if button.w == 0 || button.h == 0
        button.w, button.h = get_size(window, text_surface) .+ (button.padding*2, button.padding*2)
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
