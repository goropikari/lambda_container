# AWS Lambda with Container Image

## environment

- awscli 2.1.11
- terraform v0.14.2
- terraform-provider-aws 3.21.0


Making resources except for lambda function. A lambda function needs an image which is maintained by ECR.

```
$ cd terraform
$ terraform apply
```


docker build & push

```bash
$ IMAGE_NAME=lambda_container
$ VERSION=v1
$ AWS_REGION=ap-northeast-1
$ cd python
$ aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNTS.dkr.ecr.$AWS_REGION.amazonaws.com
$ docker build -t $IMAGE_NAME .
$ docker tag $IMAGE_NAME:latest $AWS_ACCOUNTS.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$VERSION
$ docker push $AWS_ACCOUNTS.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$VERSION
```


Making a lambda function.
```
$ cd terraform
$ terraform apply
```

Invoke lambda function
```
$ aws lambda invoke --function-name lambda_container /dev/stderr > /dev/null
#=> "Hello World! v1"
```


Modifying the script `main.py` and updating lambda function.
```
$ IMAGE_NAME=lambda_container
$ VERSION v2
$ docker build -t $IMAGE_NAME .
$ docker tag $IMAGE_NAME:latest $AWS_ACCOUNTS.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$VERSION
$ docker push $AWS_ACCOUNTS.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$VERSION
$ aws lambda update-function-code --function-name $IMAGE_NAME --image-uri $AWS_ACCOUNTS.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$VERSION
```

Invoke lambda function
```
$ aws lambda invoke --function-name lambda_container /dev/stderr > /dev/null
#=> "Hello World! v2"
```


## Test at local

```
$ docker run --rm -p 9000:8080 $IMAGE_NAME
$ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
#=> "Hello World! v2"
```

ref: https://docs.aws.amazon.com/lambda/latest/dg/images-test.html
