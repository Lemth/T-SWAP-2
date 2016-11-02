///scr_draw_slices()

for(var i=z;i<image_number;i++) {
    draw_sprite_ext(sprite_index,i,x+((x-(view_wview/2))*i/100),y+((y-(view_hview/2))*i/100),1,1,image_angle,c_white,1);
}
depth=-point_distance(view_wview/2,view_hview/2,x,y);
