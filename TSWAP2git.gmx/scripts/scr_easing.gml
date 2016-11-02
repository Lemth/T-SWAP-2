///scr_easing(y,seconds,ACCELERATING,EASEINCUBIC)
// argument0 = y; // current y value
// argument1 = sec; // total easing duration in seconds
// argument2 = accelerating; // TRUE is accelerating, FALSE is decelerating
// argument3 = EaseInCubic; // TRUE is In, FALSE is Out


argument2=sign(argument2-0.5); // change decelerating false(0) to -1
if(argument0<0) {
    argument2*=-1;
}
argument0=clamp(argument0,0,1); // sanitize input
var x_over=0;
 
easing_return[0]=0; // new y value will go here
easing_return[1]=0; // distance to move will go here
 
if (argument3) { // if EaseInCubic
 
    var x_current=scr_cuberoot(argument0); // current x value
    var x_next=max(0,x_current+(argument2*(delta/(60*argument1)))); // next x value (min. 0)
    if (x_next>1) {
        x_over=x_next-1;
        x_next=1;
    }
   
    easing_return[0]=power(x_next,3); // set new y value
    easing_return[1]=(((power(x_next,4)/4)-(power(x_current,4)/4))+x_over)*argument2*60*argument1; // set distance to move (reverse if negative input)
 
} else { // else EaseOutCubic
 
    var x_current=1-(scr_cuberoot(1-argument0)); // current x value
    var x_next=max(0,x_current+(argument2*(delta/(60*argument1)))); // next x value (min. 0)
    if (x_next>1) {
        x_over=x_next-1;
        x_next=1;
    }
 
    easing_return[0]=1+power(x_next-1,3); // set new y value
    easing_return[1]=(((x_next+(power(x_next-1,4)/4))-(x_current+(power(x_current-1,4)/4)))+x_over)*argument2*60*argument1; // set distance to move (reverse if negative input)
 
}


return(easing_return);
 
////////////////////// FORMULAS //////////////////////
//
// easeOutCubic                  used for acceleration
//
// y=(x-1)^3+1                   (1+power(x-1,3))
// x=1-(1-y)^(1/3)               (1-scr_cuberoot(1-y))
// fx dt=x+((x-1)^4)/4           (x+power(x-1,4)/4)
//
// easeInCubic                   used for deceleration
//
// y=x^3                         power(x,3)
// x=y^(1/3)                     scr_cuberoot(y)
// fx dt=(x^4)/4                 power(x,4)/4
//
////////////////////// //////// //////////////////////



