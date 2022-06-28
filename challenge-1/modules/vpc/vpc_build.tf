
resource "aws_vpc" "vpc_build" {
  cidr_block = var.vpc_cdir_block

  tags = {
    Name = "VPC"
  }

}
output "vpc_id" {
  value = aws_vpc.vpc_build.id
}


resource "aws_subnet" "publicsubnet1" {

  vpc_id            = aws_vpc.vpc_build.id
  cidr_block        = var.public_subnet_1
  availability_zone = var.availability_zone_A

  tags = {
    Name = "Public Subnet-1"
  }
}

output "out_publicsubnet1" {
  value = aws_subnet.publicsubnet1.id
}


resource "aws_subnet" "publicsubnet2" {

  vpc_id            = aws_vpc.vpc_build.id
  cidr_block        = var.public_subnet_2
  availability_zone = var.availability_zone_B

  tags = {
    Name = "Public Subnet-2"
  }

}

output "out_publicsubnet2" {
  value = aws_subnet.publicsubnet2.id
}


resource "aws_subnet" "privatesubnet3" {

  vpc_id            = aws_vpc.vpc_build.id
  cidr_block        = var.private_subnet_3
  availability_zone = var.availability_zone_A

  tags = {
    Name = "Private Subnet-3"
  }

}

output "out_privatesubnet3" {
  value = aws_subnet.privatesubnet3.id
}


resource "aws_subnet" "privatesubnet4" {

  vpc_id            = aws_vpc.vpc_build.id
  cidr_block        = var.private_subnet_4
  availability_zone = var.availability_zone_B

  tags = {
    Name = "Private Subnet-4"

  }

}

output "out_privatesubnet4" {
  value = aws_subnet.privatesubnet4.id
}




resource "aws_db_subnet_group" "rdsubnetgroup" {

  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.privatesubnet3.id, aws_subnet.privatesubnet4.id]

  tags = {

    name = "RDS Subnet Group"
  }

}

output "out_rdssubnetgroup" {
  value = aws_db_subnet_group.rdsubnetgroup.id
}