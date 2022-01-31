## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster_node_pool.base](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_id"></a> [aks\_id](#input\_aks\_id) | The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region | `string` | `null` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | The maximum number of pod which should exist within this Node Pool. Valid values are between 30 and 250 | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min\_count - max\_count | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map` | `{}` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

No outputs.
