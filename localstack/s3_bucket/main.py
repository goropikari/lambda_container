import os
import boto3

AWS_ENDPOINT_URL = os.getenv("AWS_ENDPOINT_URL", None)

def handler(event, context):
    client = boto3.client("s3", endpoint_url=AWS_ENDPOINT_URL)
    client.create_bucket(Bucket="foo")
    client.create_bucket(Bucket="bar")
    buckets = client.list_buckets()["Buckets"]
    l = []
    for bucket in buckets:
        l.append(bucket["Name"])
    return str(l)
