using SDLCanvas

window = create_window("SDLCanvas", 800, 600)

function main()
    da = 0
    db = 0

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
        
        da += 0.1
        if da > 2pi
            da = 0
            db = 0
        end
        if db < 2pi
            db += 0.1
        end

        splash(window, WHITE)

        draw_filled_circle(window, 400, 300, 50, DARKGREY)
        draw_filled_circle(window, 400, 300, 45, WHITE)
        draw_filled_arc(window, 400, 300, 45, da, da+db, lighter(YELLOW, 100))

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
