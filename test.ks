//hellolaunch

// functions 
declare function printAzimuth {
    parameter azimuth.
    clearScreen.
    print "azimuth: " + azimuth.
}

// costants
declare atmosfere_height is 200000.

//First, we'll clear the terminal screen to make it look nice
CLEARSCREEN.

//Next, we'll lock our throttle to 100%.
LOCK THROTTLE TO 1.0.   // 1.0 is the max, 0.0 is idle.

//This is our countdown loop, which cycles from 10 to 0
PRINT "Counting down:".
FROM {local countdown is 5.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1. // pauses the script here for 1 second.
}

//This is a trigger that constantly checks to see if our thrust is zero.
//If it is, it will attempt to stage and then return to where the script
//left off. The PRESERVE keyword keeps the trigger active even after it
//has been triggered.
WHEN stage:liquidfuel < 0.1 THEN {
    PRINT "Staging".
    STAGE.
    PRESERVE.
}.

//This will be our main control loop for the ascent. It will
//cycle through continuously until our apoapsis is greater
//than 100km. Each cycle, it will check each of the IF
//statements inside and perform them if their conditions
//are met
SET MYSTEER TO HEADING(90,90).
LOCK STEERING TO MYSTEER. // from now on we'll be able to change steering by just assigning a new value to MYSTEER

declare azimuth is 85. 

until ship:altitude > 500 {
    set MYSTEER to heading(90, azimuth).
}.

until orbit:apoapsis > atmosfere_height {
    declare old_apoapsis is orbit:APOAPSIS.
    //declare old_periapsis is ETA:PERIAPSIS.

    if orbit:APOAPSIS < old_apoapsis and azimuth > 45 {
        set azimuth to azimuth - 1.
    } else if azimuth < 55 {
        set azimuth to azimuth + 1.
    }.

    set MYSTEER to heading(90, azimuth).
    printAzimuth(azimuth).
    wait 0.1.
}.

LOCK THROTTLE TO 0.0. 

until eta:apoapsis < 15.

lock throttle to 1.0.

until orbit:periapsis > atmosfere_height {
    set MYSTEER to heading(90, 0).
}.
