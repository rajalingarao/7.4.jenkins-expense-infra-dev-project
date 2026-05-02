resource "aws_instance" "db" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.db_sg_id]
  subnet_id = local.private_subnet_id
  #iam_instance_profile = "EC2RoleToFetchSSMParams"
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-db"
    }
  )
}

resource "terraform_data" "db" {
  triggers_replace = [
    aws_instance.db.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.db.private_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh db ${var.environment}"
    ]
  }
}

resource "aws_route53_record" "db" {
  zone_id = var.zone_id
  name    = "db-${var.environment}.${var.domain_name}" # db-dev.lithesh.shop
  type    = "A"
  ttl     = 1
  records = [aws_instance.db.private_ip]
  allow_overwrite = true
}