using Pkg; Pkg.activate(".")
using JLGame

using Dates

window = create_window("JLGame", 200, 60)

function read_file()
    if !isfile("/Users/cam/Documents/Home/worth.txt")
        write_file(time())
    end

    file = open("/Users/cam/Documents/Home/worth.txt", "r")
    lines = []
    for line in eachline(file)
        push!(lines, parse(Float64, line))
    end
    close(file)
    return lines
end

function write_file(start_time)
    file = open("/Users/cam/Documents/Home/worth.txt", "w")
    write(file, "$start_time\n")
    close(file)
end

function main()
    money_per_year = 80000.0
    money_per_second = money_per_year/365/24/60/60
    start_time = read_file()[1]
    font = Font("/Users/cam/Documents/GitBucket/JLGame/assets/swansea.ttf", 40)

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

        total_money = (time()-start_time)*money_per_second
        display_money = round(total_money, digits=2)
        text = render_font(font, "\$$display_money", LIGHTGREEN)
        blit(window, text, 10, 10)

        update_display(window)

        tick(clock)
    end

    quit(window)
end

main()
