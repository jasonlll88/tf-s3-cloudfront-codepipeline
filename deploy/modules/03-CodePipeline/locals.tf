locals {

    lambda_function_name = "${var.name_prefix}-${var.lambda_name}${var.name_suffix}"

    tags = merge(var.common_tags, {
        terraformModulePath = "${path.module}"
    })
}
