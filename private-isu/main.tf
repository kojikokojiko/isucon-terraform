

provider "aws" {
  region = "ap-northeast-1" # お好きなリージョンに変更してください
}




module "http_sg"{
  source = "../module/security_group"
  name = "http-sg"
  port=80
  cidr_blocks = ["0.0.0.0/0"]
}


module "https_sg"{
  source = "../module/security_group"
  name = "https-sg"
  port=443
  cidr_blocks = ["0.0.0.0/0"]
}


module "ssh_sg"{
  source = "../module/security_group"
  name = "ssh-sg"
  port=22
  cidr_blocks = ["0.0.0.0/0"]
}

#インスタンスの個数
variable "instance_count" {
  description = "Number of instances to create"
  default     = 1
}

#公開鍵の場所
variable "pub_key_location" {
  description = "Location of public key"
  default     = "~/.ssh/isucon.pub"
}




resource "aws_key_pair" "isucon" {
  key_name   = "isucon"
  # `ssh-keygen`コマンドで作成した公開鍵を指定
  public_key = file(var.pub_key_location)
}

resource "aws_instance" "private-isu" {
  count           = var.instance_count
  ami             = "ami-0d92a4724cae6f07b" # 適切なAMI IDを指定
  instance_type   = "c6i.large"
  key_name               = aws_key_pair.isucon.id
  vpc_security_group_ids = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
    module.ssh_sg.security_group_id
  ]
  tags = {
    Name = "private-isu-${count.index}"
  }
}

output "instance_public_ips" {
  value = [for i in aws_instance.private-isu : i.public_ip]
}

output "instance_public_dns" {
  value = [for i in aws_instance.private-isu : i.public_dns]
}
