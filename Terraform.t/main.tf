# main.tf

provider "postgresql" {
  host     = var.db_host
  port     = var.db_port
  username = data.aws_secretsmanager_secret_version.db_password_version.secret_string["username"]
  password = data.aws_secretsmanager_secret_version.db_password_version.secret_string["password"]
}

# Generate a random password for the database user
resource "random_password" "Project-webapp_db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  number  = true
}

# Create the PostgreSQL database
resource "postgresql_database" "Project-webapp_db" {
  name = var.db_name
}

# Create the PostgreSQL role
resource "postgresql_role" "Project-webapp_user" {
  name     = var.db_user
  password = random_password.Project-webapp_db_password.result
  login    = true
}

# Grant the created role access to the database
resource "postgresql_grant" "Project-webapp_grant" {
  database   = postgresql_database.Project-webapp_db.name
  role       = postgresql_role.Project-webapp_user.name
  privileges = ["SELECT", "INSERT", "UPDATE"]  # More restrictive privileges
}

# Output the database username and password securely
output "db_username" {
  value     = postgresql_role.Project-webapp_user.name
  sensitive = true
}

output "db_password" {
  value     = random_password.Project-webapp_db_password.result
  sensitive = true
}

output "db_host" {
  value = var.db_host
}







