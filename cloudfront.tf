resource "aws_s3_bucket" "s3_origin" {
    bucket = "edgar-care-cloudfront-bucket-origin"
}

resource "aws_s3_bucket" "s3_logs" {
    bucket = "edgar-care-cloudfront-logs-bucket"
}

resource "aws_s3_bucket_acl" "s3_origin_acl" {
    bucket = aws_s3_bucket.s3_origin.id
    acl = "private"
}

locals {
    s3_origin_id = "edgar.care"
}

# resource "aws_cloudfront_origin_access_control" "example" {
#     name                              = "edgar-care-cloudfront-origin-access-control"
#     origin_access_control_origin_type = "s3"
#     signing_behavior                  = "always"
#     signing_protocol                  = "sigv4"
# }

resource "aws_cloudfront_distribution" "edgar_care_cloudfront_distribution" {
    origin {
        domain_name              = aws_s3_bucket.s3_origin.bucket_regional_domain_name
        # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
        origin_id                = local.s3_origin_id
    }

    enabled = true
    is_ipv6_enabled     = true

    logging_config {
        include_cookies = false
        bucket          = aws_s3_bucket.s3_logs.bucket_domain_name
        prefix          = "myprefix"
    }

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = local.s3_origin_id

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "allow-all"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "whitelist"
            locations        = ["FR"]
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}
