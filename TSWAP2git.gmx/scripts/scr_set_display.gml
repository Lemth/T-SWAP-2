///scr_set_display()

var ideal_width=640;
var ideal_height=360; // room size

aspect_ratio=display_get_width()/display_get_height();

if (round(aspect_ratio*100)>=round(1600/9)) { // if 16:9 or wider
    ideal_width=round(ideal_height*aspect_ratio);
} else { // if smaller than 16:9
    ideal_height=round(ideal_width / aspect_ratio);
}

// Pixel perfect scaling
if(display_get_width() mod ideal_width != 0) {
    var d = round(display_get_width()/ideal_width);
    ideal_width=display_get_width()/d;
}
if(display_get_height() mod ideal_height != 0) { // no problem if 720p, 1080p,1440, 2560p etc.
    var d = round(display_get_height()/ideal_height);
    ideal_height=display_get_height()/d;
}

//Check for odd numbers
if(ideal_width & 1) {
    ideal_width++; }
if(ideal_height & 1) {
    ideal_height++; }

for(var i=1; i<=room_last; i++) {
    if(room_exists(i)) {
        room_set_view(i,0,true,0,0,ideal_width,ideal_height,0,0,ideal_width,ideal_height,0,0,0,0,-1);
        room_set_view_enabled(i,true);
    }
}

surface_resize(application_surface,ideal_width,ideal_height);
//display_set_gui_size(ideal_width,ideal_height);
window_set_size(ideal_width,ideal_height);
alarm[0]=1; // Recenter window if windowed
room_goto(room_next(room));

