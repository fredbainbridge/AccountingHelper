# Setup

## MySql

podman pull mysql
podman run --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d -p 3306:3306 mysql:latest

## Apply Migrations / Create Databse

dotnet ef database update