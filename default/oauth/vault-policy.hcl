# Read-only permit
path "kv/data/oauth/*" {
  capabilities = [
    "read",
    "list"
  ]
}
