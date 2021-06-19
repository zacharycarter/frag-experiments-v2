# when defined(windows):
  # {.passL: "-lkernel32 -luser32 -lshell32 -ldxgi -ldxguid -ld3d11 -lole32".}

{.compile: "./sokol.c".}

# sokol_app.h
const
  SAPP_MAX_TOUCHPOINTS* = 8
  SAPP_MAX_MOUSEBUTTONS* = 3
  SAPP_MAX_KEYCODES* = 512
  SAPP_MAX_ICONIMAGES* = 8

type
  sapp_event_type* {.size: sizeof(int32).} = enum
    SAPP_EVENTTYPE_INVALID, SAPP_EVENTTYPE_KEY_DOWN, SAPP_EVENTTYPE_KEY_UP,
    SAPP_EVENTTYPE_CHAR, SAPP_EVENTTYPE_MOUSE_DOWN, SAPP_EVENTTYPE_MOUSE_UP,
    SAPP_EVENTTYPE_MOUSE_SCROLL, SAPP_EVENTTYPE_MOUSE_MOVE,
    SAPP_EVENTTYPE_MOUSE_ENTER, SAPP_EVENTTYPE_MOUSE_LEAVE,
    SAPP_EVENTTYPE_TOUCHES_BEGAN, SAPP_EVENTTYPE_TOUCHES_MOVED,
    SAPP_EVENTTYPE_TOUCHES_ENDED, SAPP_EVENTTYPE_TOUCHES_CANCELLED,
    SAPP_EVENTTYPE_RESIZED, SAPP_EVENTTYPE_ICONIFIED, SAPP_EVENTTYPE_RESTORED,
    SAPP_EVENTTYPE_SUSPENDED, SAPP_EVENTTYPE_RESUMED,
    SAPP_EVENTTYPE_UPDATE_CURSOR, SAPP_EVENTTYPE_QUIT_REQUESTED,
    SAPP_EVENTTYPE_CLIPBOARD_PASTED, SAPP_EVENTTYPE_FILES_DROPPED,
    SAPP_EVENTTYPE_NUM, SAPP_EVENTTYPE_FORCE_U32 = 0x7FFFFFFF
  sapp_keycode* {.size: sizeof(int32).} = enum
    SAPP_KEYCODE_INVALID = 0, SAPP_KEYCODE_SPACE = 32, SAPP_KEYCODE_APOSTROPHE = 39,
    SAPP_KEYCODE_COMMA = 44, SAPP_KEYCODE_MINUS = 45, SAPP_KEYCODE_PERIOD = 46,
    SAPP_KEYCODE_SLASH = 47, SAPP_KEYCODE_0 = 48, SAPP_KEYCODE_1 = 49,
    SAPP_KEYCODE_2 = 50, SAPP_KEYCODE_3 = 51, SAPP_KEYCODE_4 = 52, SAPP_KEYCODE_5 = 53,
    SAPP_KEYCODE_6 = 54, SAPP_KEYCODE_7 = 55, SAPP_KEYCODE_8 = 56, SAPP_KEYCODE_9 = 57,
    SAPP_KEYCODE_SEMICOLON = 59, SAPP_KEYCODE_EQUAL = 61, SAPP_KEYCODE_A = 65,
    SAPP_KEYCODE_B = 66, SAPP_KEYCODE_C = 67, SAPP_KEYCODE_D = 68, SAPP_KEYCODE_E = 69,
    SAPP_KEYCODE_F = 70, SAPP_KEYCODE_G = 71, SAPP_KEYCODE_H = 72, SAPP_KEYCODE_I = 73,
    SAPP_KEYCODE_J = 74, SAPP_KEYCODE_K = 75, SAPP_KEYCODE_L = 76, SAPP_KEYCODE_M = 77,
    SAPP_KEYCODE_N = 78, SAPP_KEYCODE_O = 79, SAPP_KEYCODE_P = 80, SAPP_KEYCODE_Q = 81,
    SAPP_KEYCODE_R = 82, SAPP_KEYCODE_S = 83, SAPP_KEYCODE_T = 84, SAPP_KEYCODE_U = 85,
    SAPP_KEYCODE_V = 86, SAPP_KEYCODE_W = 87, SAPP_KEYCODE_X = 88, SAPP_KEYCODE_Y = 89,
    SAPP_KEYCODE_Z = 90, SAPP_KEYCODE_LEFT_BRACKET = 91, SAPP_KEYCODE_BACKSLASH = 92,
    SAPP_KEYCODE_RIGHT_BRACKET = 93, SAPP_KEYCODE_GRAVE_ACCENT = 96,
    SAPP_KEYCODE_WORLD_1 = 161, SAPP_KEYCODE_WORLD_2 = 162, SAPP_KEYCODE_ESCAPE = 256,
    SAPP_KEYCODE_ENTER = 257, SAPP_KEYCODE_TAB = 258, SAPP_KEYCODE_BACKSPACE = 259,
    SAPP_KEYCODE_INSERT = 260, SAPP_KEYCODE_DELETE = 261, SAPP_KEYCODE_RIGHT = 262,
    SAPP_KEYCODE_LEFT = 263, SAPP_KEYCODE_DOWN = 264, SAPP_KEYCODE_UP = 265,
    SAPP_KEYCODE_PAGE_UP = 266, SAPP_KEYCODE_PAGE_DOWN = 267, SAPP_KEYCODE_HOME = 268,
    SAPP_KEYCODE_END = 269, SAPP_KEYCODE_CAPS_LOCK = 280,
    SAPP_KEYCODE_SCROLL_LOCK = 281, SAPP_KEYCODE_NUM_LOCK = 282,
    SAPP_KEYCODE_PRINT_SCREEN = 283, SAPP_KEYCODE_PAUSE = 284, SAPP_KEYCODE_F1 = 290,
    SAPP_KEYCODE_F2 = 291, SAPP_KEYCODE_F3 = 292, SAPP_KEYCODE_F4 = 293,
    SAPP_KEYCODE_F5 = 294, SAPP_KEYCODE_F6 = 295, SAPP_KEYCODE_F7 = 296,
    SAPP_KEYCODE_F8 = 297, SAPP_KEYCODE_F9 = 298, SAPP_KEYCODE_F10 = 299,
    SAPP_KEYCODE_F11 = 300, SAPP_KEYCODE_F12 = 301, SAPP_KEYCODE_F13 = 302,
    SAPP_KEYCODE_F14 = 303, SAPP_KEYCODE_F15 = 304, SAPP_KEYCODE_F16 = 305,
    SAPP_KEYCODE_F17 = 306, SAPP_KEYCODE_F18 = 307, SAPP_KEYCODE_F19 = 308,
    SAPP_KEYCODE_F20 = 309, SAPP_KEYCODE_F21 = 310, SAPP_KEYCODE_F22 = 311,
    SAPP_KEYCODE_F23 = 312, SAPP_KEYCODE_F24 = 313, SAPP_KEYCODE_F25 = 314,
    SAPP_KEYCODE_KP_0 = 320, SAPP_KEYCODE_KP_1 = 321, SAPP_KEYCODE_KP_2 = 322,
    SAPP_KEYCODE_KP_3 = 323, SAPP_KEYCODE_KP_4 = 324, SAPP_KEYCODE_KP_5 = 325,
    SAPP_KEYCODE_KP_6 = 326, SAPP_KEYCODE_KP_7 = 327, SAPP_KEYCODE_KP_8 = 328,
    SAPP_KEYCODE_KP_9 = 329, SAPP_KEYCODE_KP_DECIMAL = 330,
    SAPP_KEYCODE_KP_DIVIDE = 331, SAPP_KEYCODE_KP_MULTIPLY = 332,
    SAPP_KEYCODE_KP_SUBTRACT = 333, SAPP_KEYCODE_KP_ADD = 334,
    SAPP_KEYCODE_KP_ENTER = 335, SAPP_KEYCODE_KP_EQUAL = 336,
    SAPP_KEYCODE_LEFT_SHIFT = 340, SAPP_KEYCODE_LEFT_CONTROL = 341,
    SAPP_KEYCODE_LEFT_ALT = 342, SAPP_KEYCODE_LEFT_SUPER = 343,
    SAPP_KEYCODE_RIGHT_SHIFT = 344, SAPP_KEYCODE_RIGHT_CONTROL = 345,
    SAPP_KEYCODE_RIGHT_ALT = 346, SAPP_KEYCODE_RIGHT_SUPER = 347,
    SAPP_KEYCODE_MENU = 348
  sapp_touchpoint* {.bycopy.} = object
    identifier*: uint
    pos_x*: cfloat
    pos_y*: cfloat
    changed*: bool

  sapp_mousebutton* {.size: sizeof(int32).} = enum
    SAPP_MOUSEBUTTON_LEFT = 0x00000000, SAPP_MOUSEBUTTON_RIGHT = 0x00000001,
    SAPP_MOUSEBUTTON_MIDDLE = 0x00000002, SAPP_MOUSEBUTTON_INVALID = 0x00000100




