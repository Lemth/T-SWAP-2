///scr_get_input()

// Define variables
right_key=0;
left_key=0;
up_key=0;
down_key=0;
shoot_key=0;
use_key=0;

// WASD
right_key+=keyboard_check(ord('D'));
left_key+=keyboard_check(ord('A'));
up_key+=keyboard_check(ord('W'));
down_key+=keyboard_check(ord('S'));

// Mouse
use_key+=mouse_check_button_pressed(mb_right);
shoot_key+=mouse_check_button_pressed(mb_left);

// Alternate keys
/*
right_key+=keyboard_check(vk_right);
left_key+=keyboard_check(vk_left);
up_key+=keyboard_check(vk_up);
down_key+=keyboard_check(vk_down);
use_key+=keyboard_check_pressed(ord('E'));
use_key+=keyboard_check_pressed(ord('F'));
shoot_key+=keyboard_check_pressed(vk_space);
shoot_key+=keyboard_check_pressed(vk_shift);
*/

// Get the axis
xaxis=(right_key-left_key);
yaxis=(down_key-up_key);

/*
// Get the aim
xaim=mouse_x-x;
yaim=mouse_y-y;
*/

/*
// Check for gamepad input
if(gamepad_is_connected(0))
{
    gamepad_set_axis_deadzone(0,.42);
    xaxis+=gamepad_axis_value(0,gp_axislh);
    yaxis+=gamepad_axis_value(0,gp_axislv);
    shoot_key+=gamepad_button_check_pressed(0,gp_shoulderrb)+gamepad_button_check_pressed(0,gp_shoulderlb);
    use_key+=gamepad_button_check_pressed(0,gp_shoulderr)+gamepad_button_check_pressed(0,gp_shoulderl);
    
    // Alternate buttons
    xaxis+=gamepad_button_check(0,gp_padr);
    xaxis-=gamepad_button_check(0,gp_padl);
    yaxis+=gamepad_button_check(0,gp_padd);
    yaxis-=gamepad_button_check(0,gp_padu);
    shoot_key+=gamepad_button_check_pressed(0,gp_face1);
    use_key+=gamepad_button_check_pressed(0,gp_face2);
}
*/
