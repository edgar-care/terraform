module "openapi-bucket" {
    for_each = var.buckets
    source = "terraform-aws-modules/s3-bucket/aws"

    bucket = each.key
    acl    = each.value.acl

    versioning = {
        enabled = each.value.versioning
    }
}
