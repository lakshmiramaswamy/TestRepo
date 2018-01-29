# aws credentials details

provider "aws" {
region = "${var.region}"
}

# the resource to create VPC

resource "aws_vpc" "vpc" {
  cidr_block  = "${var.vpc_cidr}"
  instance_tenancy = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"
  tags = "${merge(var.tags, map("Name", format("%s-vpc", var.name)))}"

}

# the resource to create public subnets in  VPC

 resource "aws_subnet" "public_subnet" {
  count = "${length(var.public_subnet)}"
  vpc_id   = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnet[count.index]}"
  map_public_ip_on_launch = true
  tags = "${merge(var.tags, var.public_subnet_tags, map("Name", format("subnet-public")))}"

}

# the resource to create private subnets in Management VPC

 resource "aws_subnet" "private_subnet" {
  count = "${length(var.private_subnet)}"
  vpc_id   = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private_subnet[count.index]}"
  tags = "${merge(var.tags, var.private_subnet_tags, map("Name", format("subnet-private")))}"
}


# the resource to create an internet gateway for Management VPC

resource "aws_internet_gateway" "igw" {
  #count = "${length(var.public_subnet) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

# the resource to create the public route table in Management VPC

resource "aws_route_table" "publicrt" {
  #count = "${length(var.public_subnet) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.Abbive_vpc.id}"
  tags = "${merge(var.tags, map("Name", format("%s-routetable-public", var.name)))}"
}

# the resource to create the private route table in Management VPC

resource "aws_route_table" "Abbive_privatert" {
  count = "${length(var.private_subnet) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.Abbive_vpc.id}"
  tags = "${merge(var.tags, map("Name", format("%s-Abbive-routetable-private", var.name)))}"
}

# Adding routes to the public route table

resource "aws_route" "Abbive_public_routes" {
  #count = "${length(var.public_subnet) > 0 ? 1 : 0}"
  route_table_id         = "${aws_route_table.Abbive_publicrt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.Abbive_igw.id}"
}

# Public Route Table Association

resource "aws_route_table_association" "Abbive_public" {
  count = "${length(var.public_subnet)}"
  subnet_id      = "${element(aws_subnet.Abbive_public_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.Abbive_publicrt.*.id, count.index)}"
}

 # Private Route Table Association
 resource "aws_route_table_association" "Abbive_private" {
  count = "${length(var.private_subnet)}"
  subnet_id      = "${element(aws_subnet.Abbive_private_subnet.*.id, count.index)}"

  route_table_id = "${element(aws_route_table.Abbive_privatert.*.id, count.index)}"

}

