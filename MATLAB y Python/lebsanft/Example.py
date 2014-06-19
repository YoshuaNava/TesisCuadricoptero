# -*- coding: utf-8 -*-
"""
Created on Wed Jun 18 20:06:00 2014

@author: alfredoso
"""

import serial
import numpy as np
from matplotlib import pyplot as plt
ser = serial.Serial('/dev/ttyUSB2', 9600)
 
plt.ion() # set plot to animated
 
ydata = [0] * 50
ax1=plt.axes()  
 
# make plot
line, = plt.plot(ydata)
plt.ylim([10,40])
plt.draw() # update the plot
 
# start data collection
while True:  
    data = ser.readline().rstrip() # read data from serial 
                                   # port and strip line endings
    if len(data.split(".")) == 2:
        #ymin = float(min(ydata))-10
        #ymax = float(max(ydata))+10
        #plt.ylim([ymin,ymax])
        ydata.append(data)
        del ydata[0]
        line.set_xdata(np.arange(len(ydata)))
        line.set_ydata(ydata)  # update the data
        plt.draw() # update the plot