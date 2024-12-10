(
  (comment) @injection.content
  (#match? @injection.content "\\{-TLB(.*)-\\}")
  (#offset! @injection.content 0 5 0 -2)
  (#set! injection.language "tlb")
)
