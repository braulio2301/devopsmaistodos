resource "aws_ecr_repository" "my_ecr_repository" {
  name = "maistodos-repo"
}

resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task-def"
  container_definitions    = jsonencode([{
    name                    = "container-maistodos"
    image                   = "${aws_ecr_repository.my_ecr_repository.repository_url}:1.0"
    essential               = true
    portMappings            = [{
      containerPort         = 3000
      hostPort              = 0
      protocol              = "tcp"
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
}