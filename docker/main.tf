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