locals {

    tags = merge(var.common_tags, {
        terraformModulePath = "${path.module}"
    })
}
