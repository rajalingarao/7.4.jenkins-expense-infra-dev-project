# Expense Architecture

![alt text](expense-infra-dev.drawio.svg)

# Infrastructure creation and deletion

```
ssh -i ~/.ssh/openvpn openvpnas@54.167.8.2017
```


Gmail Account Credentials
siva practise
sivalingapractise555@gmail.com
Helloworld#100

AWS Login Credentials
sivalingapractise555@gmail.com
Helloworld#100


```
for i in 00-vpc/ 10-sg/ 20-bastion/ 30-vpn/ 40-db/ 50-app-alb/ 60-acm/ 80-web-alb/ 100-cdn/ ; do cd $i; terraform init; cd .. ; done
```

```
for i in 00-vpc/ 10-sg/ 20-bastion/ 30-vpn/ 40-db/ 50-app-alb/ 60-acm/ 80-web-alb/ 100-cdn/ ; do cd $i; terraform plan; cd .. ; done 
```
```
for i in 00-vpc/ 10-sg/ 20-bastion/ 30-vpn/ ; do cd $i; terraform apply -auto-approve; cd .. ; done 
```
```
for i in 06-app-alb/ 07-backend/ 07.1-acm/ 08-web-alb/ 09-frontend/ 10-cdn/ ; do cd $i; terraform apply -auto-approve; cd .. ; done 
```
```
for i in 01-vpc/ 02-sg/ 03-bastion 04-db/ 05-vpn/ 06-app-alb/ 07-backend/ 07.1-acm/ 08-web-alb/ 09-frontend/ 10-cdn/ ; do cd $i; terraform apply -auto-approve; cd .. ; done 
```

```
for i in 10-cdn/ 09-frontend/ 08-web-alb/ 07.1-acm/ 07-backend/ 06-app-alb/ 05-db/ 04-vpn/ 03-bastion/ 02-sg/ 01-vpc/ ; do cd $i; terraform destroy -auto-approve; cd .. ; done 
```

Note: We can use either default VPC subnet and its security group or roboshop VPC subnet or its security group.

#  default VPC subnet and its security group
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    subnet_id              = data.aws_subnet.selected.id

# roboshop VPC subnet or its security group
    vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
    subnet_id              = local.database_subnet_id
