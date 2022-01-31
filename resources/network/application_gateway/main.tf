#since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${var.workload}-be"
  frontend_port_name             = "${var.workload}-feport"
  frontend_ip_configuration_name = "${var.workload}-feip"
  http_setting_name              = "${var.workload}-http"
  listener_name                  = "${var.workload}-listener"
  request_routing_rule_name      = "${var.workload}-rule"
  redirect_configuration_name    = "${var.workload}-rdrcfg"
  gateway_ip_configuration       = "${var.workload}-gateway-ip-configuration"
  tags = {
    Role  = "Application Gateway"
  }
}


resource "azurerm_application_gateway" "appgw" {
  name                = "az-${var.workload}-${var.environment}-%{ if var.region == "uaenorth" }uaen%{ else }uaec%{ endif }-agw"
  resource_group_name = var.resource_group_name
  location            = var.region
  tags = merge(var.tags, local.tags)
  enable_http2 = true
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

waf_configuration {
    enabled                  =  true
    firewall_mode            =  "Prevention"
    rule_set_type            =  "OWASP"
    rule_set_version         =  "3.2"
    file_upload_limit_mb     =  100
    max_request_body_size_kb =  128
  }
  gateway_ip_configuration {
    name      = local.gateway_ip_configuration
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
