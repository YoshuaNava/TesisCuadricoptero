# -*- coding: utf-8 -*-

"""import pyqtgraph.examples

pyqtgraph.examples.run()"""

import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import serial

app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Altura")
win.resize(1000,600)
win.setWindowTitle('pyqtgraph example: Plotting')

puerto=serial.Serial("/dev/ttyUSB0",115200)
puerto.flush()

grafica = win.addPlot(title="Sensor de altura")
limiteDatos = 500
x = np.arange(limiteDatos)
y = np.arange(limiteDatos)*0
Z = np.arange(limiteDatos)*0
grafica.setYRange(0,100)
curva1 = grafica.plot(x,y, pen = pg.mkPen('y', width=2))
curva2 = grafica.plot(x,Z, pen = pg.mkPen('b', width=2))
i = 0

q = 0.1 #Covarianza del ruido del proceso fisico
r = 10.0 #Covarianza del ruido del sensor
z = 0.0 #Prediccion
p = 3.0 #Covarianza del ruido de la estimacion
k = 0.0 #Ganancia de Kalman

def FiltroKalman(valor):
    global q, r, z, p, k
    p = p + q
    k = p/(p+r)
    z = z + k*(valor - z)
    p = (1-k)*p
    
    return z


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
        #puerto.flush()
        if(EsNumero(dato)):
            y[i] = dato
            Z[i] = FiltroKalman(float(dato))
            curva1.setData(y)
            curva2.setData(Z)

        i += 1
    else:
        print 'Terminado'
        timer.stop()
        exit()

timer = QtCore.QTimer()
timer.timeout.connect(update)
timer.start(1)
