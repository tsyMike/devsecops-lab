terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket_seguro" {
  #checkov:skip=CKV_AWS_53: "El bloqueo se gestiona mediante recurso dedicado public_access_block"
  #checkov:skip=CKV_AWS_54: "El bloqueo se gestiona mediante recurso dedicado public_access_block"
  #checkov:skip=CKV_AWS_55: "El bloqueo se gestiona mediante recurso dedicado public_access_block"
  #checkov:skip=CKV_AWS_56: "El bloqueo se gestiona mediante recurso dedicado public_access_block"
  bucket = "mi-bucket-devsecops-demo-12345"
}

resource "aws_s3_bucket_public_access_block" "publico" {
  bucket                  = aws_s3_bucket.bucket_seguro.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_security_group" "sg_seguro" {
  #checkov:skip=CKV2_AWS_5: "Grupo de seguridad de demostración para el laboratorio"
  name        = "sg_ssh_restringido"
  description = "Grupo de seguridad restringido para SSH corporativo"

  ingress {
    description = "Acceso SSH restringido a la red interna"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}
