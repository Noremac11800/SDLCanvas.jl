module TextInputs

include("../common.jl")

export TextInput
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

struct TextInput <: AbstractGUIElement
    text::String
    x::Int
    y::Int
    w::Int
    h::Int
    _signals::Dict{String, Function}
    _draw::Function
end

signals = Dict(
    "confirmed" => confirmed,
)

function TextInput(text::String, x::Int, y::Int;
                   w::Int,
                   h::Int)
    return TextInput(text, x, y, w, h, signals, draw)
end

function confirmed(textInput::TextInput, event::SDL_Event)::Bool

end

function draw(window::Window, textInput::TextInput)
    
end

end