// Generated by BUCKLESCRIPT VERSION 4.0.6, PLEASE EDIT WITH CARE
'use strict';


function orbitalPeriod(param) {
  switch (param) {
    case 0 : 
        return 31557600 * 0.2408467;
    case 1 : 
        return 31557600 * 0.61519726;
    case 2 : 
        return 31557600;
    case 3 : 
        return 31557600 * 1.8808158;
    case 4 : 
        return 31557600 * 11.862615;
    case 5 : 
        return 31557600 * 29.447498;
    case 6 : 
        return 31557600 * 164.79132;
    case 7 : 
        return 31557600 * 84.016846;
    
  }
}

function ageOn(planet, age) {
  return age / orbitalPeriod(planet);
}

exports.ageOn = ageOn;
/* No side effect */