#CRIANDO O BANCO EM REDE DIFERENTE
resource "aws_db_instance" "maistodos-db" {
  identifier            = "maistodos-db"
  allocated_storage     = 20
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t3.micro"
  username              = "admin"
  password              = "maistodos010203"
  db_subnet_group_name  = "maistodos-db-subnet-group"
  publicly_accessible   = false
  storage_type          = "gp2"
  storage_encrypted     = false
  skip_final_snapshot   = true
}
