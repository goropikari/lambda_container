FROM alpine:3.13.0

RUN apk add curl

ENV LAMBDA_RUNTIME_DIR=/var/runtime \
    LAMBDA_TASK_ROOT=/var/task

COPY bootstrap /$LAMBDA_RUNTIME_DIR/bootstrap
COPY main.sh $LAMBDA_TASK_ROOT/

WORKDIR $LAMBDA_TASK_ROOT

ENTRYPOINT ["$LAMBDA_RUNTIME_DIR/bootstrap"]
CMD ["main.sh"]
