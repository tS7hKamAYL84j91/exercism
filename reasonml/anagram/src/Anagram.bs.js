// Generated by BUCKLESCRIPT VERSION 4.0.6, PLEASE EDIT WITH CARE
'use strict';

var List = require("bs-platform/lib/js/list.js");
var $$String = require("bs-platform/lib/js/string.js");

function anagrams(word, anagrams$1) {
  var normalise = function (word) {
    return $$String.lowercase(word).split("").sort().join();
  };
  return List.filter((function (param) {
                  var word$1 = word;
                  var anagram = param;
                  if (normalise(word$1) === normalise(anagram)) {
                    return word$1 !== $$String.uppercase(anagram);
                  } else {
                    return false;
                  }
                }))(anagrams$1);
}

exports.anagrams = anagrams;
/* No side effect */