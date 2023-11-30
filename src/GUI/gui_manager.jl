module GUI

include("../common.jl")

export GLOBALS
export GUI_Manager
export AbstractGUIElement
export process_events
export add_element
export draw

using ..Display
using ..Events

abstract type AbstractGUIElement end

mutable struct Globals
    mouse_last_clicked_position::Tuple{Int, Int}
    Globals() = new((0, 0))
end

global const GLOBALS = Ref{Globals}(Globals())

struct GUI_Manager
    window::Window
    elements::Vector{AbstractGUIElement}
    GUI_Manager(window) = new(window, Vector{AbstractGUIElement}())
end

function process_events(manager::GUI_Manager, event::SDL_Event)::Bool
    if mouse_clicked(event)
        GLOBALS[].mouse_last_clicked_position = get_mouse_pos()
    end

    signal_fired = false
    for element in manager.elements
        sigs = element._signals
        for (sig_name, sig) in pairs(sigs)
            if sig(element, event)
                signal_fired = true
            end
        end
    end
    return signal_fired
end

function add_element(manager::GUI_Manager, element::AbstractGUIElement)
    push!(manager.elements, element)
end

function draw(manager::GUI_Manager)
    for element in manager.elements
        element._draw(manager.window, element)
    end
end

end
