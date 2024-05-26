output "vpcid" {
    value = aws_vpc.vpc1.id
}

output "subnet" {
    value = aws_subnet.publicsubnet1.id
}