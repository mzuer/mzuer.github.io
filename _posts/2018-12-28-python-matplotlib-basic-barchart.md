---
layout: post
title: "Python - <em>matplotlib</em> basic barchart (<em>plt.bar()</em>)"
date: 2018-12-28
category: python
tags: python matplotlib barchart
---


```
import numpy as np
import matplotlib.pyplot as plt

men_values = (20, 35, 30, 35, 27)
men_std = (0.1,0.2,0.1,0.2,0.1)
women_values = (25, 32, 34, 20, 25)
women_std = (0.1,0.2,0.1,0.2,0.1)

ind = np.arange(len(men_means))  # the x locations for the groups
width = 0.35  # the width of the bars



fig, ax = plt.subplots()
rects1 = ax.bar(x = ind-width/2, height = men_values, yerr=men_std, width=width,
                color='SkyBlue', label='Men')
rects2 = ax.bar(x= ind+width/2, height = women_values, yerr=women_std, width=width,
                color='IndianRed', label='Women')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_ylabel('Scores')
ax.set_title('Scores by group and gender')
ax.set_xticks(xpos)
ax.set_xticklabels(('G1', 'G2', 'G3', 'G4', 'G5'))
ax.legend()


plt.show()



```



