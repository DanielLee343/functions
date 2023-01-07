import numpy as np
from time import time
import json
import sys
# import mkl
# import os

# mkl.set_num_threads(1)

def matmul(n):
    A = np.random.rand(n, n)
    B = np.random.rand(n, n)

    start = time()
    C = np.matmul(A, B)
    latency = time() - start
    return latency

def main():
    # os.environ["OMP_NUM_THREADS"] = "3"
    n = int(sys.argv[1])
    result = matmul(n)
    print(result)
    return result

if __name__ == '__main__':
    main()