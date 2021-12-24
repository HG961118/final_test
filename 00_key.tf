provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_key_pair" "final_key" {
    key_name    = "final-key"
    public_key  = "#비밀"
}

