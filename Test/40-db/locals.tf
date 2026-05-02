locals{
    ami_id = data.aws_ami.ami_info.id

    db_sg_id = data.aws_ssm_parameter.db_sg_id.value
    private_subnet_id = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)

    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = "true"
    }
}