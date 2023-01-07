import numpy as np
from time import time
import json

def matmul(n):
    A = np.random.rand(n, n)
    B = np.random.rand(n, n)

    start = time()
    C = np.matmul(A, B)
    latency = time() - start
    return latency


def handle(event):
    payload = json.loads(event)
    n = int(payload['n'])
    result = matmul(n)
    print(result)
    return result