using Pkg; Pkg.activate(dirname(@__DIR__))
using JLGame

window = create_window("JLGame", 800, 600)

circles1 = []
circles2 = []

function main()
    gui_manager = GUI_Manager(window; show_fps = true)

    clock = Clock(60)
    RUNNING = true
    while RUNNING
        while events_exist()
            event = pop_event()
            if event.type == QUIT
                RUNNING = false
                break
            end
            if mouse_clicked(event)
                push!(circles1, get_mouse_pos())
            end
            if is_mouse_held(MOUSE_RIGHT)
                push!(circles2, get_mouse_pos())
            end
        end

        splash(window, WHITE)
        
        for (x, y) in circles1
            draw_filled_circle(window, x, y, 20, RED)
        end
        for (x, y) in circles2
            draw_filled_circle(window, x, y, 20, GREEN)
        end

        draw(gui_manager)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
