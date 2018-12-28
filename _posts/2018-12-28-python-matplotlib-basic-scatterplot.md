---
layout: post
title: "Python - <em>matplotlib</em> basic scatterplot (<em>plt.scatter()</em>)"
date: 2018-12-28
category: python
tags: python matplotlib scatterplot
---


```
import matplotlib.pyplot as plt
import numpy as np

myx = np.arange(start = 0.0, stop = 5.0, step = 0.2)
myy = np.exp(myx)

myplot = plt.plot(myx,myy, 'ro') # 'ro' => red circle

plt.setp(myplot, markersize=30)
plt.setp(myplot, markerfacecolor='C0')

plt.show()

### Example 2: https://matplotlib.org/gallery/shapes_and_collections/scatter.html
# Fixing random state for reproducibility
np.random.seed(19680801)

N = 50
x = np.random.rand(N)
y = np.random.rand(N)
colors = np.random.rand(N)
area = (30 * np.random.rand(N))**2  # 0 to 15 point radii

plt.scatter(x, y, s=area, c=colors, alpha=0.5)
plt.show()


```



