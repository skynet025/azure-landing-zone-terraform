# -------------------------------------------------------------------
# Outputs du module compute
# -------------------------------------------------------------------

output "vm_id" {
  value = azurerm_windows_virtual_machine.this.id
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.this.name
}

output "nic_id" {
  value = azurerm_network_interface.this.id
}