const
  SAPP_MODIFIER_SHIFT* = 0x00000001
  SAPP_MODIFIER_CTRL* = 0x00000002
  SAPP_MODIFIER_ALT* = 0x00000004
  SAPP_MODIFIER_SUPER* = 0x00000008

type
  sapp_event* {.bycopy.} = object
    frame_count*: uint64
    `type`*: sapp_event_type
    key_code*: sapp_keycode
    char_code*: uint32
    key_repeat*: bool
    modifiers*: uint32
    mouse_button*: sapp_mousebutton
    mouse_x*: cfloat
    mouse_y*: cfloat
    mouse_dx*: cfloat
    mouse_dy*: cfloat
    scroll_x*: cfloat
    scroll_y*: cfloat
    num_touches*: int32
    touches*: array[SAPP_MAX_TOUCHPOINTS, sapp_touchpoint]
    window_width*: int32
    window_height*: int32
    framebuffer_width*: int32
    framebuffer_height*: int32
  
  sapp_range* {.bycopy.} = object
    p {.importc: "ptr".}: pointer
    size: uint

  sapp_image_desc* {.bycopy.} = object
    width: int32
    height: int32
    pixels: sapp_range

  sapp_icon_desc* {.bycopy.} = object
    sokolDefault*: bool
    images*: array[SAPP_MAX_ICONIMAGES, sapp_image_desc]

  sapp_desc* {.bycopy.} = object
    init_cb*: proc () {.cdecl.}
    frame_cb*: proc () {.cdecl.}
    cleanup_cb*: proc () {.cdecl.}
    event_cb*: proc (a1: ptr sapp_event) {.cdecl.}
    fail_cb*: proc (a1: cstring) {.cdecl.}
    user_data*: pointer
    init_userdata_cb*: proc (a1: pointer) {.cdecl.}
    frame_userdata_cb*: proc (a1: pointer) {.cdecl.}
    cleanup_userdata_cb*: proc (a1: pointer) {.
        cdecl.}
    event_userdata_cb*: proc (a1: ptr sapp_event;
        a2: pointer) {.cdecl.}
    fail_userdata_cb*: proc (a1: cstring; a2: pointer) {.
        cdecl.}
    width*: int32
    height*: int32
    sample_count*: int32
    swap_interval*: int32
    high_dpi*: bool
    fullscreen*: bool
    alpha*: bool
    window_title*: cstring
    user_cursor*: bool
    enable_clipboard*: bool
    clipboard_size*: int32
    enable_dragndrop*: bool
    max_dropped_files*: int32
    max_dropped_file_path_length*: int32
    icon*: sapp_icon_desc

    gl_force_gles2*: bool
    win32_console_utf8*: bool
    win32_console_create*: bool
    win32_console_attach*: bool
    html5_canvas_name*: cstring
    html5_canvas_resize*: bool
    html5_preserve_drawing_buffer*: bool
    html5_premultiplied_alpha*: bool
    html5_ask_leave_site*: bool
    ios_keyboard_resizes_canvas*: bool

  sapp_html5_fetch_error* {.size: sizeof(int32).} = enum
    SAPP_HTML5_FETCH_ERROR_NO_ERROR, SAPP_HTML5_FETCH_ERROR_BUFFER_TOO_SMALL,
    SAPP_HTML5_FETCH_ERROR_OTHER
  sapp_html5_fetch_response* {.
                               bycopy.} = object
    succeeded*: bool
    error_code*: sapp_html5_fetch_error
    file_index*: int32
    fetched_size*: uint32
    buffer_ptr*: pointer
    buffer_size*: uint32
    user_data*: pointer

  sapp_html5_fetch_request* {.
                              bycopy.} = object
    dropped_file_index*: int32
    callback*: proc (a1: ptr sapp_html5_fetch_response) {.cdecl.}
    buffer_ptr*: pointer
    buffer_size*: uint32
    user_data*: pointer



proc sokol_main*(argc: int32; argv: ptr cstring): sapp_desc {.cdecl,
    importc.}
proc sapp_isvalid*(): bool {.cdecl, importc.}
proc sapp_width*(): int32 {.cdecl, importc.}
proc sapp_widthf*(): cfloat {.cdecl, importc.}
proc sapp_height*(): int32 {.cdecl, importc.}
proc sapp_heightf*(): cfloat {.cdecl, importc.}
proc sapp_color_format*(): int32 {.cdecl, importc.}
proc sapp_depth_format*(): int32 {.cdecl, importc.}
proc sapp_sample_count*(): int32 {.cdecl, importc.}
proc sapp_high_dpi*(): bool {.cdecl, importc.}
proc sapp_dpi_scale*(): cfloat {.cdecl, importc.}
proc sapp_show_keyboard*(show: bool) {.cdecl, importc.}
proc sapp_keyboard_shown*(): bool {.cdecl, importc.}
proc sapp_is_fullscreen*(): bool {.cdecl, importc.}
proc sapp_toggle_fullscreen*() {.cdecl, importc.}
proc sapp_show_mouse*(show: bool) {.cdecl, importc.}
proc sapp_mouse_shown*(): bool {.cdecl, importc.}
proc sapp_lock_mouse*(lock: bool) {.cdecl, importc.}
proc sapp_mouse_locked*(): bool {.cdecl, importc.}
proc sapp_userdata*(): pointer {.cdecl, importc.}
proc sapp_query_desc*(): sapp_desc {.cdecl, importc.}
proc sapp_request_quit*() {.cdecl, importc.}
proc sapp_cancel_quit*() {.cdecl, importc.}
proc sapp_quit*() {.cdecl, importc.}
proc sapp_consume_event*() {.cdecl, importc.}
proc sapp_frame_count*(): uint64 {.cdecl, importc.}
proc sapp_set_clipboard_string*(str: cstring) {.cdecl,
    importc.}
