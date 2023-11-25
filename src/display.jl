module Display

include("common.jl")

export SCREEN_CENTER_X
export SCREEN_CENTER_Y
export Window
export create_window
export quit
export splash
export update_display

SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 16)
SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 16)

@assert SDL_Init(SDL_INIT_EVERYTHING) == 0 "error initializing SDL: $(unsafe_string(SDL_GetError()))"

SCREEN_CENTER_X = SDL_WINDOWPOS_CENTERED
SCREEN_CENTER_Y = SDL_WINDOWPOS_CENTERED

struct Window
    sdl_window::Ptr{SDL_Window}
    renderer::Ptr{SDL_Renderer}
    title::String
    w::Int
    h::Int
    x::Int
    y::Int
    flags::Dict{Any, Any}
end

function create_window(title::String, w::Int, h::Int, x::Int=SCREEN_CENTER_X, y::Int=SCREEN_CENTER_Y; flags...)::Window
    window = SDL_CreateWindow(title, x, y, w, h, SDL_WINDOW_SHOWN)
    SDL_SetWindowResizable(window, SDL_TRUE)
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC)
    return Window(window, renderer, title, w, h, x, y, flags)
end

function quit(window::Window)
    SDL_DestroyRenderer(window.renderer)
    SDL_DestroyWindow(window.sdl_window)
    SDL_Quit()
    exit()
end

function splash(window::Window, r::Int, g::Int, b::Int, a::Int=255)
    SDL_SetRenderDrawColor(window.renderer, r, g, b, a);
    SDL_RenderClear(window.renderer);
end

function update_display(window::Window)
    SDL_RenderPresent(window.renderer)
end

end
