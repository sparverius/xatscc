# xatscc
xanadu-lang compiler system

### Prerequisites

```
ATS2 >= v0.4.0
```

### Getting Started

```
git clone --recursive https://github.com/sparverius/xatscc.git
cd xatscc
make
```

### Usage

```
./bin/xatsopt -d TEST/foldl.dats
./bin/xinterp -d TEST/foldl.dats
./bin/xjsonize -d TEST/foldl.dats
```

NOTE: xjsonize will emit the (verbose) json syntax trees for each phase of the ATS3 compilation. The stages 00, 01, 12, 23, 33, 3t... more details/explination to follow...
The results of this command can be found in a dirrectory titled 'out' in your cwd

---

## xjsonize

- xjsonize is an ats3 compiler extension, see https://github.com/sparverius/xjsonize

### Brief overview, 
- written in ats2 
- similar to xinterp, links the ats3 compiler library (libxatsopt)
- exports the AST at any level of compilation as json
- provides a library libxjsonize 
- link other extensions with -lxjsonize
- for example, https://github.com/sparverius/xatscc,
- - this example links both libxatsopt and libxjsonize to xinterp for jsonizing the the tree of the interpreter
- Later versions can suit specific needs however, for now the jsonized output is currently meant to be as verbose as possible with the exception of location information. 
- Also, the labify branch provides a flatter representation than the master branch. 

### Possible use cases:
- Learn about each translation phase of the ats3 compiler
- Export AST to write extensions in any programming language you wish. 
- Something else you think of entirely??
- Reading through the AST in json form can aid with understanding the compilation phases of ats3. 
- I hope you find it useful!


### EXAMPLE 
Here is an example of an ATS3 implementation of an Option type.
```
datatype optn(a:type+) =
  | none(a) of ()
  | some(a) of (a)

fun<a:type><b:type>
map_list(xs:list(a), f0: a -> b) : list(b) =
(
case+ xs of
| list_nil() => list_nil()
| list_cons(x0, xs) => list_cons(f0(x0), map_list(xs, f0))
)

fun<a:type><b:type>
map_optn(xs: optn(a), f0: a -> b) : optn(b) =
(
case+ xs of
| none() => none()
| some(x) => some(f0(x))
)

#symload map with map_list
#symload map with map_optn

val xs = list_cons(1, list_cons(2, list_nil()))

val r0 = some(xs)

val r1 = map(r0, res) where val res =
  lam (k) =>
    map_list(k, lam (x) => if x % 2 = 0 then true else false)
end
```

### EXAMPLE XJSONIZE OUTPUT OF THE INTERPRETED AST IN JSON FORM

