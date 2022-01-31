resource_group_name = "#{resource_group_name}#"
partner_id = "#{partner_id}#"
application_insights = {
  appinsight1 = {
    name                                  = "#{application_insights_name}#" # <"application_insights_name">
    application_type                      = "#{application_type}#"                       # <"application_insights_type">
    retention_in_days                     = "#{retention_in_days}#"                          # <"application_insights_retention_period_in_days"
    daily_data_cap_in_gb                  = null                        # <"application_insights_daily_data_volume_cap_in_gb"
    daily_data_cap_notifications_disabled = null                        # <true | false>
    sampling_percentage                   = null                        # <"appication_insights_telemetry_data_percentage">
    disable_ip_masking                    = null                        # <true | false>
  }
}

app_insights_additional_tags = {
  # iac = "Terraform"
  # env = "UAT"
}