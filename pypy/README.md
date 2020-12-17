```bash
$ AWS_ACCOUNT=1234567890123
$ IMAGE_NAME=lambda_container
$ VERSION=pypy
$ docker build -t $IMAGE_NAME:$VERSION -f Dockerfile-python .
$ docker tag $IMAGE_NAME:$VERSION $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$IMAGE_NAME:$VERSION
$ docker push $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$IMAGE_NAME:$VERSION
$ aws lambda update-function-code --function-name $IMAGE_NAME --image-uri $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$IMAGE_NAME:$VERSION
```
