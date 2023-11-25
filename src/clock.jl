module Time

include("common.jl")

export Clock
export tick

struct Clock
    fps::Int
    Clock(fps) = new(fps)
end

function tick(clock::Clock)
    SDL_Delay(1000 ÷ clock.fps)
end

end
