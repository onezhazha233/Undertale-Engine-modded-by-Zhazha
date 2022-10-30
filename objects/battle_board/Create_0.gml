depth=DEPTH_BATTLE.BOARD;

_surface = -1
_surface1 = -1
_surface2 = -1
_surface3 = -1
_surface4 = -1

x=BATTLE_BOARD.X;
y=BATTLE_BOARD.Y;

up=BATTLE_BOARD.UP;
down=BATTLE_BOARD.DOWN;
left=BATTLE_BOARD.LEFT;
right=BATTLE_BOARD.RIGHT;

angle=0;
color_bg=c_black;
color_frame=c_white;


_point_x=0;
_point_y=0;

_angle=0;
global.borderCount = 0
global.borders_list = ds_list_create()
event_user(5);