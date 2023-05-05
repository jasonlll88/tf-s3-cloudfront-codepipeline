provider "aws" {
  alias               = "general"
  allowed_account_ids = var.account_numbers
  region              = var.region
}
