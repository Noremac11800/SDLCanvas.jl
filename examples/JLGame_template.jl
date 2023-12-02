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
