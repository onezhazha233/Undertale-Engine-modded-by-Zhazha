text="";
sprite=-1;
sprite_image=0;
font=-1;
scale_x=1;
scale_y=1;
angle=0;
shadow=false;
outline=false;
color_text[0]=c_white;
color_text[1]=c_white;
color_text[2]=c_white;
color_text[3]=c_white;
color_shadow[0]=make_color_rgb(41,41,87);
color_shadow[1]=make_color_rgb(41,41,87);
color_shadow[2]=make_color_rgb(3,3,125);
color_shadow[3]=make_color_rgb(3,3,125);
color_outline[0]=make_color_rgb(110,110,110);
color_outline[1]=make_color_rgb(110,110,110);
color_outline[2]=make_color_rgb(110,110,110);
color_outline[3]=make_color_rgb(110,110,110);
shadow_x=1;
shadow_y=1;
alpha=1;
alpha_text=1;
alpha_shadow=1;
alpha_outline=1;
effect=0;
FORCE_TYPE = true;
gui=true;
halign=0;

_offset_x=0;
_offset_y=0;
_line=0;//该字符所在行数

_effect_shook=false;

_xUnit = 0;
_yUnit = 0;

order = 0

function RenderCharEval(){
	_tmpX = x+_offset_x;
	_tmpY = y+_offset_y;
	_tmpA = alpha_text * alpha;
	_tmpAS = alpha_shadow * alpha;
	_tmpAO = alpha_outline * alpha;
}

function RenderCharFixed(paramXO,paramYO,paramColorSrc = color_text,paramAlpha = _tmpA){
	draw_text_transformed_color(_tmpX + paramXO,_tmpY + paramYO,text,scale_x,scale_y ,angle,paramColorSrc[0],paramColorSrc[1],paramColorSrc[3],paramColorSrc[2],paramAlpha);
}
function RenderSprFixed(paramXO,paramYO){
	draw_sprite_general(sprite,sprite_image,0,0,sprite_width,sprite_height,_tmpX + paramXO,_tmpY + paramYO,scale_x,scale_y,angle,color_text[0],color_text[1],color_text[3],color_text[2],_tmpA);
}