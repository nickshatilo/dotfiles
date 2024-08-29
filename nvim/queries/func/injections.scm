; ((comment) @injection.content
;   (#set! injection.language "comment"))
;
(
  (comment) @injection.content
  (#match? @injection.content "\\{-TLB(.*)-\\}")
  (#offset! @injection.content 0 5 0 -2)
  (#set! injection.language "tlb")
)

; (comment) @injection.content
; (comment) @tlb
;
; (comment
;   (combinator_declaration
;     (_) @injection.function.constructor
;     combinator: (combinator
;       (combinator_name) @injection.function.combinator)))

; (comment
;   (combinator_declaration
;     (field_definition
;       (field_name) @injection.property)))

; (comment
;   (combinator_declaration
;     (field_definition
;       implicit_field: (implicit_field
;         (implicit_field_name) @injection.property))))

; (comment
;   (combinator_declaration
;     (field_definition
;       expr95: (type_expression
;         (builtin_type) @injection.type.builtin))))
;
; (comment
;   (combinator_declaration
;     (field_definition
;       expr95: (type_expression) @injection.type)))

; (comment
;   (combinator_declaration
;     (field_definition
;       expr95: (type_expression
;         cell_ref: (cell_ref) @injection.type))))

; (comment
;   (combinator_declaration
;     (field_definition
;       implicit_field_type: (implicit_field
;         (implicit_field_type) @injection.type))))
;
; (comment
;   (combinator_declaration
;     (field_definition
;       expr95: (paren_expression) @injection.variable)))
