clearScreen.

lock throttle to 1.0.
STAGE.
wait 1.

print "... heating ...".
FROM {local countdown is 5.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1. // pauses the script here for 1 second.
}
print "heating complete".
print "launching ...".

stage.

set mysteer to heading(270, 80).
lock steering to mysteer.

//declare azimuth to 0.
// declare power to 0.

until ship:altitude > 50000 {}

until 0 {
    
    // if ship:airspeed < 290 {
    //     set power to power + 0.1.
    // } else {
    //     set power to power - 0.1.
    // }
    // lock throttle to power.

    if ship:altitude >= 50000 {
        set mysteer to heading(270, 10).
    } else {
        set mysteer to heading(270, 15).    
    }
    wait 0.01.
}

