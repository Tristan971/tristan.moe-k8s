# Read-only permit
path "kv/data/mangadex/*" {
  capabilities = [
    "read",
    "list"
  ]
}
