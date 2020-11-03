//
//  Constants.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 30/09/20.
//

import Foundation

let kBlankString = ""
let kNoHTML = "non html string"
let kSimpleHTML = "<h1>Hello</h1> World"

let kUnexpectedClose = """
<figur2 class="embedded-asset" type="asset" data-sys-entry-uid="uid" data-sys-content-type-uid="data-sys-content-type-uid" style="display:inline;" sys-style-type="inline">
</figure>
"""
let kNoChildNode = """
<figure class="embedded-asset" type="asset" data-sys-entry-uid="uid" data-sys-content-type-uid="data-sys-content-type-uid" style="display:inline;" sys-style-type="inline">
</figure>
"""

let kAssetDisplay = """
<figure class="embedded-asset" type="asset" data-sys-asset-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="display">
<img src="{{url}}" data-sys-asset-uid="{{uid}}" alt="{{object.title}}"></figure>
"""
let kEntryBlock = """
<figure class="embedded-entry block-entry" type="entry" data-sys-entry-uid="blt55f6d8cbd7e03a1f" data-sys-content-type-uid="article" sys-style-type="block">
<span>{{title}}</span>
</figure>
"""
let kEntryInline = """
<figure class="embedded-entry inline-entry" type="entry" data-sys-entry-uid="blt55f6d8cbd7e03a1f" data-sys-content-type-uid="article" style="display:inline;" sys-style-type="inline">
<data data-sys-field-uid="title">{{title}}</data>
</figure>
"""

let kEntryLink = """
<figure class="embedded-entry link-entry" type="entry" data-sys-entry-uid="blt55f6d8cbd7e03a1f" data-sys-content-type-uid="article" style="display:inline;" sys-style-type="link">
<a data-sys-field-uid="title" href="{{url}}">{{title}}</a>
</figure>
"""

let kAssetEmbed = """
<figure class="embedded-asset" data-sys-asset-filelink="https://images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt8d49bb742bcf2c83/5f744bfcb3d3d20813386c10/clitud.jpeg" data-sys-asset-uid="blt8d49bb742bcf2c83" data-sys-asset-filename="Cuvier-67_Autruche_d_Afrique.jpg" data-sys-asset-contenttype="image/jpeg" data-sys-asset-alt="Cuvier-67_Autruche_d_Afrique.jpg" data-sys-asset-caption="somecaption" data-sys-asset-link="http://abc.com" data-sys-asset-position="center" data-sys-asset-isnewtab="true" type="asset" sys-style-type="display"></figure>
<p></p>
<p></p>
<figure class="embedded-asset" data-redactor-type="embed" data-widget-code="" data-sys-asset-filelink="https://images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt120a5a04d91c9466/5ebb86965a68ad069038b729/iphone-mockup.png" data-sys-asset-uid="blt120a5a04d91c9466" data-sys-asset-filename="iphone-mockup.png" data-sys-asset-contenttype="image/png" type="asset" sys-style-type="display"></figure>
"""

let kEntryEmbed = """
<div class="redactor-component embedded-entry block-entry redactor-component-active" data-redactor-type="embed" data-widget-code="" data-sys-entry-uid="blt41a3bf40728446c3" data-sys-entry-locale="en-us" data-sys-content-type-uid="00_suraj" sys-style-type="block" type="entry" data-sys-can-edit="true"></div>
<p>bkcsdcsdc</p>
<div class="redactor-component embedded-entry block-entry" data-redactor-type="embed" data-widget-code="" data-sys-entry-uid="bltc8814d18a565bed1" data-sys-entry-locale="en-us" data-sys-content-type-uid="manish" sys-style-type="block" type="entry" data-sys-can-edit="true"></div>
<p></p>
<div class="redactor-component embedded-entry block-entry" data-redactor-type="embed" data-widget-code="" data-sys-entry-uid="blt2445231ec8f62c9b" data-sys-entry-locale="en-us" data-sys-content-type-uid="manish" sys-style-type="block" type="entry" data-sys-can-edit="true"></div>
"""

let kAllEmbeddEntry = """
<p><br>Sample&nbsp;<a data-sys-entry-uid="blt41a3bf40728446c3" data-sys-entry-locale="en-us" data-sys-content-type-uid="00_suraj" sys-style-type="link" data-sys-can-edit="true" class="embedded-entry" type="entry" href="/suraj-123-entry" title="Manish New entry">LinkText</a> inside RTE&nbsp;<span class="redactor-component embedded-entry inline-entry" data-redactor-type="embed" data-widget-code="" data-sys-entry-uid="blt41a3bf40728446c3" data-sys-entry-locale="en-us" data-sys-content-type-uid="00_suraj" data-sys-can-edit="true" sys-style-type="inline" type="entry"></span></p><div class="redactor-component embedded-entry block-entry" data-redactor-type="embed" data-widget-code="" data-sys-entry-uid="blt2445231ec8f62c9b" data-sys-entry-locale="en-us" data-sys-content-type-uid="manish" data-sys-can-edit="true" sys-style-type="block" type="entry"></div>
"""


let kUnexpectedResult = """
<span class="embedded-asset" data-sys-content-type-uid="data-sys-content-type-uid" data-sys-entry-uid="uid" style="display:inline;" sys-style-type="inline" type="asset"><b>title</b> 
</span>
"""

