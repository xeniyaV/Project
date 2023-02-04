
terraform {
  backend "s3" {}
} 

terraform {
  required_providers {
    aws= {
      source  = "hashicorp/aws"
      version = "~> 1.0"
    }
  }
}
