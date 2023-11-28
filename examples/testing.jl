using Pkg; Pkg.activate(".")
using JLGame

window = create_window("JLGame", 800, 600)

circles = []

function main()
    clock = Clock(60)
    RUNNING = true
    while RUNNING
        splash(window, BLACK)

        while events_exist()
            event = pop_event()
            if event.type == QUIT
                RUNNING = false
                break
            end

            if is_key_pressed(event, K_SPACE)
                push!(circles, (rand(1:800), rand(1:600)))
            end
        end

        for (x, y) in circles
            draw_filled_circle(window, x, y, 20, WHITE)
        end

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
