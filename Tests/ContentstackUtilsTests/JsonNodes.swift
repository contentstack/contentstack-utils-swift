//
//  JsonNodes.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 07/06/21.
//

import Foundation
let kBlankDocument = """
{
  "uid": "06e34a7a4e5d7fc2acd",
  "_version": 13,
  "attrs": {},
  "children": [],
  "type": "doc"
}
"""

let kPlainTextJson = """
{
  "uid": "06e34a7a4e5d7fc2acd",
  "_version": 13,
  "attrs": {},
  "children":
  [
    {
      "text": "Aliquam sit amet libero dapibus, eleifend ligula at, varius justo",
      "bold": true
    },
    {
        "text": "Lorem ipsum",
        "bold": true,
        "italic": true
    },
    {
        "text": "dolor sit amet",
        "bold": true,
        "italic": true,
        "underline": true
    },
    {
        "text": "consectetur adipiscing elit.",
        "bold": true,
        "italic": true,
        "underline": true,
        "strikethrough": true
    },
    {
        "text": "Sed condimentum iaculis magna in vehicula. ",
        "bold": true,
        "italic": true,
        "underline": true,
        "inlineCode": true
    },
    {
        "text": "  Vestibulum vitae convallis ",
        "bold": true,
        "italic": true,
        "underline": true,
        "superscript": true
    },
    {
        "text": " lacus. ",
        "bold": true,
        "italic": true,
        "underline": true,
        "subscript": true
    }
  ],
  "type": "doc"
}
"""

