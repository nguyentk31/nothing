# Find All Availability Zones 
data "aws_availability_zones" "uit" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Main VPC
resource "aws_vpc" "uit" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "${var.default_tags.Project}-${var.default_tags.Environment}-VPC"
  }
}

# Subnet expand network bit by 5 (like from /16 to /21)
# Public Subnets
resource "aws_subnet" "publics" {
  count                   = var.number_public_subnets_per_az * var.number_availability_zones
  vpc_id                  = aws_vpc.uit.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 5, count.index)
  availability_zone       = data.aws_availability_zones.uit.names[count.index % var.number_availability_zones]
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb" = 1
    Name                     = "${aws_vpc.uit.tags.Name}-PublicSubnet-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "privates" {
  count             = var.number_private_subnets_per_az * var.number_availability_zones
  vpc_id            = aws_vpc.uit.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 5, count.index + (var.number_public_subnets_per_az * var.number_availability_zones))
  availability_zone = data.aws_availability_zones.uit.names[count.index % var.number_availability_zones]

  tags = {
    "kubernetes.io/role/internal-elb" = 1
    Name                              = "${aws_vpc.uit.tags.Name}-PrivateSubnet-${count.index + 1}"
  }
}

# Internet gateway, elastic ip and attach to nat gateway
resource "aws_internet_gateway" "uit" {
  vpc_id = aws_vpc.uit.id

  tags = {
    Name = "${aws_vpc.uit.tags.Name}-InternetGateway"
  }
}

resource "aws_eip" "natgw-eips" {
  count      = var.number_nat_gateways
  depends_on = [aws_internet_gateway.uit]

  tags = {
    Name = "${aws_vpc.uit.tags.Name}-ElasticIP${count.index + 1}"
  }
}

resource "aws_nat_gateway" "natgws" {
  count         = var.number_nat_gateways
  allocation_id = aws_eip.natgw-eips[count.index].id
  subnet_id     = aws_subnet.publics[count.index].id // The first public subnet

  tags = {
    Name = "${aws_vpc.uit.tags.Name}-NatGateway${count.index + 1}"
  }
}

# Route tables and associations
# Public route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.uit.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.uit.id
  }

  tags = {
    Name = "${aws_vpc.uit.tags.Name}-PublicRouteTable"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.publics)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.publics[count.index].id
}

# Private route tables
resource "aws_route_table" "privates" {
  count  = var.number_nat_gateways
  vpc_id = aws_vpc.uit.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgws[count.index].id
  }

  tags = {
    Name = "${aws_vpc.uit.tags.Name}-PrivateRouteTable${count.index + 1}"
  }
}

resource "aws_route_table_association" "privates" {
  count          = length(aws_subnet.privates)
  route_table_id = aws_route_table.privates[count.index % var.number_nat_gateways].id
  subnet_id      = aws_subnet.privates[count.index].id
}
