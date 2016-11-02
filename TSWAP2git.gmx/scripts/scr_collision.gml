///scr_collision(x,y,angle,distance,radius,bounce[,recursion])
// argument[0] = x;
// argument[1] = y;
// argument[2] = angle;
// argument[3] = distance; // distance in pixels
// argument[4] = radius; // radius in pixels
// argument[5] = bounce; // FALSE is no bounce (player movement), TRUE is bounce on time_speed=0


/////     /////     ///// NEEDS  IMPROVEMENT /////     /////     /////
collision_recursion=0;
if(argument_count>6) {
    collision_recursion=argument[6];
}
collision_recursion=max(0,collision_recursion-1);
/////     /////     ///// NEEDS  IMPROVEMENT /////     /////     /////


collision_return[3]=noone;
collision_return[4]=argument[3];
safety = 10;


while (argument[3] > 0) {
    argument[0]+=lengthdir_x(1,argument[2]);
    argument[1]+=lengthdir_y(1,argument[2]);
    argument[3]-=1; // move by 1 pixel, decrease distance




    // check for collision
    if (collision_circle(argument[0],argument[1],argument[4],obj_collide,true,true)!=noone) { 
        if (collision_circle(argument[0],argument[1],argument[4],obj_collide,true,true)!=collision_return[3]) {
            collision_return[3]=collision_circle(argument[0],argument[1],argument[4],obj_collide,true,true);
        }
        argument[0]-=lengthdir_x(1,argument[2]);
        argument[1]-=lengthdir_y(1,argument[2]);
        if (argument[5]==true) { // if bounce is active
            if (collision_return[3].time_speed==0) { // if 0 time_speed then bounce
                argument[2]=scr_bounce(argument[0],argument[1],argument[2],collision_return[3],false);
                if (safety>0) {
                    argument[3]+=1;
                    safety--;
                }
            } else { // if time_speed then stop bounce - this is your target
                collision_return[4]-=argument[3];
                argument[3]=0;
            }
        } else {
            
            /////     /////     ///// NEEDS  IMPROVEMENT /////     /////     /////
            argument[2]-=angle_difference(argument[2],scr_bounce(argument[0],argument[1],argument[2],collision_return[3],false))/2;
            if(collision_recursion>0) {
                recursive_collision_array=scr_collision(argument[0],argument[1],argument[2],(argument[3]*angle_difference(direction,argument[2])/90)-1,argument[4],argument[5],collision_recursion);
                argument[0]=recursive_collision_array[0];
                argument[1]=recursive_collision_array[1];
                argument[2]=point_direction(x,y,argument[0],argument[1]);
                collision_return[4]+=recursive_collision_array[4];
            }
            collision_return[4]-=(argument[3]+1);
            argument[3]=0;
            /////     /////     ///// NEEDS  IMPROVEMENT /////     /////     /////
            
        }
    } 
}


collision_return[0]=argument[0]; // return x value
collision_return[1]=argument[1]; // return y value
collision_return[2]=argument[2]; // return angle
/////     //collision_return[3]; // return id
/////     //collision_return[4]; // return distance value


return(collision_return);