proc sapp_get_clipboard_string*(): cstring {.cdecl,
    importc.}
proc sapp_set_window_title*(str: cstring) {.cdecl, importc.}
proc sapp_get_num_dropped_files*(): int32 {.cdecl,
                                        importc.}
proc sapp_get_dropped_file_path*(index: int32): cstring {.cdecl,
    importc.}
proc sapp_run*(desc: ptr sapp_desc) {.cdecl, importc.}
proc sapp_gles2*(): bool {.cdecl, importc.}
proc sapp_html5_ask_leave_site*(ask: bool) {.cdecl,
    importc.}
proc sapp_html5_get_dropped_file_size*(index: int32): uint32 {.cdecl,
    importc.}
proc sapp_html5_fetch_dropped_file*(request: ptr sapp_html5_fetch_request) {.cdecl,
    importc.}
proc sapp_metal_get_device*(): pointer {.cdecl, importc.}
proc sapp_metal_get_renderpass_descriptor*(): pointer {.cdecl,
    importc.}
proc sapp_metal_get_drawable*(): pointer {.cdecl,
                                        importc.}
proc sapp_macos_get_window*(): pointer {.cdecl, importc.}
proc sapp_ios_get_window*(): pointer {.cdecl, importc.}
proc sapp_d3d11_get_device*(): pointer {.cdecl, importc.}
proc sapp_d3d11_get_device_context*(): pointer {.cdecl,
    importc.}
proc sapp_d3d11_get_render_target_view*(): pointer {.cdecl,
    importc.}
proc sapp_d3d11_get_depth_stencil_view*(): pointer {.cdecl,
    importc.}
proc sapp_win32_get_hwnd*(): pointer {.cdecl, importc.}
proc sapp_wgpu_get_device*(): pointer {.cdecl, importc.}
proc sapp_wgpu_get_render_view*(): pointer {.cdecl,
    importc.}
proc sapp_wgpu_get_resolve_view*(): pointer {.cdecl,
    importc.}
proc sapp_wgpu_get_depth_stencil_view*(): pointer {.cdecl,
    importc.}
proc sapp_android_get_native_activity*(): pointer {.cdecl,
    importc.}

# sokol_gfx.h
type
  sg_buffer* {.bycopy.} = object
    id*: uint32

  sg_image* {.bycopy.} = object
    id*: uint32

  sg_shader* {.bycopy.} = object
    id*: uint32

  sg_pipeline* {.bycopy.} = object
    id*: uint32

  sg_pass* {.bycopy.} = object
    id*: uint32

  sg_context* {.bycopy.} = object
    id*: uint32

  sg_range* {.bycopy.} = object
    `ptr`*: pointer
    size*: int


const
  SG_INVALID_ID* = 0
  SG_NUM_SHADER_STAGES* = 2
  SG_NUM_INFLIGHT_FRAMES* = 2
  SG_MAX_COLOR_ATTACHMENTS* = 4
  SG_MAX_SHADERSTAGE_BUFFERS* = 8
  SG_MAX_SHADERSTAGE_IMAGES* = 12
  SG_MAX_SHADERSTAGE_UBS* = 4
  SG_MAX_UB_MEMBERS* = 16
  SG_MAX_VERTEX_ATTRIBUTES* = 16
  SG_MAX_MIPMAPS* = 16
  SG_MAX_TEXTUREARRAY_LAYERS* = 128

type
  sg_color* {.bycopy.} = object
    r*: cfloat
    g*: cfloat
    b*: cfloat
    a*: cfloat

  sg_backend* {.size: sizeof(int32).} = enum
    SG_BACKEND_GLCORE33, SG_BACKEND_GLES2, SG_BACKEND_GLES3, SG_BACKEND_D3D11,
    SG_BACKEND_METAL_IOS, SG_BACKEND_METAL_MACOS, SG_BACKEND_METAL_SIMULATOR,
    SG_BACKEND_WGPU, SG_BACKEND_DUMMY
  sg_pixel_format* {.size: sizeof(uint32).} = enum
    SG_PIXELFORMAT_DEFAULT, SG_PIXELFORMAT_NONE, SG_PIXELFORMAT_R8,
    SG_PIXELFORMAT_R8SN, SG_PIXELFORMAT_R8UI, SG_PIXELFORMAT_R8SI,
    SG_PIXELFORMAT_R16, SG_PIXELFORMAT_R16SN, SG_PIXELFORMAT_R16UI,
    SG_PIXELFORMAT_R16SI, SG_PIXELFORMAT_R16F, SG_PIXELFORMAT_RG8,
    SG_PIXELFORMAT_RG8SN, SG_PIXELFORMAT_RG8UI, SG_PIXELFORMAT_RG8SI,
    SG_PIXELFORMAT_R32UI, SG_PIXELFORMAT_R32SI, SG_PIXELFORMAT_R32F,
    SG_PIXELFORMAT_RG16, SG_PIXELFORMAT_RG16SN, SG_PIXELFORMAT_RG16UI,
    SG_PIXELFORMAT_RG16SI, SG_PIXELFORMAT_RG16F, SG_PIXELFORMAT_RGBA8,
    SG_PIXELFORMAT_RGBA8SN, SG_PIXELFORMAT_RGBA8UI, SG_PIXELFORMAT_RGBA8SI,
    SG_PIXELFORMAT_BGRA8, SG_PIXELFORMAT_RGB10A2, SG_PIXELFORMAT_RG11B10F,
    SG_PIXELFORMAT_RG32UI, SG_PIXELFORMAT_RG32SI, SG_PIXELFORMAT_RG32F,
    SG_PIXELFORMAT_RGBA16, SG_PIXELFORMAT_RGBA16SN, SG_PIXELFORMAT_RGBA16UI,
    SG_PIXELFORMAT_RGBA16SI, SG_PIXELFORMAT_RGBA16F, SG_PIXELFORMAT_RGBA32UI,
    SG_PIXELFORMAT_RGBA32SI, SG_PIXELFORMAT_RGBA32F, SG_PIXELFORMAT_DEPTH,
    SG_PIXELFORMAT_DEPTH_STENCIL, SG_PIXELFORMAT_BC1_RGBA,
    SG_PIXELFORMAT_BC2_RGBA, SG_PIXELFORMAT_BC3_RGBA, SG_PIXELFORMAT_BC4_R,
    SG_PIXELFORMAT_BC4_RSN, SG_PIXELFORMAT_BC5_RG, SG_PIXELFORMAT_BC5_RGSN,
    SG_PIXELFORMAT_BC6H_RGBF, SG_PIXELFORMAT_BC6H_RGBUF, SG_PIXELFORMAT_BC7_RGBA,
    SG_PIXELFORMAT_PVRTC_RGB_2BPP, SG_PIXELFORMAT_PVRTC_RGB_4BPP,
    SG_PIXELFORMAT_PVRTC_RGBA_2BPP, SG_PIXELFORMAT_PVRTC_RGBA_4BPP,
    SG_PIXELFORMAT_ETC2_RGB8, SG_PIXELFORMAT_ETC2_RGB8A1,
    SG_PIXELFORMAT_ETC2_RGBA8, SG_PIXELFORMAT_ETC2_RG11,
    SG_PIXELFORMAT_ETC2_RG11SN, SG_PIXELFORMAT_NUM,
    SG_PIXELFORMAT_FORCE_U32 = 0x7FFFFFFF
  sg_pixelformat_info* {.bycopy.} = object
    sample*: bool
    filter*: bool
    render*: bool
    blend*: bool
    msaa*: bool
    depth*: bool

  sg_features* {.bycopy.} = object
    instancing*: bool
    origin_top_left*: bool
    multiple_render_targets*: bool
    msaa_render_targets*: bool
    imagetype_3d*: bool
    imagetype_array*: bool
    image_clamp_to_border*: bool
    mrt_independent_blend_state*: bool
    mrt_independent_write_mask*: bool

  sg_limits* {.bycopy.} = object
    max_image_size_2d*: int32
    max_image_size_cube*: int32
    max_image_size_3d*: int32
    max_image_size_array*: int32
    max_image_array_layers*: int32
    max_vertex_attrs*: int32

  sg_resource_state* {.size: sizeof(uint32).} = enum
    SG_RESOURCESTATE_INITIAL, SG_RESOURCESTATE_ALLOC, SG_RESOURCESTATE_VALID,
    SG_RESOURCESTATE_FAILED, SG_RESOURCESTATE_INVALID,
    SG_RESOURCESTATE_FORCE_U32 = 0x7FFFFFFF
  sg_usage* {.size: sizeof(uint32).} = enum
    SG_USAGE_DEFAULT, SG_USAGE_IMMUTABLE, SG_USAGE_DYNAMIC, SG_USAGE_STREAM,
    SG_USAGE_NUM, SG_USAGE_FORCE_U32 = 0x7FFFFFFF
  sg_buffer_type* {.size: sizeof(uint32).} = enum
    SG_BUFFERTYPE_DEFAULT, SG_BUFFERTYPE_VERTEXBUFFER, SG_BUFFERTYPE_INDEXBUFFER,
    SG_BUFFERTYPE_NUM, SG_BUFFERTYPE_FORCE_U32 = 0x7FFFFFFF
  sg_index_type* {.size: sizeof(uint32).} = enum
    SG_INDEXTYPE_DEFAULT, SG_INDEXTYPE_NONE, SG_INDEXTYPE_UINT16,
    SG_INDEXTYPE_UINT32, SG_INDEXTYPE_NUM, SG_INDEXTYPE_FORCE_U32 = 0x7FFFFFFF
  sg_image_type* {.size: sizeof(uint32).} = enum
    SG_IMAGETYPE_DEFAULT, SG_IMAGETYPE_2D, SG_IMAGETYPE_CUBE, SG_IMAGETYPE_3D,
    SG_IMAGETYPE_ARRAY, SG_IMAGETYPE_NUM, SG_IMAGETYPE_FORCE_U32 = 0x7FFFFFFF








