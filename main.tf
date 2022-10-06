# provider
provider "aws" {
# region = "eu-west-2"
region = var.region
  
}

# vpc
resource "aws_vpc" "three_tier_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  tags = {
    Name = var.three_tier_vpc_name
  }
}

# private sub1
resource "aws_subnet" "app_private_sub1" {
  vpc_id     = aws_vpc.three_tier_vpc.id
  cidr_block = var.priv_sub1_cidr_block
  availability_zone = var.priv_sub1_availability_zone
  tags = {
    Name = var.priv_sub1_name
  }
}

# private sub2
resource "aws_subnet" "app_private_sub2" {
  vpc_id     = aws_vpc.three_tier_vpc.id
  cidr_block = var.priv_sub2_cidr_block
  availability_zone = var.priv_sub2_availability_zone
  tags = {
    Name = var.priv_sub2_name
  }
}

# # private sub3
# resource "aws_subnet" "db_private_sub3" {
#   vpc_id     = aws_vpc.three_tier_vpc.id
#   cidr_block = "10.0.3.0/24"
#   availability_zone = "eu-west-2a"
#   tags = {
#     Name = "private_sub2"
#   }
# }

# # private sub4
# resource "aws_subnet" "db_private_sub4" {
#   vpc_id     = aws_vpc.three_tier_vpc.id
#   cidr_block = "10.0.4.0/24"
#   availability_zone = "eu-west-2b"
#   tags = {
#     Name = "private_sub2"
#   }
# }

# public sub1
resource "aws_subnet" "public_sub1" {
  vpc_id     = aws_vpc.three_tier_vpc.id
  cidr_block = var.pub_sub1_cidr_block
  availability_zone = var.pub_sub1_availability_zone
  map_public_ip_on_launch = var.pub_sub1_map_public_ip_on_launch
  tags = {
    Name = var.public_sub1_name
  }
}

# public sub2
resource "aws_subnet" "public_sub2" {
  vpc_id     = aws_vpc.three_tier_vpc.id
  cidr_block = var.pub_sub2_cidr_block
  availability_zone = var.pub_sub2_availability_zone
  map_public_ip_on_launch = var.pub_sub2_map_public_ip_on_launch
  tags = {
    Name = var.public_sub2_name
  }
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.three_tier_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# route
resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = var.pub_route_destination_cidr_block
  gateway_id                = aws_internet_gateway.igw.id
#   vpc_peering_connection_id = "pcx-45ff3dc1"
#   depends_on                = [aws_route_table.testing]
}

# elastic ip
resource "aws_eip" "elastic_ip" {
  vpc = true
}

# nat gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_sub1.id
  tags = {
    Name = var.ngw_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.example]
}

# private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = var.priv_route_table_cidr_block
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = var.priv_route_table_name
  }
}

# public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.three_tier_vpc.id

  route {
    cidr_block = var.pub_route_table_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

    tags = {
    Name = var.public_route_table_name
  }
}

# route table association
resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.app_private_sub1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.app_private_sub2.id
  route_table_id = aws_route_table.private_route_table.id
}

# resource "aws_route_table_association" "private_association2" {
#   subnet_id      = aws_subnet.db_private_sub3.id
#   route_table_id = aws_route_table.private_route_table.id
# }

# resource "aws_route_table_association" "private_association" {
#   subnet_id      = aws_subnet.db_private_sub4.id
#   route_table_id = aws_route_table.private_route_table.id
# }

resource "aws_route_table_association" "public_association1" {
  subnet_id      = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_association2" {
  subnet_id      = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_route_table_association" "igw_asociation" {
#   gateway_id     = aws_internet_gateway.igw.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# security group
#resource "aws_security_group" "allow_ssh_http"
resource "aws_security_group" "three_tier_sg" {
  #name        = "allow_ssh_http"
  name        = var.three_tier_sg_name
  description = "Allow ssh and http inbound traffic"
  vpc_id      = aws_vpc.three_tier_vpc.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.sg_ssh_ingress_cidr_block
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.sg_http_ingress_cidr_block
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.sg_egress_cidr_block
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    #Name = "allow_ssh_http"
    name = var.three_tier_sg_name
  }
}