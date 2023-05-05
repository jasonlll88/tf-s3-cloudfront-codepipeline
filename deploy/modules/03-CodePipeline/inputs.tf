

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

variable "code_pipeline_name" {
  description = "name of the Code Pipeline used for deployment of website files"
  type        = string
}

variable "bucket_id" {
  description = "Id of the bucket created to host files of the website"
  type        = string
}

variable "lambda_name" {
  description = "name of the Lambda function to invalidation the cloudfront distribution"
  type        = string
}
variable "distribution_id" {
  description = "Id of the cloudfront distribution to be used for invalidate the cache"
  type        = string
}