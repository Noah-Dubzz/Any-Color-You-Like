// Step Event
if (global.timer_initialized = true && global.timer > -1){
global.timer -= global.delta_multiplier / room_speed;
}

global.levelscompleted = global.Score / 1000;