type
  sg_sampler_type* {.size: sizeof(int32).} = enum
    SG_SAMPLERTYPE_DEFAULT, SG_SAMPLERTYPE_FLOAT, SG_SAMPLERTYPE_SINT,
    SG_SAMPLERTYPE_UINT
  sg_cube_face* {.size: sizeof(int32).} = enum
    SG_CUBEFACE_POS_X, SG_CUBEFACE_NEG_X, SG_CUBEFACE_POS_Y, SG_CUBEFACE_NEG_Y,
    SG_CUBEFACE_POS_Z, SG_CUBEFACE_NEG_Z, SG_CUBEFACE_NUM,
    SG_CUBEFACE_FORCE_U32 = 0x7FFFFFFF



type
  sg_shader_stage* {.size: sizeof(uint32).} = enum
    SG_SHADERSTAGE_VS, SG_SHADERSTAGE_FS, SG_SHADERSTAGE_FORCE_U32 = 0x7FFFFFFF


type
  sg_primitive_type* {.size: sizeof(uint32).} = enum
    SG_PRIMITIVETYPE_DEFAULT, SG_PRIMITIVETYPE_POINTS, SG_PRIMITIVETYPE_LINES,
    SG_PRIMITIVETYPE_LINE_STRIP, SG_PRIMITIVETYPE_TRIANGLES,
    SG_PRIMITIVETYPE_TRIANGLE_STRIP, SG_PRIMITIVETYPE_NUM,
    SG_PRIMITIVETYPE_FORCE_U32 = 0x7FFFFFFF


type
  sg_filter* {.size: sizeof(uint32).} = enum
    SG_FILTER_DEFAULT, SG_FILTER_NEAREST, SG_FILTER_LINEAR,
    SG_FILTER_NEAREST_MIPMAP_NEAREST, SG_FILTER_NEAREST_MIPMAP_LINEAR,
    SG_FILTER_LINEAR_MIPMAP_NEAREST, SG_FILTER_LINEAR_MIPMAP_LINEAR,
    SG_FILTER_NUM, SG_FILTER_FORCE_U32 = 0x7FFFFFFF


type
  sg_wrap* {.size: sizeof(uint32).} = enum
    SG_WRAP_DEFAULT, SG_WRAP_REPEAT, SG_WRAP_CLAMP_TO_EDGE,
    SG_WRAP_CLAMP_TO_BORDER, SG_WRAP_MIRRORED_REPEAT, SG_WRAP_NUM,
    SG_WRAP_FORCE_U32 = 0x7FFFFFFF


type
  sg_border_color* {.size: sizeof(uint32).} = enum
    SG_BORDERCOLOR_DEFAULT, SG_BORDERCOLOR_TRANSPARENT_BLACK,
    SG_BORDERCOLOR_OPAQUE_BLACK, SG_BORDERCOLOR_OPAQUE_WHITE, SG_BORDERCOLOR_NUM,
    SG_BORDERCOLOR_FORCE_U32 = 0x7FFFFFFF
  sg_vertex_format* {.size: sizeof(uint32).} = enum
    SG_VERTEXFORMAT_INVALID, SG_VERTEXFORMAT_FLOAT, SG_VERTEXFORMAT_FLOAT2,
    SG_VERTEXFORMAT_FLOAT3, SG_VERTEXFORMAT_FLOAT4, SG_VERTEXFORMAT_BYTE4,
    SG_VERTEXFORMAT_BYTE4N, SG_VERTEXFORMAT_UBYTE4, SG_VERTEXFORMAT_UBYTE4N,
    SG_VERTEXFORMAT_SHORT2, SG_VERTEXFORMAT_SHORT2N, SG_VERTEXFORMAT_USHORT2N,
    SG_VERTEXFORMAT_SHORT4, SG_VERTEXFORMAT_SHORT4N, SG_VERTEXFORMAT_USHORT4N,
    SG_VERTEXFORMAT_UINT10_N2, SG_VERTEXFORMAT_NUM,
    SG_VERTEXFORMAT_FORCE_U32 = 0x7FFFFFFF



type
  sg_vertex_step* {.size: sizeof(uint32).} = enum
    SG_VERTEXSTEP_DEFAULT, SG_VERTEXSTEP_PER_VERTEX, SG_VERTEXSTEP_PER_INSTANCE,
    SG_VERTEXSTEP_NUM, SG_VERTEXSTEP_FORCE_U32 = 0x7FFFFFFF


type
  sg_uniform_type* {.size: sizeof(uint32).} = enum
    SG_UNIFORMTYPE_INVALID, SG_UNIFORMTYPE_FLOAT, SG_UNIFORMTYPE_FLOAT2,
    SG_UNIFORMTYPE_FLOAT3, SG_UNIFORMTYPE_FLOAT4, SG_UNIFORMTYPE_MAT4,
    SG_UNIFORMTYPE_NUM, SG_UNIFORMTYPE_FORCE_U32 = 0x7FFFFFFF


