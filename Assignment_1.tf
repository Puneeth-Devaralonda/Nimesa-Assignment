# Define the AWS provider and region
provider "aws" {
  region = "us-east-1" # Change to your desired region
  access_key = "AKIAR4DIXL4MABDK4AVW"
  secret_key = "8hqHs9LiyRXwvRJlgt5mwJFfFse1Df71HqBoHPmT"
}

# Create a VPC
resource "aws_vpc" "MyVPC" {
  cidr_block = "10.0.0.0/16" # Change to your desired CIDR block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name    = "MyVPC"
  }
}

# Create a public subnet in the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.MyVPC.id
  cidr_block              = "10.0.1.0/24" # Change to your desired CIDR block
  availability_zone       = "us-east-1a"  # Change to your desired availability zone
  tags = {
    Name    = "Public subnet"
  }
}

# Create a private subnet in the VPC
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.MyVPC.id
  cidr_block              = "10.0.2.0/24" # Change to your desired CIDR block
  availability_zone       = "us-east-1b"  # Change to your desired availability zone
  tags = {
    Name    = "Private subnet"
  }
}

# Create a security group for the EC2 instance
resource "aws_security_group" "example_security_group" {
  name_prefix = "example-sg-"

  # Inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance in the public subnet
resource "aws_instance" "Myinstance" {
  ami           = "ami-03a6eaae9938c858c"
  instance_type = "t2.micro"
#  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.example_security_group.name]

  # Root volume configuration
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name    = "Assignment Instance"
  }
}
