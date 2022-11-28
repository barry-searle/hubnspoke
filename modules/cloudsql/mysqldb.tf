resource "google_sql_database" "main" {
  name     = "main"
  instance = google_sql_database_instance.main_primary.name
}
resource "google_sql_database_instance" "main_primary" {
  name             = "main-primary"
  database_version = "MYSQL_8_0_28"
  depends_on       = [module.vpc.out_hub_spoke1_mysql_subnet]
  
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = 10  # 10 GB is the smallest disk size
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.vpc.out_hub_vpc_self_link
    }
  }
}
resource "google_sql_user" "db_user" {
  name     = var.user
  instance = google_sql_database_instance.main_primary.name
  password = var.password
}