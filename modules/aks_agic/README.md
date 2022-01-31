## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.55.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 2.55.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ../../resources/container/aks |  |
| <a name="module_appgw"></a> [appgw](#module\_appgw) | ../../resources/network/application_gateway |  |
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | ../../resources/container/acr |  |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ../../resources/secrets/keyvault |  |
| <a name="module_node_pools"></a> [node\_pools](#module\_node\_pools) | ../../resources/container/cluster_node_pool |  |
| <a name="module_pip"></a> [pip](#module\_pip) | ../../resources/network/public_ip |  |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../resources/base/resource_group |  |
| <a name="module_role_acrpull"></a> [role\_acrpull](#module\_role\_acrpull) | ../../resources/authorization/role_assignment |  |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.shared-services](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_storage_class.storage_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [null_resource.acr_managed_identity](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.aksagic_addon](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_group.aks_cluster_admins](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.waf_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium | `string` | `"Standard"` | no |
| <a name="input_aks_admin_group"></a> [aks\_admin\_group](#input\_aks\_admin\_group) | Azure Active Directory groups that will have admin access within the cluster. | `string` | `"az-aks-cluster-admins"` | no |
| <a name="input_aks_dns_service_ip"></a> [aks\_dns\_service\_ip](#input\_aks\_dns\_service\_ip) | An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range. | `string` | `"10.75.0.10"` | no |
| <a name="input_aks_docker_bridge_cidr"></a> [aks\_docker\_bridge\_cidr](#input\_aks\_docker\_bridge\_cidr) | An IP address and netmask assigned to Docker Bridge. It must not be in any Subnet IP ranges, or the Kubernetes service address range | `string` | `"172.17.0.1/16"` | no |
| <a name="input_aks_service_cidr"></a> [aks\_service\_cidr](#input\_aks\_service\_cidr) | A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges | `string` | `"10.75.0.0/16"` | no |
| <a name="input_aks_subnet_name"></a> [aks\_subnet\_name](#input\_aks\_subnet\_name) | the subnet name that used by aks | `string` | n/a | yes |
| <a name="input_container_registry_name"></a> [container\_registry\_name](#input\_container\_registry\_name) | name of container registry that already exists | `string` | `""` | no |
| <a name="input_container_registry_rg"></a> [container\_registry\_rg](#input\_container\_registry\_rg) | resource group name of container registry that already exists | `string` | `""` | no |
| <a name="input_create_registry"></a> [create\_registry](#input\_create\_registry) | flag to either create acr or not | `string` | `"true"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Development environment for resource; prod, non-prod, shared-services | `string` | n/a | yes |
| <a name="input_georeplication_locations"></a> [georeplication\_locations](#input\_georeplication\_locations) | Georeplication regions for Azure Container registry | `list` | <pre>[<br>  "uaecentral"<br>]</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region | `string` | `null` | no |
| <a name="input_partner_id"></a> [partner\_id](#input\_partner\_id) | the partner id to track ACR | `any` | n/a | yes |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Standard"` | no |
| <a name="input_region"></a> [region](#input\_region) | Geographic region resource will be deployed into | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Any tags that should be present only in resources | `map(string)` | `{}` | no |
| <a name="input_rg_tags"></a> [rg\_tags](#input\_rg\_tags) | Any tags that should be present on the common with resource group resources | `map(string)` | `{}` | no |
| <a name="input_system_agents_count"></a> [system\_agents\_count](#input\_system\_agents\_count) | The number of Agents that should exist in the System Agent Pool. | `number` | `3` | no |
| <a name="input_system_agents_max_pods"></a> [system\_agents\_max\_pods](#input\_system\_agents\_max\_pods) | The maximum number of pod which should exist within system Node Pool. Valid values are between 30 and 250. | `number` | `30` | no |
| <a name="input_system_agents_size"></a> [system\_agents\_size](#input\_system\_agents\_size) | The default virtual machine size for the Kubernetes system pool agents | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_user_agents_count"></a> [user\_agents\_count](#input\_user\_agents\_count) | The number of Agents that should exist in the User Agent Pool. | `number` | `3` | no |
| <a name="input_user_agents_max_pods"></a> [user\_agents\_max\_pods](#input\_user\_agents\_max\_pods) | The maximum number of pod which should exist within user Node Pool. Valid values are between 30 and 250. | `number` | `75` | no |
| <a name="input_user_agents_size"></a> [user\_agents\_size](#input\_user\_agents\_size) | The default virtual machine size for the Kubernetes user pool agents | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | the resource group name of vnet | `string` | `""` | no |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | the resource group name of vnet | `string` | n/a | yes |
| <a name="input_waf_subnet_name"></a> [waf\_subnet\_name](#input\_waf\_subnet\_name) | the subnet name that used by waf | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The name of workload like ATLP | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Name of this Resource Group. |
