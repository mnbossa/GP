import numpy as np

def rbf(length_scale):
    def k(x,y):
        if len(x.shape)==1:
            d = 1
        else:
            d  = x.shape[1]
        lx = x.shape[0]
        ly = y.shape[0]
        dists =  np.sum(((x.T.reshape([d,lx,1]) -  y.T.reshape([d,1,ly]))/length_scale)**2,0)
        return np.exp(-.5 * dists)
    return k

def genSamplesSimple(x, k):
    n = x.shape[0]
    return np.random.multivariate_normal(np.zeros(n), k(x,x) + np.eye(n)*1e-8)

# def gesnSamplePostSimple(y,x,k,X):

# def gesnSamplePostSimple(y,x,k,X):

