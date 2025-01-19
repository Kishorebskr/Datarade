# terraform.tfvars
--------------------------------------------script starts here-------------------------------------------------------
# Fetch database password from AWS Secrets Manager
data "aws_secretsmanager_secret" "db_password" {
  name = "project-webapp-db-password"
}

data "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

# Use the fetched secret as the database password for the user
resource "postgresql_role" "Project-webapp_user" {
  name     = var.db_user
  password = data.aws_secretsmanager_secret_version.db_password_version.secret_string
  login    = true
}

--------------------------------------------script ends here-------------------------------------------------------

