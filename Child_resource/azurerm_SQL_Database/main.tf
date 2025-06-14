# resource "azurerm_mysql_database" "mysql_database" {
#   name                = var.mysql_database
#   resource_group_name = var.rg_name
#   server_name         = var.mysql_server_name
#   charset             = "utf8"
#   collation           = "utf8_unicode_ci"
# }
resource "azurerm_mssql_database" "mssql_db" {
  name                = var.mysql_database
  server_id           = var.sql_server_id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 2
  sku_name            = "S0"
}

