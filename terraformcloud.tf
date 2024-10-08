#terraform {
#  backend "remote" {
#    organization = "example_testkasa"
#
#    workspaces {
#      name = "example_workspace"
#    }
#  }
#}
#
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
