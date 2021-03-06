// Generated by BUCKLESCRIPT VERSION 4.0.6, PLEASE EDIT WITH CARE
'use strict';

var $$String = require("bs-platform/lib/js/string.js");

function hey(input) {
  var shouting = function (input) {
    if ($$String.uppercase(input) === input) {
      return $$String.lowercase(input) !== input;
    } else {
      return false;
    }
  };
  var question = function (input) {
    if (input === "") {
      return false;
    } else {
      return $$String.sub(input, input.length - 1 | 0, 1) === "?";
    }
  };
  var shouting_a_question = function (input) {
    if (shouting(input)) {
      return question(input);
    } else {
      return false;
    }
  };
  var input$1 = $$String.trim(input);
  if (shouting_a_question(input$1)) {
    return "Calm down, I know what I'm doing!";
  } else if (shouting(input$1)) {
    return "Whoa, chill out!";
  } else if (question(input$1)) {
    return "Sure.";
  } else if (input$1 === "") {
    return "Fine. Be that way!";
  } else {
    return "Whatever.";
  }
}

exports.hey = hey;
/* No side effect */
