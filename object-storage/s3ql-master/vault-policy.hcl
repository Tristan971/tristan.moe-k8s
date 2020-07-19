# Read-only permit
path "kv/data/scaleway/credentials" {
  capabilities = [
    "read",
    "list"
  ]
}
