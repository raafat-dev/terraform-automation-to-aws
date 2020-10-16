
#create VPC  + Subnets + internet gateway

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_prefix}.0.0/16"
  enable_dns_hostnames = true
  tags = {
      Name = "${var.vpc_cidr_prefix}-vpc"
    }

}

resource "aws_subnet" "pub_a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.vpc_cidr_prefix}.1.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
      Name = "${var.vpc_cidr_prefix}.1-pub-a"
    }

}

resource "aws_subnet" "pub_b" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.vpc_cidr_prefix}.2.0/24"
  availability_zone = "${var.aws_region}b"
  tags = {
      Name = "${var.vpc_cidr_prefix}.2-pub-a"
    }

}

resource "aws_subnet" "priv_a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.vpc_cidr_prefix}.3.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
      Name = "${var.vpc_cidr_prefix}.3-priv-a"
    }

}

resource "aws_subnet" "priv_b" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.vpc_cidr_prefix}.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
   Name = "${var.vpc_cidr_prefix}.4-priv-b"
 }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
     Name = "${var.vpc_cidr_prefix}-igw"
   }

}

resource "aws_route_table" "pub" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
     Name = "${var.vpc_cidr_prefix}-pub"
   }
}

resource "aws_route_table_association" "pub_a" {
  subnet_id      = "${aws_subnet.pub_a.id}"
  route_table_id = "${aws_route_table.pub.id}"
}

resource "aws_route_table_association" "pub_b" {
  subnet_id      = "${aws_subnet.pub_b.id}"
  route_table_id = "${aws_route_table.pub.id}"
}
