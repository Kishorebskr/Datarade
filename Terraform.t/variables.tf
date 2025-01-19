# variables.tf
--------------------------------------------script ends here-------------------------------------------------------
variable "db_host" {
  description = "The host of the PostgreSQL database"
  type        = string
  default     = "localhost"
}

variable "db_port" {
  description = "The port on which PostgreSQL is running"
  type        = number
  default     = 5432
}

variable "db_admin_password" {
  description = "The admin password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the PostgreSQL database"
  type        = string
  default     = "Project-webapp_db"
}

variable "db_user" {
  description = "The username for PostgreSQL"
  type        = string
  default     = "Project-webapp_user"
}

--------------------------------------------script ends here-------------------------------------------------------