let kH1Json = """
{
  "uid": "06e34a7a449d7fc2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "type": "h1",
      "attrs": {},
      "uid": "c2dfed704d7030c65e2e1",
      "children": [
          {
              "text": "Lorem ipsum dolor sit amet.",
              "bold": true,
              "italic": true,
              "underline": true,
              "subscript": true
          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kH2Json = """
{
  "uid": "06e34a7a4e2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "type": "h2",
      "attrs": {},
      "uid": "c2dfed9a7030c65e2e1",
      "children": [
          {
              "text": "Vestibulum a ligula eget massa sagittis aliquam sit amet quis tortor. ",
              "bold": true,
              "italic": true,
              "underline": true,
              "subscript": true
          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kH3Json = """
{
  "uid": "06e34ad7fc2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "type": "h3",
      "attrs": {},
      "uid": "c2df42cfb704d7030c65e2e1",
      "children": [
          {
              "text": "Mauris venenatis dui id massa sollicitudin, non bibendum nunc dictum.",
              "bold": true,
              "italic": true,
              "underline": true,
              "subscript": true
          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kH4Json = """
{
  "uid": "06e34a7a4e54cd",
  "_version": 13,
  "attrs": {
    "style": {
        "text-align": "center"
    },
    "redactor-attributes": {}
  },
  "children": [
    {
      "type": "h4",
      "attrs": {},
      "uid": "c2dfed4d7030c65e2e1",
      "children": [
          {
              "text": "MaNullam feugiat turpis quis elit interdum, vitae laoreet quam viverra",
              "bold": true,
              "italic": true,
              "underline": true,
              "subscript": true
          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kH5Json = """
{
  "uid": "06e381190849dacd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "type": "h5",
      "attrs": {},
      "uid": "c2d672242cfb7045e2e1",
      "children": [
          {
              "text": "Mauris venenatis dui id massa sollicitudin, non bibendum nunc dictum.",

          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kH6Json = """
{
  "uid": "06e34a71190849d7fcd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "type": "h6",
      "attrs": {},
      "uid": "c2dfa672242cfb7e2e1",
      "children": [
          {
              "text": "Nunc porta diam vitae purus semper, ut consequat lorem vehicula.",

          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kOrderListJson = """
{
  "uid": "06e35481190849d7fc2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "uid": "2b5b4acbb3cfce02d3e",
      "type": "ol",
      "children": [
          {
              "type": "li",
              "attrs": {
                  "style": {
                      "text-align": "justify"
                  },
                  "redactor-attributes": {}
              },
              "uid": "160bbd7430b98bd3d996",
              "children": [
                  {
                      "text": "Morbi in quam molestie, fermentum diam vitae, bibendum ipsum."
                  }
              ]
          },
          {
              "type": "li",
              "attrs": {
                  "style": {
                      "text-align": "justify"
                  },
                  "redactor-attributes": {}
              },
              "uid": "a15f4d749bc2903d",
              "children": [
                  {
                      "text": "Pellentesque mattis lacus in quam aliquam congue"
                  }
              ]
          },
          {
              "type": "li",
              "attrs": {
                  "style": {
                      "text-align": "justify"
                  },
                  "redactor-attributes": {}
              },
              "uid": "e54224bbcb6f9e8f1e43",
              "children": [
                  {
                      "text": "Integer feugiat leo dignissim, lobortis enim vitae, mollis lectus."
                  }
              ]
          },
          {
              "type": "li",
              "attrs": {
                  "style": {
                      "text-align": "justify"
                  },
                  "redactor-attributes": {}
              },
              "uid": "c0148bab9af758784",
              "children": [
                  {
                      "text": "Sed in ante lacinia, molestie metus eu, fringilla sapien."
                  }
              ]
          }
      ],
      "id": "7f413d448a",
      "attrs": {}
    }
  ],
  "type": "doc"
}
"""

let kUnorderListJson = """
{
  "uid": "0e5481190849a",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "uid": "a3a2b443ebffc867b",
      "type": "ul",
      "children": [
          {
              "uid": "f67354d4eed64451922",
              "type": "li",
              "children": [
                  {
                      "text": "Sed quis metus sed mi hendrerit mollis vel et odio."
                  }
              ],
              "attrs": {}
          },
          {
              "uid": "550cba5bea92f23e36fd1",
              "type": "li",
              "children": [
                  {
                      "text": "Integer vitae sem dignissim, elementum libero vel, fringilla massa."
                  }
              ],
              "attrs": {}
          },
          {
              "uid": "0e5c9b4cd983e8fd543",
              "type": "li",
              "children": [
                  {
                      "text": "Integer imperdiet arcu sit amet tortor faucibus aliquet."
                  }
              ],
              "attrs": {}
          },
          {
              "uid": "6d9a43a3816bd83a9a",
              "type": "li",
              "children": [
                  {
                      "text": "Aenean scelerisque velit vitae dui vehicula, at congue massa sagittis."
                  }
              ],
              "attrs": {}
          }
      ],
      "id": "b083fa46ef899420ab19",
      "attrs": {}
    }
  ],
  "type": "doc"
}
"""

let kImgJson = """
{
  "uid": "06e34a7a4849d7fc2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "uid": "f3be74be3b64646e626",
      "type": "img",
      "attrs": {
          "src": "https://images.contentstack.com/v3/assets/blt7726e6b/bltb42cd1/5fa3be959bedb6b/Donald.jog.png",
          "width": 33.69418132611637,
          "height": "auto",
          "redactor-attributes": {
              "asset_uid": "47f1aa5ae422cd1"
          }
      },
      "children": [
          {
              "text": ""
          }
      ]
    }
  ],
  "type": "doc"
}
"""

let kParagraphJson = """
{
    "uid": "0d7fd",
    "_version": 13,
    "attrs": {},
    "children": [
        {
            "type": "p",
            "attrs": {},
            "uid": "0a1b5676aa510e5a",
            "children": [
                {
                    "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum iaculis magna in vehicula. Vestibulum vitae convallis lacus. Praesent a diam iaculis turpis rhoncus faucibus. Aliquam sed pulvinar sem."
                }
            ]
        }
    ],
    "type": "doc"
}
"""

let kBlockquoteJson = """
{
  "uid": "06084d7fd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "uid": "503f9cc97534db55",
      "type": "blockquote",
      "id": "431f78e567161460",
      "children": [
        {
          "text": "Praesent eu ex sed nibh venenatis pretium."
        }
      ],
      "attrs": {}
    }
  ],
  "type": "doc"
}
"""

let kCodeJson = """
{
  "uid": "06ea490849d7fc2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
    "uid": "83fba92c91b30002b",
    "type": "code",
    "attrs": {},
    "children": [
        {
        "text": "Code template."
        }
    ]
    }
  ],
  "type": "doc"
}
"""

let kTableJson = """
{
  "uid": "06e481190849d7fcd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "uid": "6dd64343bf634bfadd4",
      "type": "table",
      "attrs": {
          "rows": 4,
          "cols": 2,
          "colWidths": [
              250,
              250
          ]
      },
      "children": [
          {
              "uid": "b9082",
              "type": "thead",
              "attrs": {},
              "children": [
                  {
                      "type": "tr",
                      "attrs": {},
                      "children": [
                          {
                              "type": "th",
                              "attrs": {},
                              "children": [
                                  {
                                      "type": "p",
                                      "attrs": {},
                                      "children": [
                                          {
                                              "text": "Header 1"
                                          }
                                      ],
                                      "uid": "daa3ef"
                                  }
                              ],
                              "uid": "4b3124414a3"
                          },
                          {
                              "type": "th",
                              "attrs": {},
                              "children": [
                                  {
                                      "type": "p",
                                      "attrs": {},
                                      "children": [
                                          {
                                              "text": "Header 2"
                                          }
                                      ],
                                      "uid": "eae83c5797d"
                                  }
                              ],
                              "uid": "bca9b6f037a04fb485"
                          }
                      ],
                      "uid": "b91ae7a48ef2e9da1"
                  }
              ]
          },
          {
              "type": "tbody",
              "attrs": {},
              "children": [
                  {
                      "type": "tr",
                      "attrs": {},
                      "children": [
                          {
                              "type": "td",
                              "attrs": {},
                              "children": [
                                  {
                                      "type": "p",
                                      "attrs": {},
                                      "children": [
                                          {
                                              "text": "Body row 1 data 1"
                                          }
                                      ],
                                      "uid": "ec674ccc5ce70b7cab"
                                  }
                              ],
                              "uid": "2a70bdeeb99a"
                          },
                          {
                              "type": "td",
                              "attrs": {},
                              "children": [
                                  {
                                      "type": "p",
                                      "attrs": {},
                                      "children": [
                                          {
                                              "text": "Body row 1 data 2"
                                          }
                                      ],
                                      "uid": "769a3f9db34ce8ec10486d50"
                                  }
                              ],
                              "uid": "d640734a5c61ab1e5f7d1"
                          }
                      ],
                      "uid": "77f6b951c687f9eb397c5"
                  },
                  {
                      "type": "tr",
                      "attrs": {},
                      "children": [
                          {
                              "type": "td",
                              "attrs": {},
                              "children": [
                                  {
                                      "type": "p",
                                      "attrs": {},
                                      "children": [
                                          {
                                              "text": "Body row 2 data 1"
                                          }
                                      ],
                                      "uid": "a6bf11bb48630e87d721c0"
                                  }
                              ],
                              "uid": "3da39838b0feaf"
                          },
                          {
                              "type": "td",
                              "attrs": {},
                              "children": [
                                  {
                                      "type": "p",
                                      "attrs": {},
                                      "children": [
                                          {
                                              "text": "Body row 2 data 2"
                                          }
                                      ],
                                      "uid": "3b7d121f69420249029e86313"
                                  }
                              ],
                              "uid": "95b38b04abcbc25e94f"
                          }
                      ],
                      "uid": "b227fea8d2470134f1e1e8"
                  }
              ],
              "uid": "fd5ab86aa642798451b"
          }
      ]
    },
  ],
  "type": "doc"
}
"""

let kLinkInPJson = """
{
  "uid": "06e34a7190849d7f2acd",
  "_version": 13,
  "attrs": {},
  "children": [
    {
      "type": "p",
      "attrs": {
          "style": {
          "text-align": "left"
          },
          "redactor-attributes": {}
      },
      "uid": "d88dcdf4590dff2d",
      "children": [
          {
          "text": "",
          "bold": true,
          "italic": true,
          "underline": true,
          "subscript": true
          },
          {
          "uid": "0d06598201aa8b47",
          "type": "a",
          "attrs": {
              "href": "LINK.com",
              "target": "_self"
          },
          "children": [
              {
              "text": "LINK"
              }
          ]
          },
          {
          "text": ""
          }
      ]
      }
  ],
  "type": "doc"
}
"""

let kEmbedJson = """
{
  "uid": "06e34a7190849d7f2acd",
  "_version": 13,
  "attrs": {},
  "children": [
        {
          "uid": "251017315905c35d42c9",
          "type": "embed",
          "attrs": {
            "src": "https://www.youtube.com/watch?v=AOP0yARiW8U"
          },
          "children": [
            {
              "text": ""
            }
          ]
        }
    ],
    "type": "doc"
}
"""

let kAssetReferenceJson = """
{
    "uid": "06e34a7  5e4 e549d7fc2acd",
    "_version": 1,
    "attrs": {},
    "children": [
        {
            "uid": "4f7e333390a955de10c1c836",
            "type": "reference",
            "attrs": {
                "display-type": "display",
                "asset-uid": "blt44asset",
                "content-type-uid": "sys_assets",
                "asset-link": "https://images.contentstack.com/v3/assets/blt77263d3e6b/blt73403ee7281/51807f919e0e4/11.jpg",
                "asset-name": "11.jpg",
                "asset-type": "image/jpeg",
                "type": "asset",
                "class-name": "embedded-asset",
                "width": 25.16914749661705,
                "className": "dsd",
                "id": "sdf"
            },
            "children": [
                {
                    "text": ""
                }
            ]
        }
    ],
    "type": "doc"
}
"""

let kEntryReferenceBlockJson = """
{
    "uid": "06e34a7  5e4 e549d7fc2acd",
    "_version": 1,
    "attrs": {},
    "children": [
    {
        "uid": "70f9b325075d43128c0d0aa3eb7f291f",
        "type": "reference",
        "attrs": {
          "display-type": "block",
          "entry-uid": "blttitleuid",
          "content-type-uid": "content_block",
          "locale": "en-us",
          "type": "entry",
          "class-name": "embedded-entry"
        },
        "children": [
          {
            "text": ""
          }
        ]
      }
    ],
    "type": "doc"
}
"""

let kEntryReferenceLinkJson = """
{
    "uid": "06e34a7  5e4 e549d7fc2acd",
    "_version": 1,
    "attrs": {},
    "children": [
        {
            "uid": "7626ea98e0e95d602210",
            "type": "reference",
            "attrs": {
            "target": "_self",
            "href": "/copy-of-entry-final-02",
            "display-type": "link",
            "entry-uid": "bltemmbedEntryuid",
            "content-type-uid": "embeddedrte",
            "locale": "en-us",
            "type": "entry",
            "class-name": "embedded-entry"
            },
            "children": [
            {
                "text": "/copy-of-entry-final-02"
            }
            ]
        }
    ],
    "type": "doc"
}
"""

let kEntryReferenceInlineJson = """
{
    "uid": "06e34a7  5e4 e549d7fc2acd",
    "_version": 1,
    "attrs": {},
    "children": [
        {
            "uid": "5064878f3f4621f0cbcaff",
            "type": "reference",
            "attrs": {
            "display-type": "inline",
            "entry-uid": "blttitleUpdateuid",
            "content-type-uid": "embeddedrte",
            "locale": "en-us",
            "type": "entry",
            "class-name": "embedded-entry"
            },
            "children": [
            {
                "text": ""
            }
            ]
        }
    ],
    "type": "doc"
}
"""

let kHRJson = """

{
    "uid": "06e34a7  5e4 e549d7fc2acd",
    "_version": 1,
    "attrs": {},
    "children": [
        {
          "uid": "f5a7b57 40a8a5c3 576828276b",
          "type": "hr",
          "children": [
            {
              "text": ""
            }
          ],
          "attrs": {}
        }
    ],
    "type": "doc"
}
"""
