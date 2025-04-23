resource "aws_security_group" "public-security-group" {
  vpc_id      = module.terraform-basic-network.vpc_id

  tags = {
    Name = "public-security-group"
  }
  depends_on = [module.terraform-basic-network] 
}

resource "aws_vpc_security_group_ingress_rule" "allow-internet-ssh" {
  security_group_id = aws_security_group.public-security-group.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_security_group" "private-security-group" {
  vpc_id      = module.terraform-basic-network.vpc_id

  tags = {
    Name = "private-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-internal-ssh" {
  security_group_id = aws_security_group.private-security-group.id
  cidr_ipv4 = module.terraform-basic-network.vpc_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow-internal-reqs" {
  security_group_id = aws_security_group.private-security-group.id
  cidr_ipv4 = module.terraform-basic-network.vpc_cidr
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}


