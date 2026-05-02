module "db" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for DB Mysql Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "db"
}

module "backend" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for Backend Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "backend"
}

module "frontend" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for Frontend Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "frontend"
}

module "bastion" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for Bastion Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "Bastion"
}
module "vpn" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for VPN Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "VPN"
  ingress_rules = var.vpn_sg_rules
}
module "app_alb" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for APP ALB Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "APP ALB"
}
module "web_alb" {
  #source        = "../../../5.12.terraform-aws-securitygroup"
  source = "git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for Web ALB Instance"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "Web_ALB"
 }



#db:
# DB is accepting connections from backend
resource "aws_security_group_rule" "db_backend" {
  type      =  "ingress"
  from_port = 3306
  to_port =  3306
  protocol = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id = module.db.sg_id
}
resource "aws_security_group_rule" "db_bastion" {
  type      =  "ingress"
  from_port = 3306
  to_port =  3306
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.db.sg_id
}
resource "aws_security_group_rule" "db_vpn" {
  type      =  "ingress"
  from_port = 3306
  to_port =  3306
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.db.sg_id
}
resource "aws_security_group_rule" "db_vpn_ssh" {
  type      =  "ingress"
  from_port = 22
  to_port =  22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.db.sg_id
}
#backend:
resource "aws_security_group_rule" "backend_app_alb" {
  type      =  "ingress"
  from_port =  8080
  to_port =  8080
  protocol = "tcp"
  source_security_group_id = module.app_alb.sg_id
  security_group_id = module.backend.sg_id
}
resource "aws_security_group_rule" "backend_bastion_ssh" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_vpn_ssh" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend.sg_id
}
resource "aws_security_group_rule" "backend_vpn_http" {
  type      =  "ingress"
  from_port =  8080
  to_port =  8080
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend.sg_id
}

#app_alb
resource "aws_security_group_rule" "app_alb_vpn" {
  type      =  "ingress"
  from_port =  80
  to_port =  80
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_frontend" {
  type      =  "ingress"
  from_port =  80
  to_port =  80
  protocol = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.app_alb.sg_id
}
resource "aws_security_group_rule" "app_alb_bastion" {
  type      =  "ingress"
  from_port =  80
  to_port =  80
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.app_alb.sg_id
}

#frontend
resource "aws_security_group_rule" "frontend_web_alb" {
  type      =  "ingress"
  from_port =  80
  to_port =  80
  protocol = "tcp"
  source_security_group_id = module.web_alb.sg_id
  security_group_id = module.frontend.sg_id
}
resource "aws_security_group_rule" "frontend_bastion" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
}
resource "aws_security_group_rule" "frontend_vpn" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.frontend.sg_id
}

#web_alb:
resource "aws_security_group_rule" "web_alb_public_http" {
  type      =  "ingress"
  from_port =  80
  to_port =  80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}
resource "aws_security_group_rule" "web_alb_public_https" {
  type      =  "ingress"
  from_port =  443
  to_port =  443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb.sg_id
}

#bastion:
resource "aws_security_group_rule" "bastion_public" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#VPN:
# HTTPS (VPN over SSL)
resource "aws_security_group_rule" "vpn_public_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # replace with your IP
  security_group_id = module.vpn.sg_id
}

# OpenVPN (main tunnel)
resource "aws_security_group_rule" "vpn_public_openvpn" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"  # OpenVPN typically uses UDP
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

# Admin UI (943)
resource "aws_security_group_rule" "vpn_admin" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

# SSH access
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}





# This is for CICD connect to default VPC
resource "aws_security_group_rule" "backend_default_vpc" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  cidr_blocks = ["172.31.0.0/16"]
  security_group_id = module.backend.sg_id
}
# This is for CICD connect to default VPC
resource "aws_security_group_rule" "frontend_default_vpc" {
  type      =  "ingress"
  from_port =  22
  to_port =  22
  protocol = "tcp"
  cidr_blocks = ["172.31.0.0/16"]
  security_group_id = module.frontend.sg_id
}