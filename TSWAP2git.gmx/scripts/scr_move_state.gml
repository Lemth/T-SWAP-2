///scr_move_state()


// key presses
if(state==scr_move_state) {
    if(obj_io.shoot_key) {
        scr_shoot(256,shoot_type);
        state=scr_shoot_state;
    } else if (obj_io.use_key) {
        state=scr_use_state;
    }
}


image_angle=point_direction(x,y,mouse_x,mouse_y); // update image_angle


// assign variables
xaxis=obj_io.xaxis;
yaxis=obj_io.yaxis;
moving=sign(abs(xaxis)+abs(yaxis)); // boolean


// MOVEMENT CYCLE (IF MOVING OR MOVE_SPEED!=0)
if (moving) {
    if(move_distance*1000000==1000000) {
        move_speed=0;
        collision_circle(x,y,24,obj_collide,true,true) {
            stuck+=1;
        }
        if (stuck>10) {
            x+=lengthdir_x(1,point_direction(x,y,view_wview/2,view_hview/2));
            y+=lengthdir_y(1,point_direction(x,y,view_wview/2,view_hview/2));
            stuck=0;
        }
    }
    move_direction=point_direction(0,0,xaxis,yaxis); // set move_direction
}
move_distance=0; // reset move_distance


// deconstruct current move_vector[move_speed,direction] to move_forward and move_side
move_forward=lengthdir_x(move_speed*1000000,direction-move_direction)/1000000;
move_side=lengthdir_y(move_speed*1000000,direction-move_direction)/1000000;
move_side_sign=sign(move_side); // fix for left/right movement


// calculate next speed and distance
if(moving && (move_forward >= -.1)) { // if moving in move_direction    
    easing_array=scr_easing(move_forward,acceleration,true,false); // get new easing values
    move_forward=easing_array[0]; // set new move_forward
    move_distance=move_max_speed*easing_array[1]; // set new move_distance
} else { // else; moving in -move_direction
    easing_array=scr_easing(move_forward,deceleration,false,true); // get new easing values
    move_forward=easing_array[0]; // set new move_forward
    move_distance=easing_array[1]; // set new move_distance
}
easing_array=scr_easing(abs(move_side),deceleration,false,false); // get new easing values


// convert back to moving direction vector
move_speed=point_distance(0,0,move_forward,easing_array[0]); // set new move_speed
direction=point_direction(0,0,move_distance,move_side_sign*easing_array[1])+move_direction; // update
move_distance=point_distance(0,0,move_distance,easing_array[1]); // set move_distance


/////     /////     ///// NEEDS  IMPROVEMENT /////     /////     /////
// COLLISION CYCLE (check direction for next second, then distance for this frame)
collision_array=scr_collision(x,y,direction,2*move_distance/delta,16,false,2);
collision_array=scr_collision(x,y,collision_array[2],move_distance,16,false);
direction=collision_array[2];
move_distance=collision_array[4];
/////     /////     ///// NEEDS  IMPROVEMENT /////     /////     /////


x+=lengthdir_x(move_distance,direction);
y+=lengthdir_y(move_distance,direction); // update x,y values


