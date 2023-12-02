resource "aws_kms_key" "a" {
  description                        = "ENCRPT_DECRYPT"
  enable_key_rotation                = "true"
  is_enabled                         = "true"
  key_usage                          = "ENCRYPT_DECRYPT"
  tags = {
    Name = "key-a"
  }
}