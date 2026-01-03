; extends

; GitHub Actions
([
  (string_scalar)
  (block_scalar)
  (double_quote_scalar)
  (single_quote_scalar)
] @injection.content
  (#lua-match? @injection.content "[$]{{.*}}")
  (#set! injection.language "ghactions"))

; Sourcehut build manifests
((block_mapping_pair
    key: (flow_node
      (plain_scalar (string_scalar) @key))
    value: (block_node
      (block_sequence
        (block_sequence_item
          (block_node
            (block_mapping
              (block_mapping_pair
                value: (block_node
                  (block_scalar) @injection.content)))))))
  (#eq? @key "tasks")
  (#filename-lua-match? ".build.ya?ml")
  (#set! injection.language "sh")
))
