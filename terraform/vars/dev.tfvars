region = "us-east-1"
env = "dev"
tags = {
  "managed_by": "terraform",
  "env": "dev"
}
vpc_cidr_block = "10.0.0.0/16"
subnet_cidrs = {
  "public": {"a": "10.0.10.0/24", "b": "10.0.20.0/24"},
  "private": {"a": "10.0.40.0/21", "b": "10.0.48.0/21"}
}

eks_ssh_key = "eks-dev-key"

default_eks_node_group_disk_size = 50

default_eks_node_group_instance_type = "m5.xlarge"

default_eks_node_group_max_size = 3

app_eks_node_group_instance_type = "m5.xlarge"

app_eks_node_group_disk_size = 50

app_eks_node_group_max_size = 6



workers_eks_node_group_instance_type = "m5.xlarge"

workers_eks_node_group_disk_size = 50

workers_eks_node_group_max_size = 10

eks_version = 1.18


cluster_name=eks-dev

#bastion-ec2

bastion_sg_name                = "bastion-sg"
bastion_sg_description         = "Security group for bastion host"
bastion_sg_ingress_from_port   = 22
bastion_sg_ingress_to_port     = 22
bastion_sg_ingress_protocol    = "tcp"
bastion_sg_ingress_cidr_blocks = ["0.0.0.0/0"]  # Be cautious with 0.0.0.0/0, restrict as needed
bastion_sg_egress_from_port    = 0
bastion_sg_egress_to_port      = 0
bastion_sg_egress_protocol     = "-1"
bastion_sg_egress_cidr_blocks  = ["0.0.0.0/0"]
bastion_ami                    = "ami-12345678"
bastion_instance_type          = "t2.micro"
bastion_key_name               = "my-bastion-key-pair"
bastion_instance_name          = "BastionHost"


#web-ec2

web_sg_name                = "web-server-sg"
web_sg_description         = "Security group for web server"
web_sg_ingress_from_port   = 80
web_sg_ingress_to_port     = 80
web_sg_ingress_protocol    = "tcp"
web_sg_ingress_cidr_blocks = ["0.0.0.0/0"]
web_sg_egress_from_port    = 0
web_sg_egress_to_port      = 0
web_sg_egress_protocol     = "-1"
web_sg_egress_cidr_blocks  = ["0.0.0.0/0"]
web_ami                    = "ami-12345678"
web_instance_type          = "t2.micro"
web_key_name               = "my-key-pair"
web_instance_name          = "WebServerInstance"
