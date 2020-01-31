### Deploy to the Development Server(temporary)

```
$ cd docker/development
$ docker-compose build

# please set up your AWS profile in advance
$ `aws --profile {profile_name} ecr get-login --no-include-email --region ap-northeast-1`

$ docker tag development_nginx:latest xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/xxxx-nginx:latest
$ docker tag development_php-fpm:latest xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/xxxx-fpm:latest

$ docker push xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/xxxx-nginx:latest
$ docker push xxxxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/xxxx-fpm:latest

# the task recreate
$ aws --profile {profile_name} $(aws ecs list-tasks --cluster xxxx-ecs-cluster-web --service xxxx-cluster-web | jq -r .taskArns[])
$ aws ecs stop-task --cluster xxxx-ecs-cluster-web --task ${current_task}
```

