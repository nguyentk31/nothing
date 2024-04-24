# Find All Availability Zones 
data "aws_availability_zones" "azs" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Main VPC
resource "aws_vpc" "main-pc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project}-${var.environment}-VPC"
    Project     = var.project
    Environment = var.environment
  }
}

# Subnet expand network bit by 5 (like from /16 to /21)
# Public Subnets
resource "aws_subnet" "public-subnets" {
  count                   = var.number_public_subnets_per_az * data.aws_availability_zones.azs
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 5, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs)]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-PublicSubnet-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
  }
}

# Private Subnets
resource "aws_subnet" "private-subnets" {
  count             = var.number_private_subnets_per_az * data.aws_availability_zones.azs
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 5, count.index + var.number_public_subnets_per_az)
  availability_zone = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs)]

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-PrivateSubnet-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
  }
}

# Internet gateway, elastic ip and attach to nat gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-InternetGateway"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_eip" "natgw-eip" {
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-ElasticIP"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat_gws" {
  count         = var.number_nat_gateways
  allocation_id = aws_eip.natgw-eip.id
  subnet_id     = aws_subnet.public-subnets[count.index].id // The first public subnet

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-NatGateway"
    Project     = var.project
    Environment = var.environment
  }
}

# Route tables and associations
# Public route tables
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-PublicRouteTable"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route_table_association" "pub-rt-association" {
  count          = length(aws_subnet.public-subnets)
  route_table_id = aws_route_table.pub-rt.id
  subnet_id      = aws_subnet.public-subnets[count].id
}

# Private route tables
resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name        = "${aws_vpc.main-pc.tags.Name}-PrivateRouteTable"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route_table_association" "pri-rt-association" {
  count          = length(aws_subnet.private-subnets)
  route_table_id = aws_route_table.pri-rt.id
  subnet_id      = aws_subnet.private-subnets[count].id
}