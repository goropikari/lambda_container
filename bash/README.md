```bash
$ docker build -t lambda_bash .
$ docker run --rm -p 9000:8080 lambda_bash
$ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
HelloWorldFromBash
```
