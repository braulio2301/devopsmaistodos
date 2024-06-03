REFERÊNCIAS:

https://snehalchaure.medium.com/deploy-a-dockerised-app-on-amazon-elastic-container-service-ecs-using-terraform-e7c92d9814ee

https://blog.devops.dev/deploying-docker-image-on-aws-ecs-infrastructure-automation-using-terraform-a-step-by-step-guide-23e17e5ced76

FERRAMENTAS UTILIZADA:

Git Bash, Visual Studio Code, Docker, WSL, Terraform.




Desafio técnico SRE

Link do repositório: https://github.com/braulio2301/devopsmaistodos/tree/main

Desafios e solução.

Durante o desenvolvimento dos requisitos para o cumprimento do desafio, a primrira dificuldade que eu tive foi criado por mim mesmo. Como não tinha a disposição uma maquina com linux SO instalado, me preocupei em formatar um equipamento Windows que eu tinha ao invés de focar nos desafios já presentes no requisito técnico.
Após superar esse primeiro impedimento iniciei a criação da infra pelo cluster ECS seguido do repositório.

Na segunda etapa doprojeto, iniciei a criação de uma imagem docker e a enviei para o repositório ECR
$ docker image ls
REPOSITORY                                                    TAG       IMAGE ID       CREATED      SIZE
870441406711.dkr.ecr.us-east-2.amazonaws.com/maistodos-repo   1.0       38b78e569580   4 days ago   156MB


Feito isso, criei uma task definition para executar o container com a imagem criada anteriormente a enviando como comando "docker push". 
A próxima etapa foi a criação do Load Balancer, SG, TG, VPC e em seguida a declaração desses recursos para garamtir a comunicação entre esses recursos.
Por fim foi feito a criação do rds e sua respectiva subnet em uma rede distinta.
