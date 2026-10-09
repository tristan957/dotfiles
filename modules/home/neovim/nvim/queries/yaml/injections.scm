; extends

; GitHub Actions
([
  (string_scalar)
  (block_scalar)
  (double_quote_scalar)
  (single_quote_scalar)
] @injection.content
  (#filename-lua-match? "%.github/workflows/[^/]+%.ya?ml$")
  (#lua-match? @injection.content "[$]{{.*}}")
  (#set! injection.language "ghactions"))

; Sourcehut build manifests (.build.yaml)
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
  (#filename-lua-match? "%.build%.ya?ml$")
  (#eq? @key "tasks")
  (#set! injection.language "sh")
))

; Sourcehut build manifests (.builds/*.yaml)
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
  (#filename-lua-match? "%.builds/[^/]+%.ya?ml$")
  (#eq? @key "tasks")
  (#set! injection.language "sh")
))
