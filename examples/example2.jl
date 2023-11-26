using Pkg; Pkg.activate(".")
using JLGame

STARS = [(rand(0:800), rand(0:600)) for _ in 1:300];

window = create_window("JLGame", 800, 600)

function draw_starfield()
    for (i, (x, y)) in enumerate(STARS)
        if i % 4 == 0
            speed = 1
        elseif i % 3 == 0
            speed = 2
        elseif i % 2 == 0
            speed = 3
        elseif i % 1 == 0
            speed = 4
        end
        new_x = x + speed > 800 ? 0 : x + speed
        STARS[i] = (new_x, y)
        draw_filled_circle(window, new_x, y, 1, WHITE)
    end
end

function main()
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

        splash(window, BLACK)

        draw_starfield()

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
