# ESN_MackeyGlassData

Simulation of chaotic time series prediction using Echo State Network (ESN) approach. The Mackey-Glass system is used in this simulation and the system performance is examined by a normalized root mean squared error metric computed over 84 continued time steps after training (i.e. NRMSE84)

The main.m file will gather other files to run in the following order
- Generating Mackey-Glass data
- Generating ESN
- Training the ESN model
- Generating testing Mackey-Glass data
- Computing NRMSE84 using testing data and trained network
- Plotting free running continuation of the trained network
