# Read-only permit
path "kv/data/concourse/*" {
  capabilities = [
    "read",
    "list"
  ]
}
