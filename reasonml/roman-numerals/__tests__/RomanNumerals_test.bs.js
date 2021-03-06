// Generated by BUCKLESCRIPT VERSION 4.0.6, PLEASE EDIT WITH CARE
'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var RomanNumerals$RomanNumerals = require("../src/RomanNumerals.bs.js");

describe("RomanNumerals", (function () {
        Jest.test("1 is a single I", (function () {
                return Jest.Expect[/* toEqual */12]("I", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(1)));
              }));
        Jest.test("2 is two I's", (function () {
                return Jest.Expect[/* toEqual */12]("II", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(2)));
              }));
        Jest.test("3 is three I's", (function () {
                return Jest.Expect[/* toEqual */12]("III", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(3)));
              }));
        Jest.test("4, being 5 - 1, is IV", (function () {
                return Jest.Expect[/* toEqual */12]("IV", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(4)));
              }));
        Jest.test("5 is a single V", (function () {
                return Jest.Expect[/* toEqual */12]("V", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(5)));
              }));
        Jest.test("6, being 5 + 1, is VI", (function () {
                return Jest.Expect[/* toEqual */12]("VI", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(6)));
              }));
        Jest.test("9, being 10 - 1, is IX", (function () {
                return Jest.Expect[/* toEqual */12]("IX", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(9)));
              }));
        Jest.test("20 is two X's", (function () {
                return Jest.Expect[/* toEqual */12]("XXVII", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(27)));
              }));
        Jest.test("48 is not 50 - 2 but rather 40 + 8", (function () {
                return Jest.Expect[/* toEqual */12]("XLVIII", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(48)));
              }));
        Jest.test("49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1", (function () {
                return Jest.Expect[/* toEqual */12]("XLIX", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(49)));
              }));
        Jest.test("50 is a single L", (function () {
                return Jest.Expect[/* toEqual */12]("LIX", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(59)));
              }));
        Jest.test("90, being 100 - 10, is XC", (function () {
                return Jest.Expect[/* toEqual */12]("XCIII", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(93)));
              }));
        Jest.test("100 is a single C", (function () {
                return Jest.Expect[/* toEqual */12]("CXLI", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(141)));
              }));
        Jest.test("60, being 50 + 10, is LX", (function () {
                return Jest.Expect[/* toEqual */12]("CLXIII", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(163)));
              }));
        Jest.test("400, being 500 - 100, is CD", (function () {
                return Jest.Expect[/* toEqual */12]("CDII", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(402)));
              }));
        Jest.test("500 is a single D", (function () {
                return Jest.Expect[/* toEqual */12]("DLXXV", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(575)));
              }));
        Jest.test("900, being 1000 - 100, is CM", (function () {
                return Jest.Expect[/* toEqual */12]("CMXI", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(911)));
              }));
        Jest.test("1000 is a single M", (function () {
                return Jest.Expect[/* toEqual */12]("MXXIV", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(1024)));
              }));
        return Jest.test("3000 is three M's", (function () {
                      return Jest.Expect[/* toEqual */12]("MMM", Jest.Expect[/* expect */0](RomanNumerals$RomanNumerals.toRoman(3000)));
                    }));
      }));

/*  Not a pure module */
