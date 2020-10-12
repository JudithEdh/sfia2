output "vpc_id" {
  value = aws_vpc.vpc1.id
}

output "public_subnetA_id" {
  value = aws_subnet.publicA.id
}