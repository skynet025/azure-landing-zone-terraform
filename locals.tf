# -------------------------------------------------------------------
# Naming convention
# -------------------------------------------------------------------
# On garde des noms Azure lisibles et standardisés.
# Pour Windows, on définit aussi un nom d'hôte court car
# l'OS limite "computer_name" à 15 caractères maximum.
# -------------------------------------------------------------------

locals {
  naming = {
    rg   = "rg-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    vm   = "vm-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    vnet = "vnet-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    nsg  = "nsg-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    nic  = "nic-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    # KV sans tirets
    kv = "kv${var.org}${var.workload}${var.env}${var.region_code}${var.instance}"

    # Hostname Windows (limite OS : 15 caractères)
    vm_computer_name = upper("vm${var.org}${var.env}${var.region_code}${var.instance}")
    # -------------------------------------------------------------------
    # Peering naming
    # -------------------------------------------------------------------
    # Convention explicite source -> destination
    # -------------------------------------------------------------------

    peer_spoke_to_hub = "peer-${var.org}-${var.workload}-${var.env}-${var.region_code}-spoke-to-hub"
    peer_hub_to_spoke = "peer-${var.org}-${var.workload}-${var.env}-${var.region_code}-hub-to-spoke"

    # Storage Account : sans tirets, contraintes Azure strictes
    st = "st${var.org}${var.workload}${var.env}${var.region_code}${var.instance}"

    # Private Endpoint
    pe_blob = "pe-${var.org}-${var.workload}-blob-${var.env}-${var.region_code}-${var.instance}"

    # DNS VNet Link
    dnslink_blob = "dnslink-${var.org}-${var.workload}-${var.env}-${var.region_code}-${var.instance}-blob"

    # Route table du spoke
rt_spoke = "rt-${var.org}-${var.workload}-${var.env}-${var.region_code}-${var.instance}-spoke"

    # Nom de route par défaut vers un futur transit hub
    route_default_to_hub = "route-default-to-hub"

    # Nouveau subnet de test pour la route table
    snet_test = "snet-test"
    # NIC de test pour lecture des effective routes
    nic_test = "nic-${var.org}-${var.workload}-test-${var.env}-${var.region_code}-${var.instance}"
    vm_test_computer_name = "VMJGFTST01"
  }

  common_tags = {
    env                 = var.env
    owner               = var.owner
    costcenter          = var.costcenter
    data_classification = var.data_classification
  }
}