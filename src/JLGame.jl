module JLGame

include("common.jl")

export ColourRGBA
include("colour.jl")

export NAMED_COLOURS
export BLACK
export WHITE
export RED
export GREEN
export BLUE
export GREY
export LIGHTGREY
export DARKGREY
export YELLOW
export random_colour
export random_named_colour
export lighter
export darker
include("colours.jl")

export SCREEN_CENTER_X
export SCREEN_CENTER_Y
export Window
export create_window
export quit
export splash
export update_display
include("display.jl")

export Surface
export get_size
export get_center
export blit
include("surface.jl")

export draw_pixel
export draw_line
export draw_arc
export draw_filled_arc
export draw_circle
export draw_filled_circle
export draw_ellipse
export draw_filled_ellipse
export draw_rect
export draw_filled_rect
include("draw.jl")

export Clock
export tick
include("clock.jl")

export Font
export render_font
include("font.jl")

export events_exist
export pop_event
export is_key_pressed
export is_key_held
export QUIT
export K_ESCAPE
export K_SPACE
export K_ENTER
export K_RETURN
export K_A
export K_B
export K_C
export K_D
export K_E
export K_F
export K_G
export K_H
export K_I
export K_J
export K_K
export K_L 
export K_N
export K_O
export K_P
export K_Q
export K_R
export K_S
export K_T
export K_U
export K_V
export K_W
export K_X
export K_Y
export K_Z
include("events.jl")

using .Colour
using .Colours
using .Display
using .Surfaces
using .Draw
using .Time
using .Events
using .Fonts

end

# using .JLGame

# window = create_window("JLGame", 1000, 800)

# function main()
#     clock = Clock(60)
#     RUNNING = true
#     while RUNNING
#         while events_exist()
#             event = pop_event()
#             if event.type == QUIT
#                 RUNNING = false
#                 break
#             end
#         end

#         splash(window, BLACK)
        
#         draw_filled_circle(window, 300, 300, 50, ColourRGBA(255, 0, 0))
#         draw_filled_circle(window, 420, 300, 50, ColourRGBA(255, 0, 0, 100))
#         draw_filled_circle(window, 540, 300, 50, (0, 255, 0))
#         draw_filled_circle(window, 660, 300, 50, (0, 255, 0, 100))

#         update_display(window)

#         tick(clock)
#     end

#     quit(window)
# end

# main()
