data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnet" "default_vpc_subnet" {
    vpc_id = data.aws_vpc.default_vpc.id
    availability_zone = "us-east-1a"
}

data "aws_ami" "rhel-9" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# 2. Retrieve the custom security group inside the default VPC
data "aws_security_group" "allow_all" {
  vpc_id = data.aws_vpc.default_vpc.id

  # Filter by a known identifier, such as a specific tag or a name prefix
  tags = {
    Name = "Allow-All"
  }
}

# 3. Output the custom security group name
