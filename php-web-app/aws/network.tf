# ECS Hands-on VPC
resource "aws_vpc" "ecs_handson" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "ecs-handson-vpc"
  }
}

# ECS Hands-on Internet Gateway
resource "aws_internet_gateway" "ecs_handson_igw" {
  vpc_id = aws_vpc.ecs_handson.id

  tags = {
    Name = "ecs-handson-igw"
  }
}

# ECS Hands-on Public Subnets
resource "aws_subnet" "ecs_handson_public_1a" {
  vpc_id                  = aws_vpc.ecs_handson.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "ecs-handson-subnet-public1-ap-northeast-1a"
  }
}

resource "aws_subnet" "ecs_handson_public_1c" {
  vpc_id                  = aws_vpc.ecs_handson.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "ecs-handson-subnet-public2-ap-northeast-1c"
  }
}

# ECS Hands-on Public Route Table
resource "aws_route_table" "ecs_handson_public" {
  vpc_id = aws_vpc.ecs_handson.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_handson_igw.id
  }

  tags = {
    Name = "ecs-handson-rtb-public"
  }
}

# Route Table Associations for ECS Hands-on VPC
resource "aws_route_table_association" "ecs_handson_public_1a" {
  subnet_id      = aws_subnet.ecs_handson_public_1a.id
  route_table_id = aws_route_table.ecs_handson_public.id
}

resource "aws_route_table_association" "ecs_handson_public_1c" {
  subnet_id      = aws_subnet.ecs_handson_public_1c.id
  route_table_id = aws_route_table.ecs_handson_public.id
}

# Main Route Table for ECS Hands-on VPC (デフォルトのメインルートテーブル)
resource "aws_default_route_table" "ecs_handson_main" {
  default_route_table_id = aws_vpc.ecs_handson.default_route_table_id

  tags = {
    Name = "ecs-handson-main-rt"
  }
}