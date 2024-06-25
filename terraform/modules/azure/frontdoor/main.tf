# Create Front Door profile
resource "azurerm_cdn_frontdoor_profile" "main" {
  name                = "${var.env}-frontdoor-profile"
  resource_group_name = var.rg_name
  sku_name            = "Premium_AzureFrontDoor"
}

# Create Front Door endpoint
resource "azurerm_cdn_frontdoor_endpoint" "main" {
  name                     = "${var.env}-frontdoor-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id
}

# Create Front Door origin group
resource "azurerm_cdn_frontdoor_origin_group" "main" {
  name                     = "${var.env}-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id
  session_affinity_enabled = true

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    path                = "/"
    protocol            = "Https"
    interval_in_seconds = 100
  }
}

# Create Front Door origins (one for each webapp)
resource "azurerm_cdn_frontdoor_origin" "main" {
  for_each = var.webapps

  name                          = "${each.key}-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  enabled                       = true
  certificate_name_check_enabled = false
  host_name          = each.value
  http_port          = 80
  https_port         = 443
  origin_host_header = each.value
  priority           = 1
  weight             = 1000
}

# Create Front Door route
resource "azurerm_cdn_frontdoor_route" "main" {
  name                          = "${var.env}-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.main.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.main.id
  cdn_frontdoor_origin_ids      = [for origin in azurerm_cdn_frontdoor_origin.main : origin.id]

  supported_protocols    = ["Http", "Https"]
  patterns_to_match      = ["/*"]
  forwarding_protocol    = "HttpsOnly"
  link_to_default_domain = true
  https_redirect_enabled = true
}

# WAF Policy
resource "azurerm_cdn_frontdoor_firewall_policy" "main" {
  name                = "${var.env}wafpolicy"
  resource_group_name = var.rg_name
  sku_name            = azurerm_cdn_frontdoor_profile.main.sku_name
  mode = "Prevention"

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
    action = "Log"
  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
    action = "Log"
  }
}

# Associate the WAF policy with your Front Door security policy
resource "azurerm_cdn_frontdoor_security_policy" "main" {
  name                     = "${var.env}-security-policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.main.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.main.id

      association {
        patterns_to_match = ["/*"]
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.main.id
        }
      }
    }
  }
}