using Pkg; Pkg.activate(".")
using JLGame

window = create_window("JLGame", 800, 600)

function main()
    image = load_image("./assets/ship.png")

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
