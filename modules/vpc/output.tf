# 모듈간의 데이터 공유를 위해 사용
output "vpc_id" { 
  value = aws_vpc.vpc.id
} 

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
}

output "web_subnet_ids" {
  value = values(aws_subnet.web_subnets)[*].id
}

output "app_subnet_ids" {
  value = values(aws_subnet.app_subnets)[*].id
}