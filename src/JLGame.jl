module JLGame

include("common.jl")

export ColourRGBA
include("colour.jl")

export NAMED_COLOURS
export BLACK
export WHITE
export RED
export LIGHTRED
export GREEN
export LIGHTGREEN
export BLUE
export LIGHTBLUE
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

export Image
export load_image
export blit
include("images.jl")

export events_exist
export pop_event
export get_mouse_pos
export mouse_clicked
export is_mouse_held
export is_key_pressed
export is_key_held
export QUIT
export MOUSE_LEFT
export MOUSE_RIGHT
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
using .Images

###########################################################

export GUI_Manager
export AbstractGUIElement
export process_events
export add_element
export draw
include("GUI/gui_manager.jl")

export Button
export signals
export draw
include("GUI/button.jl")

using .GUI
using .Buttons

end
