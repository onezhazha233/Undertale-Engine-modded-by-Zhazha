///@desc Reset
if(!variable_instance_exists(id,"_voice_loop_snd"))_voice_loop_snd=-1;
Typer_VoiceStop();
text="";

_speed=0;
_char_per_frame=1;
_voice=0;
_voice_single=-1;
_voice_mode=0;
_voice_mode_interval=6;
_voice_mode_timer=0;
_voice_loop_snd=-1;
_voice_stop=true;
_audio_pitch=1;
_audio_pitch_random=0;
_sleep=0;
_skippable=true;
_skipping=false;
_paused=false;
_instant=false;
_hold_skip_timer=_hold_skip_interval;

_space_x=0;
_space_y=0;
_char_frame_remain=0;
_char_x=0;
_char_y=0;
_char="";
_char_sprite=-1;
_char_sprite_image=0;
_char_sprite_speed=1;
_char_sprite_offset_x=0;
_char_sprite_offset_y=0;
_char_proc=1;
_voice_played=false;

ds_list_clear(_list_cmd);
_macro={};
event_user(5);
_callback_start={};
_callback_end={};
_segment_index=0;
_callback_end_done=false;
_callback_start_pend=true;
_clearing=false;

if(!variable_instance_exists(id,"_is_mini"))_is_mini=false;
_mini_auto_layout=true;
_mini_align=1;
_mini_positions=[];
_mini_pos_index=0;
_mini_left=60;
_mini_right=500;

_position_follow=true;
_angle_follow=true;

_face=noone;
_face_linked=-1;
_char_linked=-1;

_skip_space=true;
_line=0;
_line_char_count=0;
_halign=0;
_valign=0;
_align_offset_x=0;
_align_offset_y=0;
_measure_w=0;
_measure_h=0;
_per_line_align=true;
_measured=false;

_choice=-1;
_choice_count=0;
_choice_x[0]=0;
_choice_y[0]=0;
_choice_x[1]=0;
_choice_y[1]=0;
_choice_x[2]=0;
_choice_y[2]=0;
_choice_x[3]=0;
_choice_y[3]=0;
_choice_reg=[];
_choice_line=[];
_choice_active=false;
_choice_default=0;
_choice_cx=0;
_choice_cy=0;
_choice_center_manual=false;
_choice_anim=false;
_choice_vx=0;
_choice_vy=0;
_choice_macro="";
_choice_dir=0;
_choice_switch_snd=true;
_choice_confirm_snd=true;
_choice_option_texts=[];
_choice_layout_positions=[];
_choice_skip_render=false;
_choice_collect_idx=-1;
_choice_collect_text="";

_font=0;
_scale_x=1;
_scale_y=1;
_angle=0;

_shadow=false;
_outline=false;
_color_text[0]=c_white;
_color_text[1]=c_white;
_color_text[2]=c_white;
_color_text[3]=c_white;
_color_shadow[0]=make_color_rgb(49,49,79);
_color_shadow[1]=make_color_rgb(49,49,79);
_color_shadow[2]=make_color_rgb(15,15,115);
_color_shadow[3]=make_color_rgb(15,15,115);
_color_outline[0]=make_color_rgb(110,110,110);
_color_outline[1]=make_color_rgb(110,110,110);
_color_outline[2]=make_color_rgb(110,110,110);
_color_outline[3]=make_color_rgb(110,110,110);
_alpha=1;
_alpha_text=1;
_alpha_shadow=1;
_alpha_outline=1;
_shadow_x=0.5;
_shadow_y=0.5;

_effect=-1;
_gui=false;
width=0;
height=0;

_time=0;
torder=[];
var ti=0;
repeat(10){
	torder[ti]=ti*36;
	ti+=1;
}

override_alpha_enabled=false;
override_alpha=1;
override_color_text_enabled=false;
override_color_text[0]=c_white;
override_color_text[1]=c_white;
override_color_text[2]=c_white;
override_color_text[3]=c_white;

if(!variable_instance_exists(id,"_surface_enabled"))_surface_enabled=false;
if(!variable_instance_exists(id,"_surface"))_surface=-1;

function SetSurface(surf){
	_surface_enabled=true;
	_surface=surf;
}
