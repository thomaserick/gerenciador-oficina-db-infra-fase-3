terraform {
  backend "s3" {
    bucket = "gerenciador-oficina-fiap"
    key    = "rds/terraform.tfstate"
    region         = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}