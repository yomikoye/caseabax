output "webapp_ids" {
  value = { for k, v in azurerm_linux_web_app.main : k => v.id }
}

output "webapp_names" {
  value = { for k, v in azurerm_linux_web_app.main : k => v.name }
}

output "webapp_default_hostnames" {
  value = { for k, v in azurerm_linux_web_app.main : k => v.default_hostname }
}

output "webapp_identities" {
  value = { for k, v in azurerm_linux_web_app.main : k => v.identity[0].principal_id }
}