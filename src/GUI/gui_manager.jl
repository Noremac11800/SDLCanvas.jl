module GUI

include("../common.jl")

export GUI_Manager
export AbstractGUIElement
export process_events
export add_element
export draw

using ..Display
using ..Events

abstract type AbstractGUIElement end

struct GUI_Manager
    window::Window
    elements::Vector{AbstractGUIElement}
    GUI_Manager(window) = new(window, Vector{AbstractGUIElement}())
end

function process_events(manager::GUI_Manager, event::SDL_Event)
    mouse_clicked(event)
    for element in manager.elements
        sigs = element._signals
        for (sig_name, sig) in pairs(sigs)
            sig(element, event)
        end
    end
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
