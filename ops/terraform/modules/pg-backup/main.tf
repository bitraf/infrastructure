terraform {
  required_providers {
    minio = {
      source = "aminueza/minio"
      version = "1.2.0"
    }
  }
}

resource "minio_iam_user" "sender" {
  name = "pg-backup-${var.id}-sender"
#  update_secret = true
}

resource "minio_s3_bucket" "bucket" {
  bucket = "pg-backup-${var.id}"
  acl    = "public"
}

resource "minio_iam_policy" "sender" {
  name = minio_iam_user.sender.id
  policy= <<EOF
{
  "Version":"2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::${minio_s3_bucket.bucket.bucket}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::${minio_s3_bucket.bucket.bucket}/*"
    }
  ]
}
EOF
}

resource "minio_iam_user_policy_attachment" "sender" {
  user_name  = minio_iam_user.sender.id
  policy_name = minio_iam_policy.sender.id
}

output "sender" {
  value = {
    access_key: minio_iam_user.sender.name,
    secret_key: minio_iam_user.sender.secret,
  }
}

output "bucket" {
  value = {
    name: minio_s3_bucket.bucket.id,
  }
}
