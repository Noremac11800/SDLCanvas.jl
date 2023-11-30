using Pkg; Pkg.activate(".")
using JLGame

window = create_window("JLGame", 800, 600)
bg_colour = WHITE

function change_bg_colour(button::Button)
    global bg_colour
    if bg_colour == button.hover_colour
        bg_colour = WHITE
    else
        bg_colour = button.hover_colour
    end
end

function main()
    gui_manager = GUI_Manager(window)
    red_button = Button("Press Me", 100, 200; on_clicked = change_bg_colour, colour=LIGHTRED)
    green_button = Button("No Press Me!", 300, 200; on_clicked = change_bg_colour, colour=LIGHTGREEN)
    blue_button = Button("I Want To Be Pressed!", 500, 200; on_clicked = change_bg_colour, colour=LIGHTBLUE)
    add_element(gui_manager, red_button)
    add_element(gui_manager, green_button)
    add_element(gui_manager, blue_button)

    clock = Clock(60)
    RUNNING = true
    while RUNNING
        while events_exist()
            event = pop_event()
            if event.type == QUIT
                RUNNING = false
                break
            end
            process_events(gui_manager, event)
        end

        splash(window, bg_colour)

        draw(gui_manager)
        
        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
