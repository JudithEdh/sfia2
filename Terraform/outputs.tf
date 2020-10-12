output "test_ip" {
  value = module.Jenkins.public_ip
}

output "jenkins_ip" {
  value = module.Testing.public_ip
}

output "test_db_endpoint" {
  value = module.test.database_endpoint
}

output "db_endpoint" {
  value = module.deployment.database_endpoint
}
