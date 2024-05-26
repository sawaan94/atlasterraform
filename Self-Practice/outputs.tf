output "ec2pubip" {
  value = aws_instance.practicevm.public_ip
}

output "ec2id" {
  value = aws_instance.practicevm.id

}

output "pubdns" {
  value = aws_instance.practicevm.public_dns

}

output "ec2tags" {
  value = aws_instance.practicevm.tags

}