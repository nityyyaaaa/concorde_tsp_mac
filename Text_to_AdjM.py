
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
import math 


# In[2]:


def get_coordinates(df, i): 
    parsed = [float(x) for x in df[0][i].split()]
    return((parsed[0], parsed[1]))


# In[15]:


df1 = pd.read_fwf("network1.txt", header = None)
coord1 = []

def make_coord_df(df):
    coord1 = np.empty((len(df),2))
    i = 0
    while i < len(df):                              
        x = get_coordinates(df,i)[0]
        y = get_coordinates(df,i)[1]
        coord1[i][0] = x
        coord1[i][1] = y
        i += 1
    return coord1
    
net1_coords = make_coord_df(df1)
pd.DataFrame(net1_coords).to_csv("net1_coords.csv")


# In[16]:


def euclidean(a, b): 
    dist = (np.sqrt( math.pow(a[0] - b[0], 2) + math.pow(a[1] - b[1], 2)))
    if math.isnan(dist) : 
        print (a,b)
    return dist


# In[17]:


def text_to_adjm(txt): 
    #Loading df 
    df = pd.read_fwf(txt, header=None)
    # Creating an empty n x n matrix
    empty = np.empty((len(df),len(df)))
    # Create Adjacency Matrix 
    for i in range(len(df)):
        parsed = [float(x) for x in df[0][i].split()]
        for j in parsed[2:]:
            empty[i][int(j)] = euclidean(get_coordinates(df,i), get_coordinates(df,j))   
    for i in range(len(df)): 
        for j in range(len(df)): 
            if empty[i][j] < 0.00000000000000000001:
                empty[i][j] = 0
    return(empty)


# In[30]:


net1 = text_to_adjm("network1.txt") #100
net2 = text_to_adjm("network2.txt") #500
net3 = text_to_adjm("network3.txt") #1000
net4 = text_to_adjm("network4.txt") #1000
net5 = text_to_adjm("network5.txt") #5000


# In[31]:


pd.DataFrame(net1).to_csv("net1.csv")
pd.DataFrame(net2).to_csv("net2.csv")
pd.DataFrame(net3).to_csv("net3.csv")
pd.DataFrame(net4).to_csv("net4.csv")
pd.DataFrame(net5).to_csv("net5.csv")


# In[29]:


net1[0]

