using Pkg; Pkg.activate(dirname(@__DIR__))
using JLGame

window = create_window("JLGame", 800, 600)

shape_func = draw_circle

shapes = []

function change_shape(func::Function)
    global shape_func = func
end

function main()
    gui_manager = GUI_Manager(window)
    circle_button = Button("", 20, 20; w = 50, h = 50, on_clicked = (_) -> change_shape(draw_circle), colour=LIGHTBLUE)
    filled_circle_button = Button("", 90, 20; w = 50, h = 50, on_clicked = (_) -> change_shape(draw_filled_circle), colour=LIGHTBLUE)
    square_button = Button("", 160, 20; w = 50, h = 50, on_clicked = (_) -> change_shape(draw_rect), colour=LIGHTBLUE)
    filled_square_button = Button("", 230, 20; w = 50, h = 50, on_clicked = (_) -> change_shape(draw_filled_rect), colour=LIGHTBLUE)
    undo_button = Button("UNDO", 800-70, 20; on_clicked = (_) -> if !isempty(shapes) pop!(shapes) end, colour=LIGHTRED)
    add_element(gui_manager, circle_button)
    add_element(gui_manager, filled_circle_button)
    add_element(gui_manager, square_button)
    add_element(gui_manager, filled_square_button)
    add_element(gui_manager, undo_button)

    clock = Clock(60)
    RUNNING = true
    while RUNNING
        splash(window, WHITE)

        while events_exist()
            event = pop_event()
            if event.type == QUIT
                RUNNING = false
                break
            end
            event_occurred = process_events(gui_manager, event)

            if mouse_clicked(event) && !event_occurred
                mx, my = get_mouse_pos()
                if shape_func == draw_circle
                    push!(shapes, ("circle", mx, my))
                end
                if shape_func == draw_filled_circle
                    push!(shapes, ("filled_circle", mx, my))
                end
                if shape_func == draw_rect
                    push!(shapes, ("rect", mx, my))
                end
                if shape_func == draw_filled_rect
                    push!(shapes, ("filled_rect", mx, my))
                end
            end
        end

        for (shape, x, y) in shapes
            if shape == "circle"
                draw_circle(window, x, y, 20, BLACK)
            end
            if shape == "filled_circle"
                draw_filled_circle(window, x, y, 20, BLACK)
            end
            if shape == "rect"
                draw_rect(window, x, y, 40, 40, BLACK)
            end
            if shape == "filled_rect"
                draw_filled_rect(window, x, y, 40, 40, BLACK)
            end
        end

        draw(gui_manager)

        draw_circle(window, 45, 45, 20, BLACK)
        draw_filled_circle(window, 115, 45, 20, BLACK)
        draw_rect(window, 170, 30, 30, 30, BLACK)
        draw_filled_rect(window, 240, 30, 30, 30, BLACK)
        
        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
