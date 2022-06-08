#!/usr/bin/env python3

import matplotlib.pyplot as plt
import numpy as np
import math

xc = np.linspace(-5,5,100)
c1 = (1.0/2)*(xc-3)+math.sqrt(3)
c2 = -(1.0/2)*(xc-3)+math.sqrt(3)

x2 = np.linspace(-5,5,100)
y2 = x2**(1.0/2)

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)
plt.axis('equal')
plt.plot(xc, c1, 'b')
plt.plot(xc, c2, 'b')
plt.plot(x2, y2, 'r')

plt.show()

