///scr_bounce(x,y,angle,id,curved)
// argument0 = x; // x position of impact
// argument1 = y; // y position of impact
// argument2 = angle; // angle of impact
// argument3 = id; // id of impact target
// argument4 = curved; // true = circle, false = square

bounce_return=0; // return value

if (argument4==false) {
    bounce_return=(2*((round((point_direction(argument3.x,argument3.y,argument0,argument1)-argument3.direction)/90)-1)*90))-argument2;
}

return(bounce_return);

