module s3_setup {
    source                  = "./modules/01-S3"
    
    common_tags             = local.common_tags
    name_prefix             = var.name_prefix
    name_suffix             = local.name_suffix
    
    bucket_name             = var.bucket_name
    index_document          = var.index_document
    error_document          = var.error_document

    providers = {
        aws = aws.general
    }


}

module cloudfront_setup {
    source                      = "./modules/02-Cloudfront"
    
    common_tags                 = local.common_tags
    name_prefix                 = var.name_prefix
    name_suffix                 = local.name_suffix

    bucket_website_endpoint     = module.s3_setup.bucket_website_endpoint
    price_class                 = var.price_class

    providers = {
        aws = aws.general
    }
}

module codepipeline_setup {
    source                      = "./modules/03-CodePipeline"
    
    common_tags                 = local.common_tags
    name_prefix                 = var.name_prefix
    name_suffix                 = local.name_suffix
    
    code_pipeline_name          = var.code_pipeline_name
    lambda_name                 = var.lambda_name
    distribution_id             = module.cloudfront_setup.distribution_id


    bucket_id                   = module.s3_setup.bucket_id

    providers = {
        aws = aws.general
    }
}