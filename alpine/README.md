```bash
$ curl -Lo aws-lambda-rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie
$ chmod +x aws-lambda-rie
$ docker build -t lambda_alpine .
$ docker run --rm -p 9000:8080 \
    -v $(pwd)/aws-lambda-rie:/aws-lambda-rie \
    --entrypoint="/aws-lambda-rie" \
    lambda_alpine /var/runtime/bootstrap main.sh
$ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d 'John';
HelloWorld:John
```

```
# Push image to ECR
$ aws lambda update-function-code --function-name <function_name> --image-uri <image_uri>:latest
$ aws lambda invoke --cli-binary-format raw-in-base64-out --function-name <function_name> --payload '"John"' /dev/stderr > /dev/null
HelloWorld:John
```


https://docs.aws.amazon.com/lambda/latest/dg/runtimes-walkthrough.html
