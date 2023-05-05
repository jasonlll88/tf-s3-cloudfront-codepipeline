output "bucket_arn" {
    value = aws_s3_bucket.static_website.arn
}

output "bucket_website_endpoint" {
    value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "bucket_id" {
    value = aws_s3_bucket.static_website.id
}
