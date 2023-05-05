resource "aws_cloudfront_distribution" "s3_distribution" {
  
  enabled     = true
  price_class = var.price_class

  origin {
    origin_id   = var.bucket_website_endpoint
    domain_name = var.bucket_website_endpoint
    custom_origin_config {

      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]    
    }
  }

  # Setting up No cache for default behavior
  default_cache_behavior {
    viewer_protocol_policy    = "https-only"
    target_origin_id          = var.bucket_website_endpoint
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    compress                  = true
    # Using the CachingDisabled managed policy ID:
    cache_policy_id = data.aws_cloudfront_cache_policy.caching_disabled.id
  }

  # Cache 30 min TTL for images folder
  ordered_cache_behavior {
    viewer_protocol_policy    = "https-only"
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_website_endpoint
    compress               = true
    # Using the Caching30m policy
    cache_policy_id = aws_cloudfront_cache_policy.cache_policy_30_min.id
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }  


  tags = merge(local.tags,{Name = "${var.name_prefix}-cloudfront-${var.name_suffix}"})    

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

resource "aws_cloudfront_cache_policy" "cache_policy_30_min" {
  name        = "Caching-Policy-30m"
  comment     = "Caching-Policy-30m"
  default_ttl = 30
  max_ttl     = 30
  min_ttl     = 30
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}