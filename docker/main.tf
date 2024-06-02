provider "aws" {
  region = "us-east-2"
}

#CRIACAO-DO-REPOSITORIO
resource "aws_ecr_repository" "my_ecr_repository" {
  name = "maistodos-repo"
}

#CRIACAO-DO-CLUSTER
resource "aws_ecs_cluster" "my_cluster" {
  name = "cluster_maistodos"
}

#CRIACAO-DO-TASK-DEFINITION
resource "aws_ecs_task_definition" "my_task_maistodos" {
  family                   = "my-task-def"
  container_definitions    = jsonencode([{
    name                    = "maistodos-container"
    image                   = "${aws_ecr_repository.my_ecr_repository.repository_url}:1.0"
    essential               = true
    portMappings            = [{
      containerPort         = 3000
      hostPort              = 3000
      protocol              = "tcp"
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"

}

# Declaração do recurso aws_subnet.private
resource "aws_subnet" "private" {
  vpc_id            = "vpc-0119ebcc028e40dea"   # ID da sua VPC existente
  cidr_block        = "10.0.0.0/24"    # Bloco CIDR da sub-rede
  availability_zone = "us-east-2a"     # Zona de disponibilidade
  depends_on = [aws_vpc.maistodos_vpc]


  tags = {
    Name = "PrivateSubnet"  # Nome da sub-rede
  }
}

# Declaração do recurso aws_subnet.private
resource "aws_subnet" "maistodos_subnet" {
  vpc_id            = "vpc-0119ebcc028e40dea"   # ID da sua VPC existente
  cidr_block        = "10.0.1.0/24"    # Bloco CIDR da sub-rede
  availability_zone = "us-east-2c"     # Zona de disponibilidade
  depends_on = [aws_vpc.maistodos_vpc]


  tags = {
    Name = "PrivateSubnet"  # Nome da sub-rede
  }
}


# Criação da VPC
resource "aws_vpc" "maistodos_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "maistodos_vpc"
  }
}