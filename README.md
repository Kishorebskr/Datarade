
Following Iterations are involved in this repository to acheive the automation pipeline for DB provision of web-app with additional health check services.

Assumtions:
- webapp name - project-webapp
- DB port - 5432
- app port - 8080

-------------------------------------------------------------------------------------------------------------
1. GITLAB CI
     - Provision: This stage sets up the infrastructure, including provisioning a PostgreSQL database.
     - Deploy: Deploys the application (assumed to be containerized) to Kubernetes.
     - Health Check: Verifies that both the application and its database are healthy by sending HTTP requests.
	
-------------------------------------------------------------------------------------------------------------	 
2. Terraform provision
     - This setup automates the infrastructure provisioning, deployment, and health checks for a web application, using Terraform for infrastructure and Kubernetes for 
       application deployment.
     - main: Configures the PostgreSQL provider, creates the database, user, and grants permissions.
     - terraform.tfvars: Provides values for variables, including pulling database credentials from AWS Secrets Manager.                                                      
     - variables.tf: Declares the variables used across the Terraform configuration.
	 
-------------------------------------------------------------------------------------------------------------
3. Kuberenetes deployment & pod probe health check
     - This part defines the deployment of the web application and its service in Kubernetes
     - The application container (Project-webapp-container) using the latest image
     - Environment variables for connecting to the database (DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, and DB_NAME), where sensitive values are fetched from Kubernetes secrets.
     - The readiness probe (/db-health) and the liveness probe (/health) both request health endpoints within the web application, as required. 
-------------------------------------------------------------------------------------------------------------
4. Monitoring and Alert setup using Prometheus
     - Prometheus to monitor the health of your web application and database connection.
     - Alertmanager to send notifications if the web application becomes unhealthy (e.g. database connection fails).
     - Exposed application metrics using prometheus_client in your Flask app.
	 
-------------------------------------------------------------------------------------------------------------