type
  sg_cull_mode* {.size: sizeof(uint32).} = enum
    SG_CULLMODE_DEFAULT, SG_CULLMODE_NONE, SG_CULLMODE_FRONT, SG_CULLMODE_BACK,
    SG_CULLMODE_NUM, SG_CULLMODE_FORCE_U32 = 0x7FFFFFFF


type
  sg_face_winding* {.size: sizeof(uint32).} = enum
    SG_FACEWINDING_DEFAULT, SG_FACEWINDING_CCW, SG_FACEWINDING_CW,
    SG_FACEWINDING_NUM, SG_FACEWINDING_FORCE_U32 = 0x7FFFFFFF


type
  sg_compare_func* {.size: sizeof(uint32).} = enum
    SG_COMPAREFUNC_DEFAULT, SG_COMPAREFUNC_NEVER, SG_COMPAREFUNC_LESS,
    SG_COMPAREFUNC_EQUAL, SG_COMPAREFUNC_LESS_EQUAL, SG_COMPAREFUNC_GREATER,
    SG_COMPAREFUNC_NOT_EQUAL, SG_COMPAREFUNC_GREATER_EQUAL, SG_COMPAREFUNC_ALWAYS,
    SG_COMPAREFUNC_NUM, SG_COMPAREFUNC_FORCE_U32 = 0x7FFFFFFF


type
  sg_stencil_op* {.size: sizeof(uint32).} = enum
    SG_STENCILOP_DEFAULT, SG_STENCILOP_KEEP, SG_STENCILOP_ZERO,
    SG_STENCILOP_REPLACE, SG_STENCILOP_INCR_CLAMP, SG_STENCILOP_DECR_CLAMP,
    SG_STENCILOP_INVERT, SG_STENCILOP_INCR_WRAP, SG_STENCILOP_DECR_WRAP,
    SG_STENCILOP_NUM, SG_STENCILOP_FORCE_U32 = 0x7FFFFFFF


type
  sg_blend_factor* {.size: sizeof(uint32).} = enum
    SG_BLENDFACTOR_DEFAULT, SG_BLENDFACTOR_ZERO, SG_BLENDFACTOR_ONE,
    SG_BLENDFACTOR_SRC_COLOR, SG_BLENDFACTOR_ONE_MINUS_SRC_COLOR,
    SG_BLENDFACTOR_SRC_ALPHA, SG_BLENDFACTOR_ONE_MINUS_SRC_ALPHA,
    SG_BLENDFACTOR_DST_COLOR, SG_BLENDFACTOR_ONE_MINUS_DST_COLOR,
    SG_BLENDFACTOR_DST_ALPHA, SG_BLENDFACTOR_ONE_MINUS_DST_ALPHA,
    SG_BLENDFACTOR_SRC_ALPHA_SATURATED, SG_BLENDFACTOR_BLEND_COLOR,
    SG_BLENDFACTOR_ONE_MINUS_BLEND_COLOR, SG_BLENDFACTOR_BLEND_ALPHA,
    SG_BLENDFACTOR_ONE_MINUS_BLEND_ALPHA, SG_BLENDFACTOR_NUM,
    SG_BLENDFACTOR_FORCE_U32 = 0x7FFFFFFF


type
  sg_blend_op* {.size: sizeof(uint32).} = enum
    SG_BLENDOP_DEFAULT, SG_BLENDOP_ADD, SG_BLENDOP_SUBTRACT,
    SG_BLENDOP_REVERSE_SUBTRACT, SG_BLENDOP_NUM,
    SG_BLENDOP_FORCE_U32 = 0x7FFFFFFF


type
  sg_color_mask* {.size: sizeof(uint32).} = enum
    SG_COLORMASK_DEFAULT = 0, SG_COLORMASK_R = 0x00000001,
    SG_COLORMASK_G = 0x00000002, SG_COLORMASK_RG = 0x00000003,
    SG_COLORMASK_B = 0x00000004, SG_COLORMASK_RB = 0x00000005,
    SG_COLORMASK_GB = 0x00000006, SG_COLORMASK_RGB = 0x00000007,
    SG_COLORMASK_A = 0x00000008, SG_COLORMASK_RA = 0x00000009,
    SG_COLORMASK_GA = 0x0000000A, SG_COLORMASK_RGA = 0x0000000B,
    SG_COLORMASK_BA = 0x0000000C, SG_COLORMASK_RBA = 0x0000000D,
    SG_COLORMASK_GBA = 0x0000000E, SG_COLORMASK_RGBA = 0x0000000F,
    SG_COLORMASK_NONE = 0x00000010, SG_COLORMASK_FORCE_U32 = 0x7FFFFFFF


type
  sg_action* {.size: sizeof(uint32).} = enum
    SG_ACTION_DEFAULT, SG_ACTION_CLEAR, SG_ACTION_LOAD, SG_ACTION_DONTCARE,
    SG_ACTION_NUM, SG_ACTION_FORCE_U32 = 0x7FFFFFFF


