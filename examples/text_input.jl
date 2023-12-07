using Pkg; Pkg.activate(".")
using SDLCanvas
using SimpleDirectMediaLayer
using SimpleDirectMediaLayer.LibSDL2

window = create_window("SDLCanvas", 800, 600)

function main()
    SDL_StartTextInput()
    text = ""
    font = Font("/Users/cam/Documents/GitBucket/Development/SDLCanvas-Github/SDLCanvas/assets/swansea.ttf", 24)
    surface = render_font(font, "Stuff", BLACK)
    clock = Clock(60)
    RUNNING = true
    while RUNNING
        while events_exist()
            event = pop_event()
            if event.type == QUIT || is_key_pressed(event, K_ESCAPE)
                RUNNING = false
                break
            end
            if is_key_pressed(event, K_BACKSPACE)
                if length(text) != 0
                    text = text[1:end-1]
                    surface = render_font(font, text, BLACK)
                end
            end
            if event.type == SDL_TEXTINPUT
                text *= string(Char(event.text.text[1]))
                surface = render_font(font, text, BLACK)
            end
            if event.type == SDL_TEXTEDITING
                composition = event.edit.text
                cursor = event.edit.start
                selection_len = event.edit.length
            end
        end

        splash(window, WHITE)

        blit(window, surface, 200, 200)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
