module "eks-workstation" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.rhel-9.id
  name = "eks-workstation"

  instance_type = "t3.medium"
  subnet_id     = data.aws_subnet.default_vpc_subnet.id
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]
  create_security_group = false
  user_data = file("workstation-setup.sh")
  iam_instance_profile = "EC2-Full-Access-Role"

  root_block_device = {
    size = 50
    type = "gp3"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "eks-workstation"
  }
}