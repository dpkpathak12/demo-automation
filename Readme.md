# Multiple EC2 with Multiple Regions


## Used



```bash
Module - for deploying ec2 to multiple regions
data providers- For getting the Instance/VPC-ID/Subnet/AMI dynamically.
```

## Usage

```terraform apply -lock=false
provider.aws.region
  The region where AWS operations will take place. Examples
  are us-east-1, us-west-2, etc.

  Enter a value: ap-south-1

aws_default_vpc.default: Refreshing state... [id=vpc-7caf4517]
aws_security_group.nginx_server_sg: Refreshing state... [id=sg-018d654f52d47b29c]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.nginx_server[0] will be created

```
