import numpy as np

input_dim = 1000
target_dim = 10

dimensions = [input_dim+1, 500, 500, target_dim+1]

weight_matrices = []
for i in range(len(dimensions)-1):
  weight_matrix = np.ones((dimensions[i], dimensions[i]))
  weight_matrices.append(weight_matrix)
  
def activate_network(inputs):
  activations = [] # we store the activations for each layer here
  a = np.ones((inputs.shape[0], inputs.shape[1]+1)) #add the bias to the inputs
  a[:,:-1] = inputs

  for w in weight_matrices:
    x = a.dot(w) # sum of weighted inputs
    a = 1. / (1. - np.exp(-x)) # apply logistic sigmoid activation
    a[:,-1] = 1. # bias for the next layer.
    activations.append(a)

  return activations