type
  sg_color_attachment_action* {.bycopy.} = object
    action*: sg_action
    value*: sg_color

  sg_depth_attachment_action* {.bycopy.} = object
    action*: sg_action
    value*: cfloat

  sg_stencil_attachment_action* {.bycopy.} = object
    action*: sg_action
    value*: uint8

  sg_pass_action* {.bycopy.} = object
    start_canary*: uint32
    colors*: array[SG_MAX_COLOR_ATTACHMENTS, sg_color_attachment_action]
    depth*: sg_depth_attachment_action
    stencil*: sg_stencil_attachment_action
    end_canary*: uint32

  sg_bindings* {.bycopy.} = object
    start_canary*: uint32
    vertex_buffers*: array[SG_MAX_SHADERSTAGE_BUFFERS, sg_buffer]
    vertex_buffer_offsets*: array[SG_MAX_SHADERSTAGE_BUFFERS, int32]
    index_buffer*: sg_buffer
    index_buffer_offset*: int32
    vs_images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_image]
    fs_images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_image]
    end_canary*: uint32

  sg_buffer_desc* {.bycopy.} = object
    start_canary*: uint32
    size*: int
    `type`*: sg_buffer_type
    usage*: sg_usage
    data*: sg_range
    label*: cstring
    gl_buffers*: array[SG_NUM_INFLIGHT_FRAMES, uint32]
    mtl_buffers*: array[SG_NUM_INFLIGHT_FRAMES, pointer]
    d3d11_buffer*: pointer
    wgpu_buffer*: pointer
    end_canary*: uint32

  sg_image_data* {.bycopy.} = object
    subimage*: array[ord(SG_CUBEFACE_NUM), array[SG_MAX_MIPMAPS, sg_range]]

  sg_image_desc* {.bycopy.} = object
    start_canary*: uint32
    `type`*: sg_image_type
    render_target*: bool
    width*: int32
    height*: int32
    num_slices*: int32
    num_mipmaps*: int32
    usage*: sg_usage
    pixel_format*: sg_pixel_format
    sample_count*: int32
    min_filter*: sg_filter
    mag_filter*: sg_filter
    wrap_u*: sg_wrap
    wrap_v*: sg_wrap
    wrap_w*: sg_wrap
    border_color*: sg_border_color
    max_anisotropy*: uint32
    min_lod*: cfloat
    max_lod*: cfloat
    data*: sg_image_data
    label*: cstring
    gl_textures*: array[SG_NUM_INFLIGHT_FRAMES, uint32]
    gl_texture_target*: uint32
    mtl_textures*: array[SG_NUM_INFLIGHT_FRAMES, pointer]
    d3d11_texture*: pointer
    d3d11_shader_resource_view*: pointer
    wgpu_texture*: pointer
    end_canary*: uint32

  sg_shader_attr_desc* {.bycopy.} = object
    name*: cstring
    sem_name*: cstring
    sem_index*: int32

  sg_shader_uniform_desc* {.bycopy.} = object
    name*: cstring
    `type`*: sg_uniform_type
    array_count*: int32

  sg_shader_uniform_block_desc* {.bycopy.} = object
    size*: int
    uniforms*: array[SG_MAX_UB_MEMBERS, sg_shader_uniform_desc]

  sg_shader_image_desc* {.bycopy.} = object
    name*: cstring
    image_type*: sg_image_type
    sampler_type*: sg_sampler_type

  sg_shader_stage_desc* {.bycopy.} = object
    source*: cstring
    bytecode*: sg_range
    entry*: cstring
    d3d11_target*: cstring
    uniform_blocks*: array[SG_MAX_SHADERSTAGE_UBS, sg_shader_uniform_block_desc]
    images*: array[SG_MAX_SHADERSTAGE_IMAGES, sg_shader_image_desc]

  sg_shader_desc* {.bycopy.} = object
    start_canary*: uint32
    attrs*: array[SG_MAX_VERTEX_ATTRIBUTES, sg_shader_attr_desc]
    vs*: sg_shader_stage_desc
    fs*: sg_shader_stage_desc
    label*: cstring
    end_canary*: uint32

  sg_buffer_layout_desc* {.bycopy.} = object
    stride*: int32
    step_func*: sg_vertex_step
    step_rate*: int32

  sg_vertex_attr_desc* {.bycopy.} = object
    buffer_index*: int32
    offset*: int32
    format*: sg_vertex_format

  sg_layout_desc* {.bycopy.} = object
    buffers*: array[SG_MAX_SHADERSTAGE_BUFFERS, sg_buffer_layout_desc]
    attrs*: array[SG_MAX_VERTEX_ATTRIBUTES, sg_vertex_attr_desc]

  sg_stencil_face_state* {.bycopy.} = object
    compare*: sg_compare_func
    fail_op*: sg_stencil_op
    depth_fail_op*: sg_stencil_op
    pass_op*: sg_stencil_op

  sg_stencil_state* {.bycopy.} = object
    enabled*: bool
    front*: sg_stencil_face_state
    back*: sg_stencil_face_state
    read_mask*: uint8
    write_mask*: uint8
    `ref`*: uint8

  sg_depth_state* {.bycopy.} = object
    pixel_format*: sg_pixel_format
    compare*: sg_compare_func
    write_enabled*: bool
    bias*: cfloat
    bias_slope_scale*: cfloat
    bias_clamp*: cfloat

  sg_blend_state* {.bycopy.} = object
    enabled*: bool
    src_factor_rgb*: sg_blend_factor
    dst_factor_rgb*: sg_blend_factor
    op_rgb*: sg_blend_op
    src_factor_alpha*: sg_blend_factor
    dst_factor_alpha*: sg_blend_factor
    op_alpha*: sg_blend_op

  sg_color_state* {.bycopy.} = object
    pixel_format*: sg_pixel_format
    write_mask*: sg_color_mask
    blend*: sg_blend_state

  sg_pipeline_desc* {.bycopy.} = object
    start_canary*: uint32
    shader*: sg_shader
    layout*: sg_layout_desc
    depth*: sg_depth_state
    stencil*: sg_stencil_state
    color_count*: int32
    colors*: array[SG_MAX_COLOR_ATTACHMENTS, sg_color_state]
    primitive_type*: sg_primitive_type
    index_type*: sg_index_type
    cull_mode*: sg_cull_mode
    face_winding*: sg_face_winding
    sample_count*: int32
    blend_color*: sg_color
    alpha_to_coverage_enabled*: bool
    label*: cstring
    end_canary*: uint32

  sg_pass_attachment_desc* {.bycopy.} = object
    image*: sg_image
    mip_level*: int32
    slice*: int32

  sg_pass_desc* {.bycopy.} = object
    start_canary*: uint32
    color_attachments*: array[SG_MAX_COLOR_ATTACHMENTS, sg_pass_attachment_desc]
    depth_stencil_attachment*: sg_pass_attachment_desc
    label*: cstring
    end_canary*: uint32

  sg_trace_hooks* {.bycopy.} = object
    user_data*: pointer
    reset_state_cache*: proc (user_data: pointer) {.cdecl.}
    make_buffer*: proc (desc: ptr sg_buffer_desc; result: sg_buffer; user_data: pointer) {.
        cdecl.}
    make_image*: proc (desc: ptr sg_image_desc; result: sg_image; user_data: pointer) {.
        cdecl.}
    make_shader*: proc (desc: ptr sg_shader_desc; result: sg_shader; user_data: pointer) {.
        cdecl.}
    make_pipeline*: proc (desc: ptr sg_pipeline_desc; result: sg_pipeline;
                        user_data: pointer) {.cdecl.}
    make_pass*: proc (desc: ptr sg_pass_desc; result: sg_pass; user_data: pointer) {.
        cdecl.}
    destroy_buffer*: proc (buf: sg_buffer; user_data: pointer) {.cdecl.}
    destroy_image*: proc (img: sg_image; user_data: pointer) {.cdecl.}
    destroy_shader*: proc (shd: sg_shader; user_data: pointer) {.cdecl.}
    destroy_pipeline*: proc (pip: sg_pipeline; user_data: pointer) {.cdecl.}
    destroy_pass*: proc (pass: sg_pass; user_data: pointer) {.cdecl.}
    update_buffer*: proc (buf: sg_buffer; data: ptr sg_range; user_data: pointer) {.cdecl.}
    update_image*: proc (img: sg_image; data: ptr sg_image_data; user_data: pointer) {.
        cdecl.}
    append_buffer*: proc (buf: sg_buffer; data: ptr sg_range; result: int32;
                        user_data: pointer) {.cdecl.}
    begin_default_pass*: proc (pass_action: ptr sg_pass_action; width: int32;
                             height: int32; user_data: pointer) {.cdecl.}
    begin_pass*: proc (pass: sg_pass; pass_action: ptr sg_pass_action;
                     user_data: pointer) {.cdecl.}
    apply_viewport*: proc (x: int32; y: int32; width: int32; height: int32;
                         origin_top_left: bool; user_data: pointer) {.cdecl.}
    apply_scissor_rect*: proc (x: int32; y: int32; width: int32; height: int32;
                             origin_top_left: bool; user_data: pointer) {.cdecl.}
    apply_pipeline*: proc (pip: sg_pipeline; user_data: pointer) {.cdecl.}
    apply_bindings*: proc (bindings: ptr sg_bindings; user_data: pointer) {.cdecl.}
    apply_uniforms*: proc (stage: sg_shader_stage; ub_index: int32; data: ptr sg_range;
                         user_data: pointer) {.cdecl.}
    draw*: proc (base_element: int32; num_elements: int32; num_instances: int32;
               user_data: pointer) {.cdecl.}
    end_pass*: proc (user_data: pointer) {.cdecl.}
    commit*: proc (user_data: pointer) {.cdecl.}
    alloc_buffer*: proc (result: sg_buffer; user_data: pointer) {.cdecl.}
    alloc_image*: proc (result: sg_image; user_data: pointer) {.cdecl.}
    alloc_shader*: proc (result: sg_shader; user_data: pointer) {.cdecl.}
    alloc_pipeline*: proc (result: sg_pipeline; user_data: pointer) {.cdecl.}
    alloc_pass*: proc (result: sg_pass; user_data: pointer) {.cdecl.}
    dealloc_buffer*: proc (buf_id: sg_buffer; user_data: pointer) {.cdecl.}
    dealloc_image*: proc (img_id: sg_image; user_data: pointer) {.cdecl.}
    dealloc_shader*: proc (shd_id: sg_shader; user_data: pointer) {.cdecl.}
    dealloc_pipeline*: proc (pip_id: sg_pipeline; user_data: pointer) {.cdecl.}
    dealloc_pass*: proc (pass_id: sg_pass; user_data: pointer) {.cdecl.}
    init_buffer*: proc (buf_id: sg_buffer; desc: ptr sg_buffer_desc; user_data: pointer) {.
        cdecl.}
    init_image*: proc (img_id: sg_image; desc: ptr sg_image_desc; user_data: pointer) {.
        cdecl.}
    init_shader*: proc (shd_id: sg_shader; desc: ptr sg_shader_desc; user_data: pointer) {.
        cdecl.}
    init_pipeline*: proc (pip_id: sg_pipeline; desc: ptr sg_pipeline_desc;
                        user_data: pointer) {.cdecl.}
    init_pass*: proc (pass_id: sg_pass; desc: ptr sg_pass_desc; user_data: pointer) {.
        cdecl.}
    uninit_buffer*: proc (buf_id: sg_buffer; user_data: pointer) {.cdecl.}
    uninit_image*: proc (img_id: sg_image; user_data: pointer) {.cdecl.}
    uninit_shader*: proc (shd_id: sg_shader; user_data: pointer) {.cdecl.}
    uninit_pipeline*: proc (pip_id: sg_pipeline; user_data: pointer) {.cdecl.}
    uninit_pass*: proc (pass_id: sg_pass; user_data: pointer) {.cdecl.}
    fail_buffer*: proc (buf_id: sg_buffer; user_data: pointer) {.cdecl.}
    fail_image*: proc (img_id: sg_image; user_data: pointer) {.cdecl.}
    fail_shader*: proc (shd_id: sg_shader; user_data: pointer) {.cdecl.}
    fail_pipeline*: proc (pip_id: sg_pipeline; user_data: pointer) {.cdecl.}
    fail_pass*: proc (pass_id: sg_pass; user_data: pointer) {.cdecl.}
    push_debug_group*: proc (name: cstring; user_data: pointer) {.cdecl.}
    pop_debug_group*: proc (user_data: pointer) {.cdecl.}
    err_buffer_pool_exhausted*: proc (user_data: pointer) {.cdecl.}
    err_image_pool_exhausted*: proc (user_data: pointer) {.cdecl.}
    err_shader_pool_exhausted*: proc (user_data: pointer) {.cdecl.}
    err_pipeline_pool_exhausted*: proc (user_data: pointer) {.cdecl.}
    err_pass_pool_exhausted*: proc (user_data: pointer) {.cdecl.}
    err_context_mismatch*: proc (user_data: pointer) {.cdecl.}
    err_pass_invalid*: proc (user_data: pointer) {.cdecl.}
    err_draw_invalid*: proc (user_data: pointer) {.cdecl.}
    err_bindings_invalid*: proc (user_data: pointer) {.cdecl.}

  sg_slot_info* {.bycopy.} = object
    state*: sg_resource_state
    res_id*: uint32
    ctx_id*: uint32

  sg_buffer_info* {.bycopy.} = object
    slot*: sg_slot_info
    update_frame_index*: uint32
    append_frame_index*: uint32
    append_pos*: int32
    append_overflow*: bool
    num_slots*: int32
    active_slot*: int32

  sg_image_info* {.bycopy.} = object
    slot*: sg_slot_info
    upd_frame_index*: uint32
    num_slots*: int32
    active_slot*: int32
    width*: int32
    height*: int32

  sg_shader_info* {.bycopy.} = object
    slot*: sg_slot_info

  sg_pipeline_info* {.bycopy.} = object
    slot*: sg_slot_info

  sg_pass_info* {.bycopy.} = object
    slot*: sg_slot_info

  sg_gl_context_desc* {.bycopy.} = object
    force_gles2*: bool

  sg_metal_context_desc* {.bycopy.} = object
    device*: pointer
    renderpass_descriptor_cb*: proc (): pointer {.cdecl.}
    renderpass_descriptor_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    drawable_cb*: proc (): pointer {.cdecl.}
    drawable_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    user_data*: pointer

  sg_d3d11_context_desc* {.bycopy.} = object
    device*: pointer
    device_context*: pointer
    render_target_view_cb*: proc (): pointer {.cdecl.}
    render_target_view_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    depth_stencil_view_cb*: proc (): pointer {.cdecl.}
    depth_stencil_view_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    user_data*: pointer

  sg_wgpu_context_desc* {.bycopy.} = object
    device*: pointer
    render_view_cb*: proc (): pointer {.cdecl.}
    render_view_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    resolve_view_cb*: proc (): pointer {.cdecl.}
    resolve_view_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    depth_stencil_view_cb*: proc (): pointer {.cdecl.}
    depth_stencil_view_userdata_cb*: proc (a1: pointer): pointer {.cdecl.}
    user_data*: pointer

  sg_context_desc* {.bycopy.} = object
    color_format*: sg_pixel_format
    depth_format*: sg_pixel_format
    sample_count*: int32
    gl*: sg_gl_context_desc
    metal*: sg_metal_context_desc
    d3d11*: sg_d3d11_context_desc
    wgpu*: sg_wgpu_context_desc

  sg_desc* {.bycopy.} = object
    start_canary*: uint32
    buffer_pool_size*: int32
    image_pool_size*: int32
    shader_pool_size*: int32
    pipeline_pool_size*: int32
    pass_pool_size*: int32
    context_pool_size*: int32
    uniform_buffer_size*: int32
    staging_buffer_size*: int32
    sampler_cache_size*: int32
    context*: sg_context_desc
    end_canary*: uint32


