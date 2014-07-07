# -*- coding: utf-8 -*-

import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import FuncionesComunes as Comun



puertoSerial = None
limiteDatos = 500
curva = None
numDatosRecibidos = 0
x = np.arange(limiteDatos)
y = np.arange(limiteDatos)*0
timer = None
grafica = None


def Ejecutar(paramPuertoSerial):
    global puertoSerial, grafica, curva, limiteDatos, x, y, timer
    puertoSerial = paramPuertoSerial
    app = QtGui.QApplication([])
    win = pg.GraphicsWindow(title="Velocidad angular")
    win.resize(1000,600)
    win.setWindowTitle('Velocidad angular')

    puertoSerial.flushInput()
    grafica = win.addPlot(title="Velocidad angular")
    grafica.setYRange(-90,90)
    curva = grafica.plot(x,y)
    timer = QtCore.QTimer()
    timer.timeout.connect(update)
    timer.start(1)    


def update():
    print "hola"
    global curva, x, y, timer, puertoSerial, numDatosRecibidos, limiteDatos
    if (numDatosRecibidos < limiteDatos):
        dato = puertoSerial.readline()
        puertoSerial.flushInput()
        if(Comun.EsNumero(dato)):
            y[numDatosRecibidos] = dato
            curva.setData(y)
        else:
            print dato
        numDatosRecibidos += 1
    else:
        print 'hola'
        timer.stop()
        exit()
    





