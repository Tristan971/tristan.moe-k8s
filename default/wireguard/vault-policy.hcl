# Read-only permit
path "kv/data/vpn/*" {
  capabilities = [
    "read",
    "list"
  ]
}
