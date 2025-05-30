import numpy as np
import pandas as pd

def grad_f(x):
    x1, x2 = x
    df_dx1 = np.cos(x1) * np.cos(x2)
    df_dx2 = -np.sin(x1) * np.sin(x2)
    return np.array([df_dx1, df_dx2])

tau = 1.0
x = np.array([1.0, 1.0])
iterates = [x.copy()]

for k in range(4):
    x = x - tau * grad_f(x)
    iterates.append(x.copy())

df = pd.DataFrame(iterates[1:], columns=['x1', 'x2'], index=[f'k={i}' for i in range(1,5)])
print(df)