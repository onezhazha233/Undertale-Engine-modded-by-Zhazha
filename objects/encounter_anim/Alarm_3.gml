fader.alpha=1;
fader.draw_soul=true;
Anim_Create(fader,"draw_soul",0,0,1,-1,0,30);
Fader_Fade(-1,0,20);
Encounter_Start(_encounter,false);
instance_destroy();