proc sg_setup*(desc: ptr sg_desc) {.cdecl, importc.}
proc sg_shutdown*() {.cdecl, importc.}
proc sg_isvalid*(): bool {.cdecl, importc.}
proc sg_reset_state_cache*() {.cdecl, importc.}
proc sg_install_trace_hooks*(trace_hooks: ptr sg_trace_hooks): sg_trace_hooks {.cdecl, importc.}
proc sg_push_debug_group*(name: cstring) {.cdecl, importc.}
proc sg_pop_debug_group*() {.cdecl, importc.}
proc sg_make_buffer*(desc: ptr sg_buffer_desc): sg_buffer {.cdecl, importc.}
proc sg_make_image*(desc: ptr sg_image_desc): sg_image {.cdecl, importc.}
proc sg_make_shader*(desc: ptr sg_shader_desc): sg_shader {.cdecl, importc.}
proc sg_make_pipeline*(desc: ptr sg_pipeline_desc): sg_pipeline {.cdecl, importc.}
proc sg_make_pass*(desc: ptr sg_pass_desc): sg_pass {.cdecl, importc.}
proc sg_destroy_buffer*(buf: sg_buffer) {.cdecl, importc.}
proc sg_destroy_image*(img: sg_image) {.cdecl, importc.}
proc sg_destroy_shader*(shd: sg_shader) {.cdecl, importc.}
proc sg_destroy_pipeline*(pip: sg_pipeline) {.cdecl, importc.}
proc sg_destroy_pass*(pass: sg_pass) {.cdecl, importc.}
proc sg_update_buffer*(buf: sg_buffer; data: ptr sg_range) {.cdecl, importc.}
proc sg_update_image*(img: sg_image; data: ptr sg_image_data) {.cdecl, importc.}
proc sg_append_buffer*(buf: sg_buffer; data: ptr sg_range): int32 {.cdecl, importc.}
proc sg_query_buffer_overflow*(buf: sg_buffer): bool {.cdecl, importc.}
proc sg_begin_default_pass*(pass_action: ptr sg_pass_action; width: int32; height: int32) {.
    cdecl, importc.}
