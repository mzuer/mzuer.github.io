import pandas as pd
import numpy as np


#*************************************************************** pandas TUTORIAL - TUTORIALSPOINT
# Pandas data structures:
# 1) Series: 1D labeled homogeneous array, size-immutable.
# 2) DataFrame: general 2D labeled, size-mutable tabular structure with potentially heterogeneously-typed columns. 
# 3) Panel: general 3D labeled, size-mutable array (can be illustrated as a container of a DataFrame)

# Notes:
# - data frame: index (rows) and columns correspond to axis 0 and 1
# - all Pandas data structures are value mutable (can be changed) and except Series all are size mutable



#===================================================================
# 3) Panel
#===================================================================

############
# 3.a) Panel creation
############

# Panel can be created from 1) ndarrays, 2) dict of DataFrames

# creation from ndarrays

data = np.random.rand(2,4,5)
p = pd.Panel(data)
print(p)

# creation from dict of DataFrames
data = {'Item1' : pd.DataFrame(np.random.randn(4, 3)),
		'Item2' : pd.DataFrame(np.random.randn(4, 2))}
p = pd.Panel(data)
print(p)

############
# 3.b) Panel: data selection
############

# select data from panel using: 1) items, 2) Major_axis, 3) Minor_axis


# selection using item
data = {'Item1' : pd.DataFrame(np.random.randn(4, 3)),
		'Item2' : pd.DataFrame(np.random.randn(4, 2))}
p = pd.Panel(data)
print(p['Item1'])


# selection using major_axis or minor_axis
print(p.major_xs(1))
print(p.minor_xs(1))


############
# 3.c) Indexing and selecting
############
# p.loc[item_index,major_index,minor_index] => returns a DataFrame object
# .iloc() & .ix() applies the same indexing options and Return value.
















