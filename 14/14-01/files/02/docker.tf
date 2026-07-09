resource "random_password" "sql_pass_root" {
  length = 16
  special = false
}

resource "random_password" "sql_pass_user" { 
  length = 16
  special = false
}

resource "docker_image" "mysql" {
  name = "mysql:8"
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.name
  name = "mysql_${random_password.sql_pass_root.result}"
  restart = "always"

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.sql_pass_root.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.sql_pass_user.result}",
    "MYSQL_ROOT_HOST=%"
  ]
  
  ports {
    internal = 3306
    external = 3306
    ip = "127.0.0.1"
  }
}
