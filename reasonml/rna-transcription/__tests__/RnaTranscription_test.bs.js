// Generated by BUCKLESCRIPT VERSION 4.0.6, PLEASE EDIT WITH CARE
'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.js");
var RnaTranscription$RnaTranscription = require("../src/RnaTranscription.bs.js");

describe("Rna-transcription", (function () {
        Jest.test("transcribes empty list", (function () {
                return Jest.Expect[/* toEqual */12](/* [] */0, Jest.Expect[/* expect */0](RnaTranscription$RnaTranscription.toRna(/* [] */0)));
              }));
        Jest.test("transcribes cytidine", (function () {
                return Jest.Expect[/* toEqual */12](/* :: */[
                            /* G */2,
                            /* [] */0
                          ], Jest.Expect[/* expect */0](RnaTranscription$RnaTranscription.toRna(/* :: */[
                                    /* C */1,
                                    /* [] */0
                                  ])));
              }));
        Jest.test("transcribes guanosine", (function () {
                return Jest.Expect[/* toEqual */12](/* :: */[
                            /* C */1,
                            /* [] */0
                          ], Jest.Expect[/* expect */0](RnaTranscription$RnaTranscription.toRna(/* :: */[
                                    /* G */2,
                                    /* [] */0
                                  ])));
              }));
        Jest.test("transcribes adenosie", (function () {
                return Jest.Expect[/* toEqual */12](/* :: */[
                            /* U */3,
                            /* [] */0
                          ], Jest.Expect[/* expect */0](RnaTranscription$RnaTranscription.toRna(/* :: */[
                                    /* A */0,
                                    /* [] */0
                                  ])));
              }));
        Jest.test("transcribes thymidine", (function () {
                return Jest.Expect[/* toEqual */12](/* :: */[
                            /* A */0,
                            /* [] */0
                          ], Jest.Expect[/* expect */0](RnaTranscription$RnaTranscription.toRna(/* :: */[
                                    /* T */3,
                                    /* [] */0
                                  ])));
              }));
        return Jest.test("transcribes multiple", (function () {
                      return Jest.Expect[/* toEqual */12](/* :: */[
                                  /* U */3,
                                  /* :: */[
                                    /* G */2,
                                    /* :: */[
                                      /* C */1,
                                      /* :: */[
                                        /* A */0,
                                        /* :: */[
                                          /* C */1,
                                          /* :: */[
                                            /* C */1,
                                            /* :: */[
                                              /* A */0,
                                              /* :: */[
                                                /* G */2,
                                                /* :: */[
                                                  /* A */0,
                                                  /* :: */[
                                                    /* A */0,
                                                    /* :: */[
                                                      /* U */3,
                                                      /* :: */[
                                                        /* U */3,
                                                        /* [] */0
                                                      ]
                                                    ]
                                                  ]
                                                ]
                                              ]
                                            ]
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ], Jest.Expect[/* expect */0](RnaTranscription$RnaTranscription.toRna(/* :: */[
                                          /* A */0,
                                          /* :: */[
                                            /* C */1,
                                            /* :: */[
                                              /* G */2,
                                              /* :: */[
                                                /* T */3,
                                                /* :: */[
                                                  /* G */2,
                                                  /* :: */[
                                                    /* G */2,
                                                    /* :: */[
                                                      /* T */3,
                                                      /* :: */[
                                                        /* C */1,
                                                        /* :: */[
                                                          /* T */3,
                                                          /* :: */[
                                                            /* T */3,
                                                            /* :: */[
                                                              /* A */0,
                                                              /* :: */[
                                                                /* A */0,
                                                                /* [] */0
                                                              ]
                                                            ]
                                                          ]
                                                        ]
                                                      ]
                                                    ]
                                                  ]
                                                ]
                                              ]
                                            ]
                                          ]
                                        ])));
                    }));
      }));

/*  Not a pure module */
