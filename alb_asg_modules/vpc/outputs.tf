output "defsub1" {
    value = data.aws_subnet.defsubnet1.id
  
}

output "defsub2" {
    value = data.aws_subnet.defsubnet2.id
  
}

output "vpcid" {
    value = data.aws_vpc.defvpc.id
}