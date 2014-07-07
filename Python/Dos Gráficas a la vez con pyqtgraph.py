# -*- coding: utf-8 -*-
import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import serial

app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Datos de los sensores")
win.resize(1000,600)
win.setWindowTitle('Datos de los sensores')

puerto=serial.Serial("/dev/ttyUSB0",115200)
puerto.flush()

#puerto.write('T')

grafica1 = win.addPlot(title="Pitch")
grafica2 = win.addPlot(title="Roll")
limiteDatos = 250
x = np.arange(limiteDatos)
y = np.arange(limiteDatos)*0
Z = np.arange(limiteDatos)*0
D = np.arange(limiteDatos)*0
grafica1.setYRange(-90,90)
grafica2.setYRange(-90,90)
curva1 = grafica1.plot(x,y, pen = pg.mkPen('y', width=2))
curva2 = grafica2.plot(x,Z, pen = pg.mkPen('b', width=2))
curva3 = grafica1.plot(x,D, pen = pg.mkPen('g', width=3))
curva4 = grafica2.plot(x,D, pen = pg.mkPen('g', width=3))
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
        codigo = puerto.readline()
        if(EsNumero(codigo)):
            codigo = puerto.readline()
            
        dato = puerto.readline()
        print "Recibido:"        
        print codigo
        print dato
        if(EsNumero(dato)):
            if (codigo == 'P'):
                y[i] = dato
            if (codigo == 'R'):
                Z[i] = dato

            curva1.setData(y)
            curva2.setData(Z)
            i += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timer.stop()
        exit()

timer = QtCore.QTimer()
timer.timeout.connect(update)
puerto.flush()
timer.start(1)
