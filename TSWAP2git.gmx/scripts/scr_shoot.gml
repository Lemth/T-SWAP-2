///scr_shoot(distance,type{"Follow","Simple","Swap"})
// argument0 = distance; // bullet travel distance
// argument1 = type; // choose option {"Follow","Simple","Swap"}




argument0=argument0+0; // modify distance based on environment(?)
return_time_speed=0; // set variable for target_speed value
var bullet_follow=0; // set variable for "follow" bullet




switch (argument1) {
    case "Swap":    /////     /////     /////     /////     /////  
        collision_array=scr_collision(x,y,image_angle,argument0,1,true);
        if (collision_array[4]!=argument0) { // if hit before max. distance
            if (instance_exists(collision_array[3])) {
                with (collision_array[3]) {
                    other.return_time_speed=time_speed;
                }
            }
            if (return_time_speed>0) { // if timespeed 0 then it is swappable
                var return_bullet=instance_create(collision_array[0],collision_array[1],asset_get_index("obj_bullet"+argument1));
                with (return_bullet) { // set values
                    direction=180+other.collision_array[2];
                    bullet_distance=other.collision_array[4];
                    bullet_origin_id=other.collision_array[3];
                    bullet_origin_speed=other.return_time_speed;
                    bullet_target_id=other.id;
                    bullet_target_speed=other.time_speed;
                    if (bullet_origin_speed==bullet_target_speed) {
                        bullet_distance/=2; // if speeds same nullify in center of path
                    }
                }
            }
        }
        bullet_follow-=1;
    case "Follow":  /////     /////     /////     /////     /////   
        bullet_follow+=1;
    case "Simple":  /////     /////     /////     /////     /////      
    default:        /////     /////     /////     /////     /////   
        var bullet=instance_create(x,y,asset_get_index("obj_bullet"+argument1));
        with (bullet) { // set values
            direction=other.image_angle;
            bullet_distance=other.argument0;
            bullet_origin_id=other.id;
            bullet_origin_speed=other.time_speed; // shooters time_speed
            bullet_target_speed=other.return_time_speed;
            if(bullet_target_speed>0) { // if swappable set target_id
                bullet_target_id=other.collision_array[3]; // if swappable then it has id
                if(bullet_target_speed==bullet_origin_speed) {
                    bullet_distance/=2; // if speeds same nullify in center of path
                } else { // else if speeds differ swap them RIGHT AWAY
                    with (bullet_origin_id) {
                        time_speed=other.bullet_target_speed; // set new origin speed
                    }
                    with (bullet_target_id) {
                        time_speed=other.bullet_origin_speed; // set new target speed
                    }
                }
            } else { // else, set values as normal
                bullet_target_id=noone;
                bullet_target_speed=0;
            }
        }
    break;
}