let kAssetDisplayCustomResult = """
<b>title</b><p>filename image: <img class="embedded-asset" data-sys-asset-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="display" type="asset" /></p>
"""

let kEntryBlockCustomResult = """
<div class="embedded-entry block-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" sys-style-type="block" type="entry"> <b>blt55f6d8cbd7e03a1f</b></div>
"""

let kEntryInlineCustomeResult = """
<span class="embedded-entry inline-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="inline" type="entry"><b>blt55f6d8cbd7e03a1f</b></span>
"""

let kEntryLinkCustomResult = """
<span> Please find link to: <a class="embedded-entry link-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="link" type="entry"><b>
{{title}}
</b></a>
"""

let kAssetdisplayCustomResult = """
<b>title</b><p>filename image: <img class="embedded-asset" data-sys-asset-alt="Cuvier-67_Autruche_d_Afrique.jpg" data-sys-asset-caption="somecaption" data-sys-asset-contenttype="image/jpeg" data-sys-asset-filelink="https://images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt8d49bb742bcf2c83/5f744bfcb3d3d20813386c10/clitud.jpeg" data-sys-asset-filename="Cuvier-67_Autruche_d_Afrique.jpg" data-sys-asset-isnewtab="true" data-sys-asset-link="http://abc.com" data-sys-asset-position="center" data-sys-asset-uid="blt8d49bb742bcf2c83" sys-style-type="display" type="asset" /></p>
<p></p>
<p></p>
<b>title</b><p>filename image: <img class="embedded-asset" data-redactor-type="embed" data-sys-asset-contenttype="image/png" data-sys-asset-filelink="https://images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt120a5a04d91c9466/5ebb86965a68ad069038b729/iphone-mockup.png" data-sys-asset-filename="iphone-mockup.png" data-sys-asset-uid="blt120a5a04d91c9466" data-widget-code="" sys-style-type="display" type="asset" /></p>
"""

let kEntryBlockLinkCustomResult = """
<div class="embedded-entry block-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" sys-style-type="block" type="entry"> <b>blt55f6d8cbd7e03a1f</b></div><span> Please find link to: <a class="embedded-entry link-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="link" type="entry"><b>
{{title}}
</b></a>
"""

let kEntryBlockLinkInlineCustomResult = """
<div class="embedded-entry block-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" sys-style-type="block" type="entry"> <b>blt55f6d8cbd7e03a1f</b></div><span> Please find link to: <a class="embedded-entry link-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="link" type="entry"><b>
{{title}}
</b></a> <span class="embedded-entry inline-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="inline" type="entry"><b>blt55f6d8cbd7e03a1f</b></span>
"""

let kAllEmbedCustomeResult = """

<div class="embedded-entry block-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" sys-style-type="block" type="entry"> <b>blt55f6d8cbd7e03a1f</b></div>
<span> Please find link to: <a class="embedded-entry link-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="link" type="entry"><b>
{{title}}
</b></a>
<span class="embedded-entry inline-entry" data-sys-content-type-uid="article" data-sys-entry-uid="blt55f6d8cbd7e03a1f" style="display:inline;" sys-style-type="inline" type="entry"><b>blt55f6d8cbd7e03a1f</b></span>
"""

let kContentblockRTEResult = """
<div class="embedded-entry block-entry" data-sys-content-type-uid="content_block" data-sys-entry-locale="en-us" data-sys-entry-uid="blttitleuid" sys-style-type="block" type="entry"> <b>Update this title</b>
<figure class="embedded-entry inline-entry" data-sys-entry-uid="blttitleuid" data-sys-entry-locale="en-us" data-sys-content-type-uid="content_block" sys-style-type="inline" type="entry"></figure>
</div>
<span class="embedded-entry inline-entry" data-sys-content-type-uid="embeddedrte" data-sys-entry-locale="en-us" data-sys-entry-uid="bltemmbedEntryUID" sys-style-type="inline" type="entry"><b>Entry with embedded entry</b> </span>
<p></p>
"""

let kContentblockRichTextResult = """
<div class="embedded-entry block-entry" data-sys-content-type-uid="embeddedrte" data-sys-entry-locale="en-us" data-sys-entry-uid="blttitleUpdateUID" sys-style-type="block" type="entry"> <b>updated title</b>
<figure class="embedded-asset" data-sys-asset-filelink="https://contentstack.image/v3/assets/blturl/bltassetUID/5f4dee15f4b7a40acfb622dc/DIABETICDIET-800x600.jpg" data-sys-asset-uid="bltassetUID" data-sys-asset-filename="DIABETICDIET-800x600.jpg" data-sys-asset-contenttype="image/jpeg" type="asset" sys-style-type="display"></figure>
</div>
<p></p>
<b>svg-logo-text.png</b><p>svg-logo-text.png image: <img class="embedded-asset" data-sys-asset-contenttype="image/png" data-sys-asset-filelink="https://contentstack.image/v3/assets/blturl/bltassetEmbuid/5f57ae45c83b840a87d92910/html5.png" data-sys-asset-filename="svg-logo-text.png" data-sys-asset-uid="bltassetEmbuid" sys-style-type="display" type="asset" /></p>
"""
