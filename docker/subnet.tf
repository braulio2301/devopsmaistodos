# Criação de uma Internet Gateway
resource "aws_internet_gateway" "maistodos_igw" {
  vpc_id = "vpc-0119ebcc028e40dea"

  tags = {
    Name = "maistodos-igw"
  }
}

# Associação do Internet Gateway às subnets
resource "aws_route_table" "public" {
  vpc_id = "vpc-0119ebcc028e40dea"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.maistodos_igw.id
  }
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = "subnet-071d033f946f83961"
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = "subnet-0d63334f55030140e"  # Substitua pelo ID da sua subnet
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "maistodos_rt" {
  vpc_id = "vpc-0119ebcc028e40dea"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.maistodos_igw.id
  }
}

#SUBNET RDS
resource "aws_db_subnet_group" "maistodos" {
  name        = "maistodos-db-subnet-group"
  subnet_ids  = [
    "subnet-071d033f946f83961",
    "subnet-0d63334f55030140e"
  ]  
  description = "rdsmaistodos"
}