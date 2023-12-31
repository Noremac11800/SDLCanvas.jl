[![Build Status](https://github.com/cam/SDLCanvas.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/cam/SDLCanvas.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Welcome to SDLCanvas.jl!

Please see the [wiki](https://github.com/Noremac11800/SDLCanvas.jl/wiki) for a more detailed explanation of what SDLCanvas has to offer, and some very basic documentation for its API.

SDLCanvas is completely inspired by the [pygame](https://www.pygame.org/docs/) C/Python library which is designed for creating 2D (and sometimes 3D) games using SDL2. Despite the confusing name, SDLCanvas is not designed for creating video games, although there's nothing stopping you from trying! I originally designed the library as a higher level interface into the [SDL2](https://github.com/JuliaMultimedia/SimpleDirectMediaLayer.jl) bindings for Julia to create basic graphics, image rendering, and font rendering. 

The library is extremely bare-bones and lacks MOST of the features a developer would expect from a modern graphics library (anti-aliasing being one of the sore spots). It doesn't have collision detection, clipping, lighting, occlusion, cameras, or any of the bells and whistles of a game engine (because it isn't one)!

What it can do is draw shape primitives like lines, circles, and rectangles, render text and images, and comes with a GUI manager which currently only has a simple button implemented.

The "examples/" directory in the root of the repo has a series of strangely organised examples of how to use most of the features that already exist in the library.

## Installation

Using Julia's package manager, SDLCanvas and its dependencies can be installed via:

```
using Pkg; Pkg.add("SDLCanvas")
```

, or alternatively in the Julia REPL:

```
julia> ]
pkg> add SDLCanvas
```

## Getting Started

The "examples/" directory in the repo contains a `SDLCanvas_template.jl` which is a bare-bones program designed to display an empty black window. However for convenience, the template code is below:

```Julia
using SDLCanvas

window = create_window("SDLCanvas", 800, 600)

function main()
    clock = Clock(60)
    RUNNING = true
    while RUNNING
        while events_exist()
            event = pop_event()
            if event.type == QUIT || is_key_pressed(event, K_ESCAPE)
                RUNNING = false
                break
            end
        end

        splash(window, BLACK)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
```

## Examples

### examples/example1.jl
Drawing animated circles

### examples/example2.jl
Animated scrolling starfield

### examples/example3.jl
Spinning loading circle

### examples/example4.jl
WASD-player-controlled square

### examples/example5.jl
Animated, rotating ellipses

### examples/example6.jl
Displaying text centered relative to the surface's center

### examples/example7.jl
Displaying a PNG

### examples/example8.jl
Drawing circles according to mouse position and button clicked.
Left click = Draw single filled red circle
Hold right click = Draw filled green circle every frame

### examples/example9.jl
GUI manager and button demo

### examples/example10.jl
Very simple shape-painting app demo
