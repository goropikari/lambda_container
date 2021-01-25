FROM public.ecr.aws/lambda/provided:al2

COPY bootstrap /$LAMBDA_RUNTIME_DIR/bootstrap
COPY main.sh $LAMBDA_RUNTIME_DIR/

CMD ["main.sh"]
