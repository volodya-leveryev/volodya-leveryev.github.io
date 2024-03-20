provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "my_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject", "s3:PutObject"]
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.my_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

# resource "aws_s3_object" "video" {
  
# }

data "aws_acm_certificate" "kit_imi_sertificate" {
  domain = "*.kit-imi.info" 
}

resource "aws_cloudfront_distribution" "cdn" {
   origin {
     domain_name = aws_s3_bucket_website_configuration.web.website_endpoint
     origin_id = "unical-${var.bucket_name}"

    custom_origin_config {
      http_port = 80
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
   }
   enabled = true
   default_root_object = "index.html"
   restrictions {
     geo_restriction {
      restriction_type = "none"
     }
   }

   aliases = ["${var.domain_name}.kit-imi.info"]
   default_cache_behavior {
     target_origin_id = "unical-${var.bucket_name}"
     cached_methods = ["GET", "HEAD"]
     viewer_protocol_policy = "redirect-to-https"
     allowed_methods = ["GET","HEAD"]

     forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
     }
   }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.kit_imi_sertificate.arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}


data "aws_route53_zone" "cloudfront_zone" {
  name         = "kit-imi.info."
}


resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.cloudfront_zone.zone_id
  name    = "${var.domain_name}"
  type    = "CNAME"
  ttl     = 5

  records        = ["${aws_cloudfront_distribution.cdn.domain_name}"]
}
