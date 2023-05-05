output "account_id" {
  description = "Account which terraform was run on"
  value       = data.aws_caller_identity.current.account_id
}

output "name_prefix" {
  description = "string to prepend to all resource names"
  value       = var.name_prefix
}

output "name_suffix" {
  description = "string to append to all resource names"
  value       = local.name_suffix
}

output "common_tags" {
  description = "tags which should be applied to all taggable objects"
  value       = local.common_tags
}

output "bucket_arn" {
    value = module.s3_setup.bucket_arn
}

output "bucket_website_endpoint" {
    value = module.s3_setup.bucket_website_endpoint
}

output "bucket_id" {
    value = module.s3_setup.bucket_id
}

output "distribution_id" {
    value = module.cloudfront_setup.distribution_id
}