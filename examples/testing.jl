using Pkg; Pkg.activate(".")
using JLGame

window = create_window("JLGame", 800, 600)

function main()
    a = 0
    b = 0
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
        end

        a += 0.05
        if a > 2pi
            a = 0
        end

        b += 0.02
        if b > 2pi
            b = 0
        end

        splash(window, WHITE)

        draw_ellipse(window, 400, 300, 60, 100, (255, 0, 0, 255); rotation=a)
        draw_filled_ellipse(window, 600, 300, 60, 100, (0, 255, 0, 255); rotation=b)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