And here is the entire 2000+ lines of pretty printed AST of the (current last) phase of interpretation... remember, ATS3 is meant to unleash the power of types.
```json
{
 "ir0dclist": [
  {
   "ir0dcl": {
    "IR0Cnone1": {
     "d3ecl": {
      "D3Cnone1": {
       "d2ecl": {
        "D2Cdatatype": {
         "d1ecl": {
          "D1Cdatatype": {
           "knd": {
            "token": {
             "tnode": {
              "DATATYPE": {
               "int": 0
              }
             }
            }
           },
           "d1atypelst": [
            {
             "d1atype": {
              "D1ATYPE": {
               "token": {
                "tnode": {
                 "IDENT_alp": "optn"
                }
               },
               "t1marglst": [
                {
                 "t1marg": {
                  "T1MARGlist": {
                   "t1arglst": [
                    {
                     "t1arg": {
                      "T1ARGsome": {
                       "sort1": {
                        "S1Tapp1": {
                         "sort1": {
                          "S1Tid": {
                           "symbol": "type"
                          }
                         }
                        }
                       },
                       "tokenopt": {
                        "token": {
                         "tnode": {
                          "IDENT_alp": "a"
                         }
                        }
                       }
                      }
                     }
                    }
                   ]
                  }
                 }
                }
               ],
               "sort1opt": {},
               "d1atconlst": [
                {
                 "d1atcon": {
                  "D1ATCON": {
                   "s1unilst": [],
                   "token": {
                    "tnode": {
                     "IDENT_alp": "none"
                    }
                   },
                   "s1explst": [
                    {
                     "s1exp": {
                      "S1Elist": {
                       "s1explst": [
                        {
                         "s1exp": {
                          "S1Eid": {
                           "symbol": "a"
                          }
                         }
                        }
                       ]
                      }
                     }
                    }
                   ],
                   "s1expopt": {
                    "s1exp": {
                     "S1Elist": {
                      "s1explst": []
                     }
                    }
                   }
                  }
                 }
                },
                {
                 "d1atcon": {
                  "D1ATCON": {
                   "s1unilst": [],
                   "token": {
                    "tnode": {
                     "IDENT_alp": "some"
                    }
                   },
                   "s1explst": [
                    {
                     "s1exp": {
                      "S1Elist": {
                       "s1explst": [
                        {
                         "s1exp": {
                          "S1Eid": {
                           "symbol": "a"
                          }
                         }
                        }
                       ]
                      }
                     }
                    }
                   ],
                   "s1expopt": {
                    "s1exp": {
                     "S1Elist": {
                      "s1explst": [
                       {
                        "s1exp": {
                         "S1Eid": {
                          "symbol": "a"
                         }
                        }
                       }
                      ]
                     }
                    }
                   }
                  }
                 }
                }
               ]
              }
             }
            }
           ],
           "wd1eclseq": {
            "WD1CSnone": {}
           }
          }
         }
        }
       }
      }
     }
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cfundecl": {
     "token": {
      "tnode": {
       "FUN": {
        "funkind": "FNKfn1"
       }
      }
     },
     "decmodopt": {
      "DECOMODnone": {}
     },
     "tq2arglst": [
      {
       "tq2arg": {
        "s2varlst": [
         {
          "s2var": {
           "symbol": "a",
           "stamp": "363"
          }
         }
        ]
       }
      },
      {
       "tq2arg": {
        "s2varlst": [
         {
          "s2var": {
           "symbol": "b",
           "stamp": "364"
          }
         }
        ]
       }
      }
     ],
     "ir0fundeclist": [
      {
       "ir0fundecl": {
        "IR0FUNDECL": {
         "d2var": {
          "symbol": "map_list",
          "stamp": "0"
         },
         "d2cst": {
          "symbol": "map_list",
          "stamp": "112"
         },
         "f2arglst": [
          {
           "f2arg": {
            "F2ARGsome_dyn": {
             "npf": "-1",
             "d2patlst": [
              {
               "d2pat": {
                "D2Panno": {
                 "d2pat": {
                  "D2Pvar": {
                   "d2var": {
                    "symbol": "xs",
                    "stamp": "1"
                   }
                  }
                 },
                 "s2exp": {
                  "S2Eapp": {
                   "s2exp": {
                    "S2Ecst": {
                     "s2cst": {
                      "symbol": "list",
                      "stamp": "145"
                     }
                    }
                   },
                   "s2explst": [
                    {
                     "s2exp": {
                      "S2Evar": {
                       "s2var": {
                        "symbol": "a",
                        "stamp": "363"
                       }
                      }
                     }
                    }
                   ]
                  }
                 }
                }
               }
              },
              {
               "d2pat": {
                "D2Panno": {
                 "d2pat": {
                  "D2Pvar": {
                   "d2var": {
                    "symbol": "f0",
                    "stamp": "2"
                   }
                  }
                 },
                 "s2exp": {
                  "S2Efun": {
                   "funclo2": {
                    "FC2fun": {}
                   },
                   "npf": {
                    "int": -1
                   },
                   "s2explst": [
                    {
                     "s2exp": {
                      "S2Evar": {
                       "s2var": {
                        "symbol": "a",
                        "stamp": "363"
                       }
                      }
                     }
                    }
                   ],
                   "s2exp": {
                    "S2Evar": {
                     "s2var": {
                      "symbol": "b",
                      "stamp": "364"
                     }
                    }
                   }
                  }
                 }
                }
               }
              }
             ]
            }
           }
          }
         ],
         "ir0arglst": [
          {
           "ir0arg": {
            "IR0ARGsome": {
             "npf": "-1",
             "ir0patlst": [
              {
               "ir0pat": {
                "IR0Pvar": {
                 "d2var": {
                  "symbol": "xs",
                  "stamp": "1"
                 }
                }
               }
              },
              {
               "ir0pat": {
                "IR0Pvar": {
                 "d2var": {
                  "symbol": "f0",
                  "stamp": "2"
                 }
                }
               }
              }
             ]
            }
           }
          }
         ],
         "ir0exp": {
          "IR0Ecase": {
           "int": 1,
           "ir0exp": {
            "IR0Evar": {
             "d2var": {
              "symbol": "xs",
              "stamp": "1"
             }
            }
           },
           "ir0claulst": [
            {
             "ir0clau": {
              "IR0CLAUpat": {
               "ir0gpat": {
                "IR0GPATpat": {
                 "ir0pat": {
                  "IR0Pcapp": {
                   "d2con": {
                    "symbol": "list_nil",
                    "stamp": "6"
                   },
                   "ir0patlst": []
                  }
                 }
                }
               },
               "ir0exp": {
                "IR0Edapp": {
                 "ir0exp": {
                  "IR0Econ1": {
                   "d2con": {
                    "symbol": "list_nil",
                    "stamp": "6"
                   }
                  }
                 },
                 "npf": "-1",
                 "ir0explst": []
                }
               }
              }
             }
            },
            {
             "ir0clau": {
              "IR0CLAUpat": {
               "ir0gpat": {
                "IR0GPATpat": {
                 "ir0pat": {
                  "IR0Pcapp": {
                   "d2con": {
                    "symbol": "list_cons",
                    "stamp": "7"
                   },
                   "ir0patlst": [
                    {
                     "ir0pat": {
                      "IR0Pvar": {
                       "d2var": {
                        "symbol": "x0",
                        "stamp": "3"
                       }
                      }
                     }
                    },
                    {
                     "ir0pat": {
                      "IR0Pvar": {
                       "d2var": {
                        "symbol": "xs",
                        "stamp": "4"
                       }
                      }
                     }
                    }
                   ]
                  }
                 }
                }
               },
               "ir0exp": {
                "IR0Edapp": {
                 "ir0exp": {
                  "IR0Econ1": {
                   "d2con": {
                    "symbol": "list_cons",
                    "stamp": "7"
                   }
                  }
                 },
                 "npf": "-1",
                 "ir0explst": [
                  {
                   "ir0exp": {
                    "IR0Edapp": {
                     "ir0exp": {
                      "IR0Evar": {
                       "d2var": {
                        "symbol": "f0",
                        "stamp": "2"
                       }
                      }
                     },
                     "npf": "-1",
                     "ir0explst": [
                      {
                       "ir0exp": {
                        "IR0Evar": {
                         "d2var": {
                          "symbol": "x0",
                          "stamp": "3"
                         }
                        }
                       }
                      }
                     ]
                    }
                   }
                  },
                  {
                   "ir0exp": {
                    "IR0Edapp": {
                     "ir0exp": {
                      "IR0Evar": {
                       "d2var": {
                        "symbol": "map_list",
                        "stamp": "0"
                       }
                      }
                     },
                     "npf": "-1",
                     "ir0explst": [
                      {
                       "ir0exp": {
                        "IR0Evar": {
                         "d2var": {
                          "symbol": "xs",
                          "stamp": "4"
                         }
                        }
                       }
                      },
                      {
                       "ir0exp": {
                        "IR0Evar": {
                         "d2var": {
                          "symbol": "f0",
                          "stamp": "2"
                         }
                        }
                       }
                      }
                     ]
                    }
                   }
                  }
                 ]
                }
               }
              }
             }
            }
           ]
          }
         }
        }
       }
      }
     ]
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cfundecl": {
     "token": {
      "tnode": {
       "FUN": {
        "funkind": "FNKfn1"
       }
      }
     },
     "decmodopt": {
      "DECOMODnone": {}
     },
     "tq2arglst": [
      {
       "tq2arg": {
        "s2varlst": [
         {
          "s2var": {
           "symbol": "a",
           "stamp": "365"
          }
         }
        ]
       }
      },
      {
       "tq2arg": {
        "s2varlst": [
         {
          "s2var": {
           "symbol": "b",
           "stamp": "366"
          }
         }
        ]
       }
      }
     ],
     "ir0fundeclist": [
      {
       "ir0fundecl": {
        "IR0FUNDECL": {
         "d2var": {
          "symbol": "map_optn",
          "stamp": "5"
         },
         "d2cst": {
          "symbol": "map_optn",
          "stamp": "113"
         },
         "f2arglst": [
          {
           "f2arg": {
            "F2ARGsome_dyn": {
             "npf": "-1",
             "d2patlst": [
              {
               "d2pat": {
                "D2Panno": {
                 "d2pat": {
                  "D2Pvar": {
                   "d2var": {
                    "symbol": "xs",
                    "stamp": "6"
                   }
                  }
                 },
                 "s2exp": {
                  "S2Eapp": {
                   "s2exp": {
                    "S2Ecst": {
                     "s2cst": {
                      "symbol": "optn",
                      "stamp": "210"
                     }
                    }
                   },
                   "s2explst": [
                    {
                     "s2exp": {
                      "S2Evar": {
                       "s2var": {
                        "symbol": "a",
                        "stamp": "365"
                       }
                      }
                     }
                    }
                   ]
                  }
                 }
                }
               }
              },
              {
               "d2pat": {
                "D2Panno": {
                 "d2pat": {
                  "D2Pvar": {
                   "d2var": {
                    "symbol": "f0",
                    "stamp": "7"
                   }
                  }
                 },
                 "s2exp": {
                  "S2Efun": {
                   "funclo2": {
                    "FC2fun": {}
                   },
                   "npf": {
                    "int": -1
                   },
                   "s2explst": [
                    {
                     "s2exp": {
                      "S2Evar": {
                       "s2var": {
                        "symbol": "a",
                        "stamp": "365"
                       }
                      }
                     }
                    }
                   ],
                   "s2exp": {
                    "S2Evar": {
                     "s2var": {
                      "symbol": "b",
                      "stamp": "366"
                     }
                    }
                   }
                  }
                 }
                }
               }
              }
             ]
            }
           }
          }
         ],
         "ir0arglst": [
          {
           "ir0arg": {
            "IR0ARGsome": {
             "npf": "-1",
             "ir0patlst": [
              {
               "ir0pat": {
                "IR0Pvar": {
                 "d2var": {
                  "symbol": "xs",
                  "stamp": "6"
                 }
                }
               }
              },
              {
               "ir0pat": {
                "IR0Pvar": {
                 "d2var": {
                  "symbol": "f0",
                  "stamp": "7"
                 }
                }
               }
              }
             ]
            }
           }
          }
         ],
         "ir0exp": {
          "IR0Ecase": {
           "int": 1,
           "ir0exp": {
            "IR0Evar": {
             "d2var": {
              "symbol": "xs",
              "stamp": "6"
             }
            }
           },
           "ir0claulst": [
            {
             "ir0clau": {
              "IR0CLAUpat": {
               "ir0gpat": {
                "IR0GPATpat": {
                 "ir0pat": {
                  "IR0Pcapp": {
                   "d2con": {
                    "symbol": "none",
                    "stamp": "14"
                   },
                   "ir0patlst": []
                  }
                 }
                }
               },
               "ir0exp": {
                "IR0Edapp": {
                 "ir0exp": {
                  "IR0Econ1": {
                   "d2con": {
                    "symbol": "none",
                    "stamp": "14"
                   }
                  }
                 },
                 "npf": "-1",
                 "ir0explst": []
                }
               }
              }
             }
            },
            {
             "ir0clau": {
              "IR0CLAUpat": {
               "ir0gpat": {
                "IR0GPATpat": {
                 "ir0pat": {
                  "IR0Pcapp": {
                   "d2con": {
                    "symbol": "some",
                    "stamp": "15"
                   },
                   "ir0patlst": [
                    {
                     "ir0pat": {
                      "IR0Pvar": {
                       "d2var": {
                        "symbol": "x",
                        "stamp": "8"
                       }
                      }
                     }
                    }
                   ]
                  }
                 }
                }
               },
               "ir0exp": {
                "IR0Edapp": {
                 "ir0exp": {
                  "IR0Econ1": {
                   "d2con": {
                    "symbol": "some",
                    "stamp": "15"
                   }
                  }
                 },
                 "npf": "-1",
                 "ir0explst": [
                  {
                   "ir0exp": {
                    "IR0Edapp": {
                     "ir0exp": {
                      "IR0Evar": {
                       "d2var": {
                        "symbol": "f0",
                        "stamp": "7"
                       }
                      }
                     },
                     "npf": "-1",
                     "ir0explst": [
                      {
                       "ir0exp": {
                        "IR0Evar": {
                         "d2var": {
                          "symbol": "x",
                          "stamp": "8"
                         }
                        }
                       }
                      }
                     ]
                    }
                   }
                  }
                 ]
                }
               }
              }
             }
            }
           ]
          }
         }
        }
       }
      }
     ]
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cnone1": {
     "d3ecl": {
      "D3Cd2ecl": {
       "d2ecl": {
        "D2Csymload": {
         "token": {
          "tnode": "#SYMLOAD"
         },
         "symbol": "map",
         "d2pitm": {
          "D2PITMsome": {
           "pval": {
            "int": 0
           },
           "d2itm": {
            "D2ITMcst": {
             "d2cstlst": [
              {
               "d2cst": {
                "symbol": "map_list",
                "stamp": "112"
               }
              }
             ]
            }
           }
          }
         }
        }
       }
      }
     }
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cnone1": {
     "d3ecl": {
      "D3Cd2ecl": {
       "d2ecl": {
        "D2Csymload": {
         "token": {
          "tnode": "#SYMLOAD"
         },
         "symbol": "map",
         "d2pitm": {
          "D2PITMsome": {
           "pval": {
            "int": 0
           },
           "d2itm": {
            "D2ITMcst": {
             "d2cstlst": [
              {
               "d2cst": {
                "symbol": "map_optn",
                "stamp": "113"
               }
              }
             ]
            }
           }
          }
         }
        }
       }
      }
     }
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cvaldecl": {
     "token": {
      "tnode": {
       "VAL": {
        "valkind": "VLKval"
       }
      }
     },
     "decmodopt": {
      "DECOMODnone": {}
     },
     "ir0valdeclist": [
      {
       "ir0valdecl": {
        "IR0VALDECL": {
         "ir0pat": {
          "IR0Pvar": {
           "d2var": {
            "symbol": "xs",
            "stamp": "9"
           }
          }
         },
         "ir0exp": {
          "IR0Edapp": {
           "ir0exp": {
            "IR0Econ1": {
             "d2con": {
              "symbol": "list_cons",
              "stamp": "7"
             }
            }
           },
           "npf": "-1",
           "ir0explst": [
            {
             "ir0exp": {
              "IR0Eint": {
               "token": {
                "tnode": {
                 "INT1": "1"
                }
               }
              }
             }
            },
            {
             "ir0exp": {
              "IR0Edapp": {
               "ir0exp": {
                "IR0Econ1": {
                 "d2con": {
                  "symbol": "list_cons",
                  "stamp": "7"
                 }
                }
               },
               "npf": "-1",
               "ir0explst": [
                {
                 "ir0exp": {
                  "IR0Eint": {
                   "token": {
                    "tnode": {
                     "INT1": "2"
                    }
                   }
                  }
                 }
                },
                {
                 "ir0exp": {
                  "IR0Edapp": {
                   "ir0exp": {
                    "IR0Econ1": {
                     "d2con": {
                      "symbol": "list_nil",
                      "stamp": "6"
                     }
                    }
                   },
                   "npf": "-1",
                   "ir0explst": []
                  }
                 }
                }
               ]
              }
             }
            }
           ]
          }
         }
        }
       }
      }
     ]
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cvaldecl": {
     "token": {
      "tnode": {
       "VAL": {
        "valkind": "VLKval"
       }
      }
     },
     "decmodopt": {
      "DECOMODnone": {}
     },
     "ir0valdeclist": [
      {
       "ir0valdecl": {
        "IR0VALDECL": {
         "ir0pat": {
          "IR0Pvar": {
           "d2var": {
            "symbol": "r0",
            "stamp": "10"
           }
          }
         },
         "ir0exp": {
          "IR0Edapp": {
           "ir0exp": {
            "IR0Econ1": {
             "d2con": {
              "symbol": "some",
              "stamp": "15"
             }
            }
           },
           "npf": "-1",
           "ir0explst": [
            {
             "ir0exp": {
              "IR0Evar": {
               "d2var": {
                "symbol": "xs",
                "stamp": "9"
               }
              }
             }
            }
           ]
          }
         }
        }
       }
      }
     ]
    }
   }
  },
  {
   "ir0dcl": {
    "IR0Cvaldecl": {
     "token": {
      "tnode": {
       "VAL": {
        "valkind": "VLKval"
       }
      }
     },
     "decmodopt": {
      "DECOMODnone": {}
     },
     "ir0valdeclist": [
      {
       "ir0valdecl": {
        "IR0VALDECL": {
         "ir0pat": {
          "IR0Pvar": {
           "d2var": {
            "symbol": "r1",
            "stamp": "11"
           }
          }
         },
         "ir0exp": {
          "IR0Ewhere": {
           "ir0exp": {
            "IR0Edapp": {
             "ir0exp": {
              "IR0Etimp": {
               "ir0exp": {
                "IR0Etcst": {
                 "d2cst": {
                  "symbol": "map_optn",
                  "stamp": "113"
                 },
                 "ti3arg": {
                  "TI3ARGnone": {
                   "t2ypelst": [
                    {
                     "t2ype": {
                      "T2Pxtv": {
                       "t2ype": {
                        "T2Papp": {
                         "t2ype": {
                          "T2Pcst": {
                           "s2cst": {
                            "symbol": "list_t0_i0_x0",
                            "stamp": "141"
                           }
                          }
                         },
                         "t2ypelst": [
                          {
                           "t2ype": {
                            "T2Papp": {
                             "t2ype": {
                              "T2Pcst": {
                               "s2cst": {
                                "symbol": "gint_type",
                                "stamp": "87"
                               }
                              }
                             },
                             "t2ypelst": [
                              {
                               "t2ype": {
                                "T2Pcst": {
                                 "s2cst": {
                                  "symbol": "sint_k",
                                  "stamp": "72"
                                 }
                                }
                               }
                              },
                              {
                               "t2ype": {
                                "T2Pnone0": {}
                               }
                              }
                             ]
                            }
                           }
                          },
                          {
                           "t2ype": {
                            "T2Pnone0": {}
                           }
                          }
                         ]
                        }
                       }
                      }
                     }
                    },
                    {
                     "t2ype": {
                      "T2Pxtv": {
                       "t2ype": {
                        "T2Papp": {
                         "t2ype": {
                          "T2Pcst": {
                           "s2cst": {
                            "symbol": "list_t0_i0_x0",
                            "stamp": "141"
                           }
                          }
                         },
                         "t2ypelst": [
                          {
                           "t2ype": {
                            "T2Papp": {
                             "t2ype": {
                              "T2Pcst": {
                               "s2cst": {
                                "symbol": "bool_type",
                                "stamp": "80"
                               }
                              }
                             },
                             "t2ypelst": [
                              {
                               "t2ype": {
                                "T2Pnone0": {}
                               }
                              }
                             ]
                            }
                           }
                          },
                          {
                           "t2ype": {
                            "T2Pnone0": {}
                           }
                          }
                         ]
                        }
                       }
                      }
                     }
                    }
                   ]
                  }
                 },
                 "ti2arglst": []
                }
               },
               "t2ypelst": [
                {
                 "t2ype": {
                  "T2Papp": {
                   "t2ype": {
                    "T2Pcst": {
                     "s2cst": {
                      "symbol": "list_t0_i0_x0",
                      "stamp": "141"
                     }
                    }
                   },
                   "t2ypelst": [
                    {
                     "t2ype": {
                      "T2Papp": {
                       "t2ype": {
                        "T2Pcst": {
                         "s2cst": {
                          "symbol": "gint_type",
                          "stamp": "87"
                         }
                        }
                       },
                       "t2ypelst": [
                        {
                         "t2ype": {
                          "T2Pcst": {
                           "s2cst": {
                            "symbol": "sint_k",
                            "stamp": "72"
                           }
                          }
                         }
                        },
                        {
                         "t2ype": {
                          "T2Pnone0": {}
                         }
                        }
                       ]
                      }
                     }
                    },
                    {
                     "t2ype": {
                      "T2Pnone0": {}
                     }
                    }
                   ]
                  }
                 }
                },
                {
                 "t2ype": {
                  "T2Papp": {
                   "t2ype": {
                    "T2Pcst": {
                     "s2cst": {
                      "symbol": "list_t0_i0_x0",
                      "stamp": "141"
                     }
                    }
                   },
                   "t2ypelst": [
                    {
                     "t2ype": {
                      "T2Papp": {
                       "t2ype": {
                        "T2Pcst": {
                         "s2cst": {
                          "symbol": "bool_type",
                          "stamp": "80"
                         }
                        }
                       },
                       "t2ypelst": [
                        {
                         "t2ype": {
                          "T2Pnone0": {}
                         }
                        }
                       ]
                      }
                     }
                    },
                    {
                     "t2ype": {
                      "T2Pnone0": {}
                     }
                    }
                   ]
                  }
                 }
                }
               ],
               "ir0dcl": {
                "IR0Cfundecl": {
                 "token": {
                  "tnode": {
                   "FUN": {
                    "funkind": "FNKfn1"
                   }
                  }
                 },
                 "decmodopt": {
                  "DECOMODnone": {}
                 },
                 "tq2arglst": [
                  {
                   "tq2arg": {
                    "s2varlst": [
                     {
                      "s2var": {
                       "symbol": "a",
                       "stamp": "365"
                      }
                     }
                    ]
                   }
                  },
                  {
                   "tq2arg": {
                    "s2varlst": [
                     {
                      "s2var": {
                       "symbol": "b",
                       "stamp": "366"
                      }
                     }
                    ]
                   }
                  }
                 ],
                 "ir0fundeclist": [
                  {
                   "ir0fundecl": {
                    "IR0FUNDECL": {
                     "d2var": {
                      "symbol": "map_optn",
                      "stamp": "5"
                     },
                     "d2cst": {
                      "symbol": "map_optn",
                      "stamp": "113"
                     },
                     "f2arglst": [
                      {
                       "f2arg": {
                        "F2ARGsome_dyn": {
                         "npf": "-1",
                         "d2patlst": [
                          {
                           "d2pat": {
                            "D2Panno": {
                             "d2pat": {
                              "D2Pvar": {
                               "d2var": {
                                "symbol": "xs",
                                "stamp": "6"
                               }
                              }
                             },
                             "s2exp": {
                              "S2Eapp": {
                               "s2exp": {
                                "S2Ecst": {
                                 "s2cst": {
                                  "symbol": "optn",
                                  "stamp": "210"
                                 }
                                }
                               },
                               "s2explst": [
                                {
                                 "s2exp": {
                                  "S2Evar": {
                                   "s2var": {
                                    "symbol": "a",
                                    "stamp": "365"
                                   }
                                  }
                                 }
                                }
                               ]
                              }
                             }
                            }
                           }
                          },
                          {
                           "d2pat": {
                            "D2Panno": {
                             "d2pat": {
                              "D2Pvar": {
                               "d2var": {
                                "symbol": "f0",
                                "stamp": "7"
                               }
                              }
                             },
                             "s2exp": {
                              "S2Efun": {
                               "funclo2": {
                                "FC2fun": {}
                               },
                               "npf": {
                                "int": -1
                               },
                               "s2explst": [
                                {
                                 "s2exp": {
                                  "S2Evar": {
                                   "s2var": {
                                    "symbol": "a",
                                    "stamp": "365"
                                   }
                                  }
                                 }
                                }
                               ],
                               "s2exp": {
                                "S2Evar": {
                                 "s2var": {
                                  "symbol": "b",
                                  "stamp": "366"
                                 }
                                }
                               }
                              }
                             }
                            }
                           }
                          }
                         ]
                        }
                       }
                      }
                     ],
                     "ir0arglst": [
                      {
                       "ir0arg": {
                        "IR0ARGsome": {
                         "npf": "-1",
                         "ir0patlst": [
                          {
                           "ir0pat": {
                            "IR0Pvar": {
                             "d2var": {
                              "symbol": "xs",
                              "stamp": "6"
                             }
                            }
                           }
                          },
                          {
                           "ir0pat": {
                            "IR0Pvar": {
                             "d2var": {
                              "symbol": "f0",
                              "stamp": "7"
                             }
                            }
                           }
                          }
                         ]
                        }
                       }
                      }
                     ],
                     "ir0exp": {
                      "IR0Ecase": {
                       "int": 1,
                       "ir0exp": {
                        "IR0Evar": {
                         "d2var": {
                          "symbol": "xs",
                          "stamp": "6"
                         }
                        }
                       },
                       "ir0claulst": [
                        {
                         "ir0clau": {
                          "IR0CLAUpat": {
                           "ir0gpat": {
                            "IR0GPATpat": {
                             "ir0pat": {
                              "IR0Pcapp": {
                               "d2con": {
                                "symbol": "none",
                                "stamp": "14"
                               },
                               "ir0patlst": []
                              }
                             }
                            }
                           },
                           "ir0exp": {
                            "IR0Edapp": {
                             "ir0exp": {
                              "IR0Econ1": {
                               "d2con": {
                                "symbol": "none",
                                "stamp": "14"
                               }
                              }
                             },
                             "npf": "-1",
                             "ir0explst": []
                            }
                           }
                          }
                         }
                        },
                        {
                         "ir0clau": {
                          "IR0CLAUpat": {
                           "ir0gpat": {
                            "IR0GPATpat": {
                             "ir0pat": {
                              "IR0Pcapp": {
                               "d2con": {
                                "symbol": "some",
                                "stamp": "15"
                               },
                               "ir0patlst": [
                                {
                                 "ir0pat": {
                                  "IR0Pvar": {
                                   "d2var": {
                                    "symbol": "x",
                                    "stamp": "8"
                                   }
                                  }
                                 }
                                }
                               ]
                              }
                             }
                            }
                           },
                           "ir0exp": {
                            "IR0Edapp": {
                             "ir0exp": {
                              "IR0Econ1": {
                               "d2con": {
                                "symbol": "some",
                                "stamp": "15"
                               }
                              }
                             },
                             "npf": "-1",
                             "ir0explst": [
                              {
                               "ir0exp": {
                                "IR0Edapp": {
                                 "ir0exp": {
                                  "IR0Evar": {
                                   "d2var": {
                                    "symbol": "f0",
                                    "stamp": "7"
                                   }
                                  }
                                 },
                                 "npf": "-1",
                                 "ir0explst": [
                                  {
                                   "ir0exp": {
                                    "IR0Evar": {
                                     "d2var": {
                                      "symbol": "x",
                                      "stamp": "8"
                                     }
                                    }
                                   }
                                  }
                                 ]
                                }
                               }
                              }
                             ]
                            }
                           }
                          }
                         }
                        }
                       ]
                      }
                     }
                    }
                   }
                  }
                 ]
                }
               }
              }
             },
             "npf": "-1",
             "ir0explst": [
              {
               "ir0exp": {
                "IR0Evar": {
                 "d2var": {
                  "symbol": "r0",
                  "stamp": "10"
                 }
                }
               }
              },
              {
               "ir0exp": {
                "IR0Evar": {
                 "d2var": {
                  "symbol": "res",
                  "stamp": "12"
                 }
                }
               }
              }
             ]
            }
           },
           "ir0dclist": [
            {
             "ir0dcl": {
              "IR0Cvaldecl": {
               "token": {
                "tnode": {
                 "VAL": {
                  "valkind": "VLKval"
                 }
                }
               },
               "decmodopt": {
                "DECOMODnone": {}
               },
               "ir0valdeclist": [
                {
                 "ir0valdecl": {
                  "IR0VALDECL": {
                   "ir0pat": {
                    "IR0Pvar": {
                     "d2var": {
                      "symbol": "res",
                      "stamp": "12"
                     }
                    }
                   },
                   "ir0exp": {
                    "IR0Elam": {
                     "int": 0,
                     "ir0arglst": [
                      {
                       "ir0arg": {
                        "IR0ARGsome": {
                         "npf": "-1",
                         "ir0patlst": [
                          {
                           "ir0pat": {
                            "IR0Pvar": {
                             "d2var": {
                              "symbol": "k",
                              "stamp": "13"
                             }
                            }
                           }
                          }
                         ]
                        }
                       }
                      }
                     ],
                     "ir0exp": {
                      "IR0Edapp": {
                       "ir0exp": {
                        "IR0Etimp": {
                         "ir0exp": {
                          "IR0Etcst": {
                           "d2cst": {
                            "symbol": "map_list",
                            "stamp": "112"
                           },
                           "ti3arg": {
                            "TI3ARGnone": {
                             "t2ypelst": [
                              {
                               "t2ype": {
                                "T2Pxtv": {
                                 "t2ype": {
                                  "T2Pxtv": {
                                   "t2ype": {
                                    "T2Papp": {
                                     "t2ype": {
                                      "T2Pcst": {
                                       "s2cst": {
                                        "symbol": "gint_type",
                                        "stamp": "87"
                                       }
                                      }
                                     },
                                     "t2ypelst": [
                                      {
                                       "t2ype": {
                                        "T2Pcst": {
                                         "s2cst": {
                                          "symbol": "sint_k",
                                          "stamp": "72"
                                         }
                                        }
                                       }
                                      },
                                      {
                                       "t2ype": {
                                        "T2Pnone0": {}
                                       }
                                      }
                                     ]
                                    }
                                   }
                                  }
                                 }
                                }
                               }
                              },
                              {
                               "t2ype": {
                                "T2Pxtv": {
                                 "t2ype": {
                                  "T2Papp": {
                                   "t2ype": {
                                    "T2Pcst": {
                                     "s2cst": {
                                      "symbol": "bool_type",
                                      "stamp": "80"
                                     }
                                    }
                                   },
                                   "t2ypelst": [
                                    {
                                     "t2ype": {
                                      "T2Pnone0": {}
                                     }
                                    }
                                   ]
                                  }
                                 }
                                }
                               }
                              }
                             ]
                            }
                           },
                           "ti2arglst": []
                          }
                         },
                         "t2ypelst": [
                          {
                           "t2ype": {
                            "T2Papp": {
                             "t2ype": {
                              "T2Pcst": {
                               "s2cst": {
                                "symbol": "gint_type",
                                "stamp": "87"
                               }
                              }
                             },
                             "t2ypelst": [
                              {
                               "t2ype": {
                                "T2Pcst": {
                                 "s2cst": {
                                  "symbol": "sint_k",
                                  "stamp": "72"
                                 }
                                }
                               }
                              },
                              {
                               "t2ype": {
                                "T2Pnone0": {}
                               }
                              }
                             ]
                            }
                           }
                          },
                          {
                           "t2ype": {
                            "T2Papp": {
                             "t2ype": {
                              "T2Pcst": {
                               "s2cst": {
                                "symbol": "bool_type",
                                "stamp": "80"
                               }
                              }
                             },
                             "t2ypelst": [
                              {
                               "t2ype": {
                                "T2Pnone0": {}
                               }
                              }
                             ]
                            }
                           }
                          }
                         ],
                         "ir0dcl": {
                          "IR0Cfundecl": {
                           "token": {
                            "tnode": {
                             "FUN": {
                              "funkind": "FNKfn1"
                             }
                            }
                           },
                           "decmodopt": {
                            "DECOMODnone": {}
                           },
                           "tq2arglst": [
                            {
                             "tq2arg": {
                              "s2varlst": [
                               {
                                "s2var": {
                                 "symbol": "a",
                                 "stamp": "363"
                                }
                               }
                              ]
                             }
                            },
                            {
                             "tq2arg": {
                              "s2varlst": [
                               {
                                "s2var": {
                                 "symbol": "b",
                                 "stamp": "364"
                                }
                               }
                              ]
                             }
                            }
                           ],
                           "ir0fundeclist": [
                            {
                             "ir0fundecl": {
                              "IR0FUNDECL": {
                               "d2var": {
                                "symbol": "map_list",
                                "stamp": "0"
                               },
                               "d2cst": {
                                "symbol": "map_list",
                                "stamp": "112"
                               },
                               "f2arglst": [
                                {
                                 "f2arg": {
                                  "F2ARGsome_dyn": {
                                   "npf": "-1",
                                   "d2patlst": [
                                    {
                                     "d2pat": {
                                      "D2Panno": {
                                       "d2pat": {
                                        "D2Pvar": {
                                         "d2var": {
                                          "symbol": "xs",
                                          "stamp": "1"
                                         }
                                        }
                                       },
                                       "s2exp": {
                                        "S2Eapp": {
                                         "s2exp": {
                                          "S2Ecst": {
                                           "s2cst": {
                                            "symbol": "list",
                                            "stamp": "145"
                                           }
                                          }
                                         },
                                         "s2explst": [
                                          {
                                           "s2exp": {
                                            "S2Evar": {
                                             "s2var": {
                                              "symbol": "a",
                                              "stamp": "363"
                                             }
                                            }
                                           }
                                          }
                                         ]
                                        }
                                       }
                                      }
                                     }
                                    },
                                    {
                                     "d2pat": {
                                      "D2Panno": {
                                       "d2pat": {
                                        "D2Pvar": {
                                         "d2var": {
                                          "symbol": "f0",
                                          "stamp": "2"
                                         }
                                        }
                                       },
                                       "s2exp": {
                                        "S2Efun": {
                                         "funclo2": {
                                          "FC2fun": {}
                                         },
                                         "npf": {
                                          "int": -1
                                         },
                                         "s2explst": [
                                          {
                                           "s2exp": {
                                            "S2Evar": {
                                             "s2var": {
                                              "symbol": "a",
                                              "stamp": "363"
                                             }
                                            }
                                           }
                                          }
                                         ],
                                         "s2exp": {
                                          "S2Evar": {
                                           "s2var": {
                                            "symbol": "b",
                                            "stamp": "364"
                                           }
                                          }
                                         }
                                        }
                                       }
                                      }
                                     }
                                    }
                                   ]
                                  }
                                 }
                                }
                               ],
                               "ir0arglst": [
                                {
                                 "ir0arg": {
                                  "IR0ARGsome": {
                                   "npf": "-1",
                                   "ir0patlst": [
                                    {
                                     "ir0pat": {
                                      "IR0Pvar": {
                                       "d2var": {
                                        "symbol": "xs",
                                        "stamp": "1"
                                       }
                                      }
                                     }
                                    },
                                    {
                                     "ir0pat": {
                                      "IR0Pvar": {
                                       "d2var": {
                                        "symbol": "f0",
                                        "stamp": "2"
                                       }
                                      }
                                     }
                                    }
                                   ]
                                  }
                                 }
                                }
                               ],
                               "ir0exp": {
                                "IR0Ecase": {
                                 "int": 1,
                                 "ir0exp": {
                                  "IR0Evar": {
                                   "d2var": {
                                    "symbol": "xs",
                                    "stamp": "1"
                                   }
                                  }
                                 },
                                 "ir0claulst": [
                                  {
                                   "ir0clau": {
                                    "IR0CLAUpat": {
                                     "ir0gpat": {
                                      "IR0GPATpat": {
                                       "ir0pat": {
                                        "IR0Pcapp": {
                                         "d2con": {
                                          "symbol": "list_nil",
                                          "stamp": "6"
                                         },
                                         "ir0patlst": []
                                        }
                                       }
                                      }
                                     },
                                     "ir0exp": {
                                      "IR0Edapp": {
                                       "ir0exp": {
                                        "IR0Econ1": {
                                         "d2con": {
                                          "symbol": "list_nil",
                                          "stamp": "6"
                                         }
                                        }
                                       },
                                       "npf": "-1",
                                       "ir0explst": []
                                      }
                                     }
                                    }
                                   }
                                  },
                                  {
                                   "ir0clau": {
                                    "IR0CLAUpat": {
                                     "ir0gpat": {
                                      "IR0GPATpat": {
                                       "ir0pat": {
                                        "IR0Pcapp": {
                                         "d2con": {
                                          "symbol": "list_cons",
                                          "stamp": "7"
                                         },
                                         "ir0patlst": [
                                          {
                                           "ir0pat": {
                                            "IR0Pvar": {
                                             "d2var": {
                                              "symbol": "x0",
                                              "stamp": "3"
                                             }
                                            }
                                           }
                                          },
                                          {
                                           "ir0pat": {
                                            "IR0Pvar": {
                                             "d2var": {
                                              "symbol": "xs",
                                              "stamp": "4"
                                             }
                                            }
                                           }
                                          }
                                         ]
                                        }
                                       }
                                      }
                                     },
                                     "ir0exp": {
                                      "IR0Edapp": {
                                       "ir0exp": {
                                        "IR0Econ1": {
                                         "d2con": {
                                          "symbol": "list_cons",
                                          "stamp": "7"
                                         }
                                        }
                                       },
                                       "npf": "-1",
                                       "ir0explst": [
                                        {
                                         "ir0exp": {
                                          "IR0Edapp": {
                                           "ir0exp": {
                                            "IR0Evar": {
                                             "d2var": {
                                              "symbol": "f0",
                                              "stamp": "2"
                                             }
                                            }
                                           },
                                           "npf": "-1",
                                           "ir0explst": [
                                            {
                                             "ir0exp": {
                                              "IR0Evar": {
                                               "d2var": {
                                                "symbol": "x0",
                                                "stamp": "3"
                                               }
                                              }
                                             }
                                            }
                                           ]
                                          }
                                         }
                                        },
                                        {
                                         "ir0exp": {
                                          "IR0Edapp": {
                                           "ir0exp": {
                                            "IR0Evar": {
                                             "d2var": {
                                              "symbol": "map_list",
                                              "stamp": "0"
                                             }
                                            }
                                           },
                                           "npf": "-1",
                                           "ir0explst": [
                                            {
                                             "ir0exp": {
                                              "IR0Evar": {
                                               "d2var": {
                                                "symbol": "xs",
                                                "stamp": "4"
                                               }
                                              }
                                             }
                                            },
                                            {
                                             "ir0exp": {
                                              "IR0Evar": {
                                               "d2var": {
                                                "symbol": "f0",
                                                "stamp": "2"
                                               }
                                              }
                                             }
                                            }
                                           ]
                                          }
                                         }
                                        }
                                       ]
                                      }
                                     }
                                    }
                                   }
                                  }
                                 ]
                                }
                               }
                              }
                             }
                            }
                           ]
                          }
                         }
                        }
                       },
                       "npf": "-1",
                       "ir0explst": [
                        {
                         "ir0exp": {
                          "IR0Evar": {
                           "d2var": {
                            "symbol": "k",
                            "stamp": "13"
                           }
                          }
                         }
                        },
                        {
                         "ir0exp": {
                          "IR0Elam": {
                           "int": 0,
                           "ir0arglst": [
                            {
                             "ir0arg": {
                              "IR0ARGsome": {
                               "npf": "-1",
                               "ir0patlst": [
                                {
                                 "ir0pat": {
                                  "IR0Pvar": {
                                   "d2var": {
                                    "symbol": "x",
                                    "stamp": "14"
                                   }
                                  }
                                 }
                                }
                               ]
                              }
                             }
                            }
                           ],
                           "ir0exp": {
                            "IR0Eif0": {
                             "ir0exp": {
                              "IR0Ebtf": {
                               "token": {
                                "tnode": {
                                 "IDENT_alp": "true"
                                }
                               }
                              }
                             },
                             "ir0expopt": {
                              "ir0exp": {
                               "IR0Ebtf": {
                                "token": {
                                 "tnode": {
                                  "IDENT_alp": "false"
                                 }
                                }
                               }
                              }
                             }
                            }
                           }
                          }
                         }
                        }
                       ]
                      }
                     }
                    }
                   }
                  }
                 }
                }
               ]
              }
             }
            }
           ]
          }
         }
        }
       }
      }
     ]
    }
   }
  }
 ]
}
```
