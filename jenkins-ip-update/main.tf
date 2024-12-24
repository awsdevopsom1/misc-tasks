terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "misc/jenkins-ip-update/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_instance" "jenkins" {
    instance_id = "i-0d59ffe290edf098e"
}

resource "aws_route53_record" "jenkins-ip" {
  zone_id = "Z0705553LI8IW1JSJIQR"
  name    = "jenkins"
  type    = "A"
  ttl     = 10
  records = [data.aws_instance.jenkins.public_ip]
}