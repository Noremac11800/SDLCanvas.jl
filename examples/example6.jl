using Pkg; Pkg.activate(".")
using JLGame

window = create_window("JLGame", 800, 600)

function main()
    font = Font("sunnyspells", 20)
    surface = render_font(font, "This is some text", BLACK)

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
        
        draw_circle(window, 400, 300, 100, BLACK)
        blit(window, surface, 400, 300)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
