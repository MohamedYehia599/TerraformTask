data "aws_ami" "al-2023" {
   most_recent = true
  owners      = ["amazon"] 

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}



resource "aws_key_pair" "key" {
  key_name   = "myDemoKey"  
  public_key = file("~/.ssh/myDemoKey.pub")
  tags = {
        Name = "ec2-key"
      }
}

resource "aws_instance" "bastion-instance" {
  ami           = data.aws_ami.al-2023.id
  instance_type = "t2.micro"
  subnet_id     = module.terraform-basic-network.public_subnet_1_id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public-security-group.id]
  key_name      = aws_key_pair.key.key_name
  
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> bastion_public_ip.txt"
  }
  tags = {
    Name = "bastion-instance"
  }
}


resource "aws_instance" "application-instance" {
  ami           = data.aws_ami.al-2023.id
  instance_type = "t2.micro"
  subnet_id     = module.terraform-basic-network.private_subnet_1_id
  vpc_security_group_ids = [aws_security_group.private-security-group.id]
  key_name      =  aws_key_pair.key.key_name

  tags = {
    Name = "application-instance"
  }
}