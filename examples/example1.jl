using Pkg; Pkg.activate(dirname(@__DIR__))
using JLGame

function draw_ring(window::Window; n_circles=100, ring_radius = 200, circle_radius=10)
    cx = window.w / 2
    cy = window.h / 2
    for n in 1:n_circles
        theta = n/n_circles*2pi
        x, y = round(Int, ring_radius*cos(theta) + cx), round(Int, ring_radius*sin(theta) + cy)
        colour = random_colour(150)
        draw_filled_circle(window, x, y, circle_radius, colour)
    end
end

window = create_window("JLGame", 800, 600)

function main()
    r = 200
    speed = 3
    direction = -1

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

        direction = r < 50 || r > 200 ? -direction : direction
        r += direction * speed

        splash(window, WHITE)
        draw_ring(window, ring_radius=r)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
