provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "eFuse-vpc"
  cidr = "10.0.0.0/16"

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  private_subnets = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}

resource "aws_security_group" "worker_nodes" {
  name        = "eFuse-worker-nodes-security-group"
  description = "Allow incoming SSH and HTTP traffic"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "worker_nodes_role" {
  name = "eFuse-worker-nodes-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eFuse-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.worker_nodes_role.name}"
}

resource "aws_iam_role_policy_attachment" "eFuse-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.worker_nodes_role.name}"
}

resource "aws_iam_instance_profile" "worker_nodes_instance_profile" {
  name = "eFuse-worker-nodes-instance-profile"
  roles = [
    aws_iam_role.worker_nodes_role.name
  ]
}

resource "aws_eks_cluster" "eFuse" {
  name     = "eFuse-eks-cluster"
  role_arn = aws_iam_role.worker_nodes_role.arn
  vpc_config {
    subnet_ids = module.vpc.private_subnets_ids
  }
}

resource "aws_launch_configuration" "worker_nodes_config" {
  name                 = "eFuse-worker-nodes-config"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.worker_nodes_instance_profile.name
  security_groups      = [aws_security_group.worker_nodes.id]

  # Additional configuration for the worker nodes,