proc sg_begin_default_passf*(pass_action: ptr sg_pass_action; width: cfloat;
                            height: cfloat) {.cdecl, importc.}
proc sg_begin_pass*(pass: sg_pass; pass_action: ptr sg_pass_action) {.cdecl, importc.}
proc sg_apply_viewport*(x: int32; y: int32; width: int32; height: int32;
                       origin_top_left: bool) {.cdecl, importc.}
proc sg_apply_viewportf*(x: cfloat; y: cfloat; width: cfloat; height: cfloat;
                        origin_top_left: bool) {.cdecl, importc.}
proc sg_apply_scissor_rect*(x: int32; y: int32; width: int32; height: int32;
                           origin_top_left: bool) {.cdecl, importc.}
proc sg_apply_scissor_rectf*(x: cfloat; y: cfloat; width: cfloat; height: cfloat;
                            origin_top_left: bool) {.cdecl, importc.}
proc sg_apply_pipeline*(pip: sg_pipeline) {.cdecl, importc.}
proc sg_apply_bindings*(bindings: ptr sg_bindings) {.cdecl, importc.}
proc sg_apply_uniforms*(stage: sg_shader_stage; ub_index: int32; data: ptr sg_range) {.
    cdecl, importc.}
proc sg_draw*(base_element: int32; num_elements: int32; num_instances: int32) {.cdecl, importc.}
proc sg_end_pass*() {.cdecl, importc.}
proc sg_commit*() {.cdecl, importc.}
proc sg_query_desc*(): sg_desc {.cdecl, importc.}
proc sg_query_backend*(): sg_backend {.cdecl, importc.}
proc sg_query_features*(): sg_features {.cdecl, importc.}
proc sg_query_limits*(): sg_limits {.cdecl, importc.}
proc sg_query_pixelformat*(fmt: sg_pixel_format): sg_pixelformat_info {.cdecl, importc.}
proc sg_query_buffer_state*(buf: sg_buffer): sg_resource_state {.cdecl, importc.}
proc sg_query_image_state*(img: sg_image): sg_resource_state {.cdecl, importc.}
proc sg_query_shader_state*(shd: sg_shader): sg_resource_state {.cdecl, importc.}
proc sg_query_pipeline_state*(pip: sg_pipeline): sg_resource_state {.cdecl, importc.}
proc sg_query_pass_state*(pass: sg_pass): sg_resource_state {.cdecl, importc.}
proc sg_query_buffer_info*(buf: sg_buffer): sg_buffer_info {.cdecl, importc.}
proc sg_query_image_info*(img: sg_image): sg_image_info {.cdecl, importc.}
proc sg_query_shader_info*(shd: sg_shader): sg_shader_info {.cdecl, importc.}
proc sg_query_pipeline_info*(pip: sg_pipeline): sg_pipeline_info {.cdecl, importc.}
proc sg_query_pass_info*(pass: sg_pass): sg_pass_info {.cdecl, importc.}
proc sg_query_buffer_defaults*(desc: ptr sg_buffer_desc): sg_buffer_desc {.cdecl, importc.}
proc sg_query_image_defaults*(desc: ptr sg_image_desc): sg_image_desc {.cdecl, importc.}
proc sg_query_shader_defaults*(desc: ptr sg_shader_desc): sg_shader_desc {.cdecl, importc.}
proc sg_query_pipeline_defaults*(desc: ptr sg_pipeline_desc): sg_pipeline_desc {.
    cdecl, importc.}
proc sg_query_pass_defaults*(desc: ptr sg_pass_desc): sg_pass_desc {.cdecl, importc.}
proc sg_alloc_buffer*(): sg_buffer {.cdecl, importc.}
proc sg_alloc_image*(): sg_image {.cdecl, importc.}
proc sg_alloc_shader*(): sg_shader {.cdecl, importc.}
proc sg_alloc_pipeline*(): sg_pipeline {.cdecl, importc.}
proc sg_alloc_pass*(): sg_pass {.cdecl, importc.}
proc sg_dealloc_buffer*(buf_id: sg_buffer) {.cdecl, importc.}
proc sg_dealloc_image*(img_id: sg_image) {.cdecl, importc.}
proc sg_dealloc_shader*(shd_id: sg_shader) {.cdecl, importc.}
proc sg_dealloc_pipeline*(pip_id: sg_pipeline) {.cdecl, importc.}
proc sg_dealloc_pass*(pass_id: sg_pass) {.cdecl, importc.}
proc sg_init_buffer*(buf_id: sg_buffer; desc: ptr sg_buffer_desc) {.cdecl, importc.}
proc sg_init_image*(img_id: sg_image; desc: ptr sg_image_desc) {.cdecl, importc.}
proc sg_init_shader*(shd_id: sg_shader; desc: ptr sg_shader_desc) {.cdecl, importc.}
proc sg_init_pipeline*(pip_id: sg_pipeline; desc: ptr sg_pipeline_desc) {.cdecl, importc.}
proc sg_init_pass*(pass_id: sg_pass; desc: ptr sg_pass_desc) {.cdecl, importc.}
proc sg_uninit_buffer*(buf_id: sg_buffer): bool {.cdecl, importc.}
proc sg_uninit_image*(img_id: sg_image): bool {.cdecl, importc.}
proc sg_uninit_shader*(shd_id: sg_shader): bool {.cdecl, importc.}
proc sg_uninit_pipeline*(pip_id: sg_pipeline): bool {.cdecl, importc.}
proc sg_uninit_pass*(pass_id: sg_pass): bool {.cdecl, importc.}
proc sg_fail_buffer*(buf_id: sg_buffer) {.cdecl, importc.}
proc sg_fail_image*(img_id: sg_image) {.cdecl, importc.}
proc sg_fail_shader*(shd_id: sg_shader) {.cdecl, importc.}
proc sg_fail_pipeline*(pip_id: sg_pipeline) {.cdecl, importc.}
proc sg_fail_pass*(pass_id: sg_pass) {.cdecl, importc.}
proc sg_setup_context*(): sg_context {.cdecl, importc.}
proc sg_activate_context*(ctx_id: sg_context) {.cdecl, importc.}
proc sg_discard_context*(ctx_id: sg_context) {.cdecl, importc.}
proc sg_d3d11_device*(): pointer {.cdecl, importc.}
proc sg_mtl_device*(): pointer {.cdecl, importc.}
proc sg_mtl_render_command_encoder*(): pointer {.cdecl, importc.}

# sokol_glue.h

proc sapp_sgcontext*(): sg_context_desc {.cdecl, importc.}
