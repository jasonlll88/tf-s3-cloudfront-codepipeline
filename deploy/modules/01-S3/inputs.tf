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