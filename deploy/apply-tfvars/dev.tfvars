
# Global Vars
region      = "us-east-1"
name_prefix = "itv-jlrm"
env_name    = "dev"
source_repo = "https://github.com/jasonlll88/tf-s3-cloudfront-codepipeline.git"
developer   = "Jheison Rodriguez"


# S3 Vars
bucket_name     = "static-website"
index_document  = "index.html"
error_document  = "error.html"


# Cloudfront Vars
price_class     = "PriceClass_100"


# Codepipeline Vars
code_pipeline_name = "static-website"
lambda_name        = "invalidate-cache"