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
using ..Fonts
using ..Colours
using ..Surfaces

abstract type AbstractGUIElement end

mutable struct Globals
    last_frame_time::Float64
    time_since_last_frame::Float64
    mouse_last_clicked_position::Tuple{Int, Int}
    Globals() = new(time(), 0.0, (0, 0))
end

global const GLOBALS = Ref{Globals}(Globals())

struct GUI_Manager
    window::Window
    elements::Vector{AbstractGUIElement}
    show_fps::Bool
    GUI_Manager(window; show_fps=false) = new(window, Vector{AbstractGUIElement}(), show_fps)
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
    GLOBALS[].time_since_last_frame = time() - GLOBALS[].last_frame_time
    GLOBALS[].last_frame_time = time()
    fps = round(Int, 1/GLOBALS[].time_since_last_frame)
    for element in manager.elements
        element._draw(manager.window, element)
    end

    if manager.show_fps
        font = Font(joinpath(dirname(dirname(@__DIR__)), "assets", "swansea.ttf"), 20)
        surface = render_font(font, "FPS = $fps", BLACK)
        blit(manager.window, surface, manager.window.w - 100, 20)
    end 
end

end
