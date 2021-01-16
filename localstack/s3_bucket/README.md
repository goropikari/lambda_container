# AWS Lambda with Container Image

```bash
$ docker-compose build
$ docker-compose up
$ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
#=> "['foo', 'bar']"
```

ref: https://docs.aws.amazon.com/lambda/latest/dg/images-test.html
