;; Highlight @namespace, @owner, @iceberg-table as annotations
((identifier) @attribute
  (#match? @attribute "^@"))

;; Highlight protocol as a keyword
((identifier) @keyword
  (#eq? @keyword "protocol"))
