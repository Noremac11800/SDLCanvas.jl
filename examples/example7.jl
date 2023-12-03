using Pkg; Pkg.activate(dirname(@__DIR__))
using SDLCanvas

window = create_window("SDLCanvas", 800, 600)

function main()
    image = load_image(joinpath(dirname(@__DIR__), "assets", "ship.png"))

    clock = Clock(60)
    RUNNING = true
    while RUNNING
        while events_exist()
            event = pop_event()
            if event.type == QUIT
                RUNNING = false
                break
            end
        end

        splash(window, WHITE)
        
        blit(window, image, 400, 300)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
