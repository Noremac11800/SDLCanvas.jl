module Display

using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

export RENDERER
export SCREEN_CENTER_X
export SCREEN_CENTER_Y
export create_window
export quit

SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 16)
SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 16)

@assert SDL_Init(SDL_INIT_EVERYTHING) == 0 "error initializing SDL: $(unsafe_string(SDL_GetError()))"

SCREEN_CENTER_X = SDL_WINDOWPOS_CENTERED
SCREEN_CENTER_Y = SDL_WINDOWPOS_CENTERED

struct Window
    sdl_window::Ptr{SDL_Window}
    title::String
    x::Int
    y::Int
    w::Int
    h::Int
    flags::Dict{Any, Any}
end

function create_window(title::String, x::Int, y::Int, w::Int, h::Int; flags...)::Window
    window = SDL_CreateWindow(title, x, y, w, h, SDL_WINDOW_SHOWN)
    SDL_SetWindowResizable(window, SDL_TRUE)
    global RENDERER = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
    return Window(window, title, x, y, w, h, flags)
end

function quit(window::Window)
    SDL_DestroyRenderer(RENDERER)
    SDL_DestroyWindow(window.sdl_window)
    SDL_Quit()
    exit()
end

end
