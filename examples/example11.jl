using SDLCanvas

window = create_window("SDLCanvas", 800, 600)

function main()
    font = Font(joinpath(dirname(@__DIR__), "assets", "swansea.ttf"), 24)
    display_text = "This is some slow printing text... Pretty cool!"
    time_to_display = 5.0
    frame_count = 0

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

        frame_count += 1
        percent_to_show = clamp(frame_count / (time_to_display * 60), 0, 1)
        end_index = round(Int, percent_to_show * length(display_text))

        splash(window, WHITE)
        surface = render_font(font, display_text[1:end_index], BLACK)
        blit(window, surface, 400, 300; centered=true)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
