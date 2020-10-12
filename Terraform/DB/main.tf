resource "aws_db_instance" "default" {
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  username          = var.username
  password          = var.password
  allocated_storage = var.allocated_storage
  port              = var.port
  name              = var.name
  identifier        = var.identifier
}
