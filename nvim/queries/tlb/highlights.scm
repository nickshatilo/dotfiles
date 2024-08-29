; Definitions
(combinator_declaration) @definition.function

; Constructors
(constructor_name) @constructor

; Fields
(field_name) @property
(implicit_field_name) @property

; Types
(builtin_type) @type.builtin
(type_expression) @type
(implicit_field_type) @type

; Base Types
[
  "int"
  "uint"
  "bits"
  "int8"
  "uint15"
  "uint16"
  "uint32"
  "uint64"
  "int32"
  "int64"
  "int128"
  "int256"
  "int257"
  "bits256"
  "bits512"
  "Cell"
  "Bool"
  "BoolFalse"
  "BoolTrue"
  "Unit"
  "True"
  "Void"
  "Tuple"
  "Message"
  "MsgAddress"
] @type.builtin

; Operators
[
  "="
  "<="
  "<"
  ">="
  ">"
  "+"
  "*"
  "~"
] @operator

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "^"
  "?"
  ":"
  ";"
] @punctuation.delimiter

; Constants
(hex_tag) @constant.numeric
(binary_tag) @constant.numeric

; Comments
(comment) @comment

; Identifiers
(combinator_name) @function

; Variables
(paren_expression) @variable
