

variable "common_tags" {
    type        = map(string)
    default     = {}
    description = "Tags the user wants add"
}

variable "name_prefix" {
  description = "String to use as prefix on object names"
  type        = string
}

variable "name_suffix" {
  description = "String to use as prefix on object names"
  type        = string
}

variable "bucket_website_endpoint" {
  description = "String to use as url of the bucket for the origin"
  type        = string
}

variable "price_class" {
  description = "Price class for Cloudfront distribution, PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
}