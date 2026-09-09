switch(template){
	case 0:
		dir=DIR.LEFT;
		show_spike=true;
		wide_spike=true;
		up=10;
		down=32;
		left=0;
		right=95;
		break;
		
	case 1:
		dir=DIR.RIGHT;
		show_spike=true;
		wide_spike=true;
		up=10;
		down=32;
		left=95;
		right=0;
		break;
		
	case 2:
		dir=DIR.LEFT;
		show_spike=true;
		wide_spike=false;
		up=21;
		down=21;
		left=0;
		right=32;
		break;
		
	case 3:
		dir=DIR.RIGHT;
		show_spike=true;
		wide_spike=false;
		up=21;
		down=21;
		left=32;
		right=0;
		break;
		
	case 4:
		dir=DIR.LEFT;
		show_spike=false;
		wide_spike=false;
		up=1;
		down=1;
		left=12;
		right=12;
		text_offset_y=-3;
		break;
}

visible=true;
_inst.text="{shadow false}{color_text `black`}{speed "+string(Lang_GetLayout("speed.dialog_battle_enemy",2))+"}{font 2}{scale 0.5}{depth "+string(depth)+"}"+text+(end_destroy ? "{pause}{end}" : "");