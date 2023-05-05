variable "account_numbers" {
  description = "Whitelisted account numbers to apply terraform code in. Can apply in any if left blank."
  type    = list(string)
  default = []
}

variable "region" {
  description = "AWS Region to target"
  type        = string
}

variable "aws_profile" {
  description = "AWS Profile credentials to use"
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "String to use as prefix on object names"
  type        = string
}

variable "prepend_name_suffix" {
  description = "String to prepend to the name_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-mysuffix-env"
  type        = string
  default     = ""
}

variable "append_name_suffix" {
  description = "String to append to the name_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-env-mysuffix"
  type        = string
  default     = ""
}

variable "override_name_suffix" {
  description = "String to completely override the name_suffix"
  type        = string
  default     = ""
}

variable "env_name" {
  description = "Environment name string to be used for decisions and name generation. Appended to name_suffix to create full_suffix"
  type        = string
}

variable "source_repo" {
  description = "name of repo which holds this code"
  type        = string
}

variable "developer" {
  description = "name of developer who has written this code"
  type        = string
}


# S3 Vars
variable "bucket_name" {
  description = "name of the S3 bucket where to host the static files"
  type        = string
}
variable "index_document" {
  description = "index file for the bucket static website"
  type        = string
}
variable "error_document" {
  description = "error file for the bucket static website"
  type        = string
}


# Cloudfront Vars
variable "price_class" {
  description = "Price class for Cloudfront distribution, PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
}


# Code Pipelines Vars
variable "code_pipeline_name" {
  description = "name of the Code Pipeline used for deployment of website files"
  type        = string
}
variable "lambda_name" {
  description = "name of the Lambda function to invalidation the cloudfront distribution"
  type        = string
}
