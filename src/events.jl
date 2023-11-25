module Events

include("common.jl")

export events_exist
export pop_event

EVENTS_REF = Ref{SDL_Event}()

function events_exist()::Bool
    return Bool(SDL_PollEvent(EVENTS_REF))
end

function pop_event()::SDL_Event
    return EVENTS_REF[]
end

end
