
using JLGame

window = create_window("JLGame", SCREEN_CENTER_X, SCREEN_CENTER_Y, 1000, 800)

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

        splash(window, 96, 128, 255)
        
        draw_filled_circle(window, 300, 300, 50, ColourRGBA(255, 0, 0))
        draw_filled_circle(window, 420, 300, 50, ColourRGBA(255, 0, 0, 100))
        draw_filled_circle(window, 540, 300, 50, (0, 255, 0))
        draw_filled_circle(window, 660, 300, 50, (0, 255, 0, 100))

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
