# -------------------------------------------------------------------
# Deployment context
# -------------------------------------------------------------------
# Ce bloc centralise les informations d'environnement utilisées
# dans le root module afin d'éviter la duplication et d'améliorer
# la lisibilité globale du code.
# -------------------------------------------------------------------
locals {
  context = {
    org         = var.org
    workload    = var.workload
    scope       = var.scope
    env         = var.env
    region_code = var.region_code
    instance    = var.instance
    location    = var.location
  }

  # -----------------------------------------------------------------
  # Common tags
  # -----------------------------------------------------------------
  # Tags standards appliqués aux ressources du lab.
  # Ils servent à la gouvernance, au suivi des coûts et à la
  # classification des ressources.
  # -----------------------------------------------------------------
  common_tags = {
    env                 = var.env
    owner               = var.owner
    costcenter          = var.costcenter
    data_classification = var.data_classification
  }

  # -----------------------------------------------------------------
  # Naming convention
  # -----------------------------------------------------------------
  # Tous les noms Azure sont centralisés ici pour garantir :
  # - cohérence
  # - lisibilité
  # - réutilisabilité
  # - alignement avec les bonnes pratiques entreprise
  # -----------------------------------------------------------------
  naming = {
    # ---------------------------------------------------------------
    # Core resources
    # ---------------------------------------------------------------
    rg   = "rg-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    vnet = "vnet-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    nsg  = "nsg-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    nic  = "nic-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"
    vm   = "vm-${var.org}-${var.workload}-${var.scope}-${var.env}-${var.region_code}-${var.instance}"

    # ---------------------------------------------------------------
    # Azure resources with specific naming constraints
    # ---------------------------------------------------------------
    # Le Key Vault et le Storage Account doivent respecter des
    # contraintes Azure strictes (pas de tirets / longueur limitée).
    # ---------------------------------------------------------------
    kv = "kv${var.org}${var.workload}${var.env}${var.region_code}${var.instance}"
    st = "st${var.org}${var.workload}${var.env}${var.region_code}${var.instance}"

    # ---------------------------------------------------------------
    # Windows hostnames
    # ---------------------------------------------------------------
    # Les hostnames Windows sont limités à 15 caractères maximum.
    # On applique une convention courte compatible avec l'OS.
    # ---------------------------------------------------------------
    vm_computer_name      = upper("vm${var.org}${var.env}${var.region_code}${var.instance}")
    vm_test_computer_name = upper("vm${var.org}tst${var.instance}")

    # ---------------------------------------------------------------
    # Peering
    # ---------------------------------------------------------------
    # Convention explicite source -> destination pour simplifier
    # la lecture de l'architecture réseau.
    # ---------------------------------------------------------------
    peer_spoke_to_hub = "peer-${var.org}-${var.workload}-${var.env}-${var.region_code}-spoke-to-hub"
    peer_hub_to_spoke = "peer-${var.org}-${var.workload}-${var.env}-${var.region_code}-hub-to-spoke"

    # ---------------------------------------------------------------
    # Private connectivity
    # ---------------------------------------------------------------
    pe_blob      = "pe-${var.org}-${var.workload}-blob-${var.env}-${var.region_code}-${var.instance}"
    dnslink_blob = "dnslink-${var.org}-${var.workload}-${var.env}-${var.region_code}-${var.instance}-blob"

    # ---------------------------------------------------------------
    # Routing
    # ---------------------------------------------------------------
    rt_spoke             = "rt-${var.org}-${var.workload}-${var.env}-${var.region_code}-${var.instance}-spoke"
    route_default_to_hub = "route-default-to-hub"

    # ---------------------------------------------------------------
    # Test resources
    # ---------------------------------------------------------------
    # Ressources utilisées pour valider le routage, les routes
    # effectives et le comportement réseau sans impacter le subnet app.
    # ---------------------------------------------------------------
    snet_test   = "snet-test"
    nic_test    = "nic-${var.org}-${var.workload}-test-${var.env}-${var.region_code}-${var.instance}"
    vm_test     = "vm-${var.org}-${var.workload}-test-${var.env}-${var.region_code}-${var.instance}"
    osdisk_test = "osdisk-test"
  }
}