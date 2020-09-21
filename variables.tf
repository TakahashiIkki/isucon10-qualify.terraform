variable "profile" {
  description = "AWS設定のプロファイル名"
}

variable "region" {
  description = "deploy先のリージョン"
}

variable "key_pair_name" {
  description = "EC2のキーペア名"
}

variable "vpc_id" {
  description = "EC2が所属するVPCのID"
}