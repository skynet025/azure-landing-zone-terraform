# -------------------------------------------------------------------
# Non-production environment variables
# -------------------------------------------------------------------
# Ce fichier contient uniquement les variables non sensibles
# propres à l'environnement non-prod du lab.
# Les identifiants Azure de plateforme (subscription / tenant)
# sont injectés par le pipeline CI/CD.
# -------------------------------------------------------------------

org         = "jgfs"
workload    = "tfdemo"
scope       = "core"
env         = "np"
region_code = "frc"
instance    = "01"
location    = "francecentral"

owner               = "platform"
costcenter          = "it"
data_classification = "internal"

# IP publique autorisée pour la règle RDP
admin_public_ip = "83.202.237.196/32"

# Compte administrateur des VM Windows
vm_admin_username = "azureadmin"