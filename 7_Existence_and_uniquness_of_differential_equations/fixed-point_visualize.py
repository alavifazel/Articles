import matplotlib.pyplot as plt
import numpy as np
import math

x1 = np.linspace(-5,5,100)
y1 = x1**2

x2 = np.linspace(-5,5,100)
y2 = x2

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
plt.axis('equal')
plt.plot(x1, y1, 'r')
plt.plot(x2, y2, 'b')


plt.show()
