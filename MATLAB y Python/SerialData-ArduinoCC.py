# -*- coding: utf-8 -*-
"""
Created on Wed Jun 18 20:10:52 2014

@author: alfredoso
"""

import serial

puertoSerial = serial.Serial('/dev/ttyUSB2',9600)
    
while True:
    print puertoSerial.readline()
        