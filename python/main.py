N = 32

def fib(n):
    if n < 2:
        return n
    return fib(n-1) + fib(n-2)


def handler(event, context):
    return str(fib(N))


if __name__ == '__main__':
    fib(N)
