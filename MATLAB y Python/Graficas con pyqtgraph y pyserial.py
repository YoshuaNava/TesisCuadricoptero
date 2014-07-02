# -*- coding: utf-8 -*-

"""import pyqtgraph.examples

pyqtgraph.examples.run()"""

import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import serial

app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Basic plotting examples")
win.resize(1000,600)
win.setWindowTitle('pyqtgraph example: Plotting')

puerto=serial.Serial("/dev/ttyUSB0",115200)
puerto.flush()

grafica = win.addPlot(title="Sensor de altura")
limiteDatos = 500
x = np.arange(limiteDatos)
y = np.arange(limiteDatos)*0
grafica.setYRange(0,300)
curve = grafica.plot(x,y)
i = 0

def EsNumero(numero):
    try:
        float(numero)
        return True
    except Exception:
        return False

def update():
    global curve, i, grafica, timer
    if (i<limiteDatos):
        dato = puerto.readline()
        puerto.flush()
        if(EsNumero(dato)):
            y[i] = dato
            curve.setData(y)
        else:
            print dato
        i += 1
    else:
        print 'hola'
        timer.stop()
        exit()

timer = QtCore.QTimer()
timer.timeout.connect(update)
timer.start(1)
