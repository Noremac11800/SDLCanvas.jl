[![Build Status](https://github.com/cam/JLGame.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/cam/JLGame.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Welcome to JLGame.jl!

Please see the [wiki](http://192.168.1.21:8080/cam/JLGame.jl/wiki/Home) for a more detailed explanation of what JLGame has to offer, and some very basic documentation for its API.

JLGame is completely inspired by the [pygame](https://www.pygame.org/docs/) C/Python library which is designed for creating 2D (and sometimes 3D) games using SDL2. Despite the confusing name, JLGame is not designed for creating video games, although there's nothing stopping you from trying! I originally designed the library as a higher level interface into the [SDL2](https://github.com/JuliaMultimedia/SimpleDirectMediaLayer.jl) bindings for Julia to create basic graphics, image rendering, and font rendering. 

The library is extremely bare-bones and lacks MOST of the features a developer would expect from a modern graphics library (anti-aliasing being one of the sore spots). It doesn't have collision detection, clipping, lighting, occlusion, cameras, or any of the bells and whistles of a game engine (because it isn't one)!

What it can do is draw shape primitives like lines, circles, and rectangles, render text and images, and comes with a GUI manager which currently only has a simple button implemented.

The "examples/" directory in the root of the repo has a series of strangely organised examples of how to use most of the features that already exist in the library.

## Installation

Using Julia's package manager, JLGame and its dependencies can be installed via:

```using Pkg; Pkg.add("JLGame")```

, or alternatively in the Julia REPL:

```
julia> ]
pkg> add JLGame
```

## Getting Started

The "examples/" directory in the repo contains a `JLGame_template.jl` which is a bare-bones program designed to display an empty black window. However for convenience, the template code is below:

```Julia
using JLGame

window = create_window("JLGame", 800, 600)

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

## Trouble Shooting

## Contributing
