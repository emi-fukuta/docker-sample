### Deploy to the Development Server(temporary)

```
$ cd docker/development
$ docker-compose build

# please set up your AWS profile in advance
$ `aws --profile zdc ecr get-login --no-include-email --region ap-northeast-1`

$ docker tag development_nginx:latest 941753362233.dkr.ecr.ap-northeast-1.amazonaws.com/itsumo-print-dev-nginx:latest
$ docker tag development_php-fpm:latest 941753362233.dkr.ecr.ap-northeast-1.amazonaws.com/itsumo-print-dev-php-fpm:latest

$ docker push 941753362233.dkr.ecr.ap-northeast-1.amazonaws.com/itsumo-print-dev-nginx:latest
$ docker push 941753362233.dkr.ecr.ap-northeast-1.amazonaws.com/itsumo-print-dev-php-fpm:latest

# the task recreate
$ aws --profile zdc $(aws ecs list-tasks --cluster itsumo-print-dev-ecs-cluster-web --service itsumo-print-dev-ecs-cluster-web | jq -r .taskArns[])
$ aws ecs stop-task --cluster itsumo-print-dev-ecs-cluster-web --task ${current_task}
```

