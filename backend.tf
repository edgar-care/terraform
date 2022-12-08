terraform {
  cloud {
    organization = "edgar-care"

    workspaces {
      name = "aws"
    }
  }
}
