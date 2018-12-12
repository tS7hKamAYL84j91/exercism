// Generated by BUCKLESCRIPT VERSION 4.0.6, PLEASE EDIT WITH CARE
'use strict';

var List = require("bs-platform/lib/js/list.js");
var $$Array = require("bs-platform/lib/js/array.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Belt_Option = require("bs-platform/lib/js/belt_Option.js");
var Js_primitive = require("bs-platform/lib/js/js_primitive.js");

function protiens_of_string(param) {
  switch (param) {
    case "AUG" : 
        return "Methionine";
    case "UAC" : 
    case "UAU" : 
        return "Tyrosine";
    case "UCA" : 
    case "UCC" : 
    case "UCG" : 
    case "UCU" : 
        return "Serine";
    case "UGG" : 
        return "Tryptophan";
    case "UGC" : 
    case "UGU" : 
        return "Cysteine";
    case "UUA" : 
    case "UUG" : 
        return "Leucine";
    case "UUC" : 
    case "UUU" : 
        return "Phenylalanine";
    default:
      return undefined;
  }
}

function take_while(f, xs) {
  if (xs) {
    var x = xs[0];
    if (Curry._1(f, x) === true) {
      return /* :: */[
              x,
              take_while(f, xs[1])
            ];
    } else {
      return /* [] */0;
    }
  } else {
    return /* [] */0;
  }
}

function proteins(str) {
  return List.map(Belt_Option.getExn, take_while((function (x) {
                    return x !== undefined;
                  }), Belt_Option.getWithDefault(Belt_Option.map(Js_primitive.null_to_opt(str.match((/.{1,3}/g))), (function (x) {
                            return List.map(protiens_of_string, $$Array.to_list(x));
                          })), /* [] */0)));
}

exports.proteins = proteins;
/* No side effect */
