" Vim syntax file
" Language: Apache Avro IDL (AVDL)
" Maintainer: Generated
" Last Change: 2024

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword avdlKeyword protocol record enum fixed union array map throws oneway import
syn keyword avdlType null boolean int long float double bytes string uuid

" Custom types (common patterns)
syn match avdlCustomType '\<\w*_ms\>'
syn match avdlCustomType '\<timestamp_\w\+\>'
syn match avdlCustomType '\<\u\w*\>' " PascalCase types

" Annotations (starting with @)
syn match avdlAnnotation "@\w\+\(-\w\+\)*"

" String literals
syn region avdlString start='"' end='"' contains=avdlEscape
syn match avdlEscape contained '\\[nrt"\\]'

" Numbers
syn match avdlNumber '\<\d\+\>'
syn match avdlFloat '\<\d\+\.\d\+\>'

" Comments
syn match avdlComment '//.*$'
syn region avdlBlockComment start='/\*' end='\*/'

" JSON-like structures in annotations
syn region avdlJsonObject start='{' end='}' contained contains=avdlJsonString,avdlJsonNumber,avdlJsonArray,avdlJsonObject
syn region avdlJsonArray start='\[' end='\]' contained contains=avdlJsonString,avdlJsonNumber,avdlJsonArray,avdlJsonObject
syn region avdlJsonString start='"' end='"' contained
syn match avdlJsonNumber '\<\d\+\>' contained
syn match avdlJsonNumber '\<\d\+\.\d\+\>' contained

" Field names and types
syn match avdlFieldName '\<[a-zA-Z_][a-zA-Z0-9_]*\s*;' contains=avdlFieldEnd
syn match avdlFieldEnd ';' contained

" Highlight groups
hi def link avdlKeyword Keyword
hi def link avdlType Type
hi def link avdlCustomType Type
hi def link avdlAnnotation PreProc
hi def link avdlString String
hi def link avdlEscape SpecialChar
hi def link avdlNumber Number
hi def link avdlFloat Float
hi def link avdlComment Comment
hi def link avdlBlockComment Comment
hi def link avdlJsonObject Delimiter
hi def link avdlJsonArray Delimiter
hi def link avdlJsonString String
hi def link avdlJsonNumber Number
hi def link avdlFieldName Identifier

let b:current_syntax = "avdl"