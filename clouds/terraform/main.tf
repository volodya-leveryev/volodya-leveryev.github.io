provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "us-east-1"
}

# Создаем бакет S3
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Отключаем блокировку публичного доступа к бакету S3
resource "aws_s3_bucket_public_access_block" "my_public_access" {
  bucket = aws_s3_bucket.my_bucket.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

# Правило доступа к бакету
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = ["s3:GetObject"]
      Resource = "${aws_s3_bucket.my_bucket.arn}/*"
    }]
  })
}

# Настраиваем веб-сайт
resource "aws_s3_bucket_website_configuration" "my_web_config" {
  bucket = aws_s3_bucket.my_bucket.bucket
  index_document {
    suffix = "index.html"
  }
}

# Загружаем файл
resource "aws_s3_object" "index_page" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

# Находим TLS-сертификат
data "aws_acm_certificate" "kit_imi_sertificate" {
  domain = "*.kit-imi.info"
}

resource "aws_cloudfront_distribution" "cdn" {
  aliases = ["${var.domain_name}.kit-imi.info"]

  default_cache_behavior {
    # Caching optimized
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "${var.bucket_name}"
    viewer_protocol_policy = "allow-all"
  }

  default_root_object = "index.html"

  enabled = true

  origin {
    domain_name = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_id = "${var.bucket_name}"
  }

  restrictions {
    geo_restriction {
      locations = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.kit_imi_sertificate.arn}"
    ssl_support_method = "sni-only"
  }
}

# Находим зону с доменными именами
data "aws_route53_zone" "my_dns_zone" {
  name = "kit-imi.info."
}

# Создаем доменное имя
resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.my_dns_zone.zone_id
  name = "${var.domain_name}"
  type = "CNAME"
  ttl = 5
  records = ["${aws_cloudfront_distribution.cdn.domain_name}"]
}
