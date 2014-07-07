# -*- coding: utf-8 -*-
import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import serial

app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Datos de los sensores")
#win.setWindowFlags(QtCore.Qt.WindowStaysOnTopHint)
win.resize(1300,700)
win.setWindowTitle('Datos de los sensores')

puerto=serial.Serial("/dev/ttyUSB0",115200)
puerto.flushInput()

#puerto.write('T')
#puerto.write('T')
#puerto.write('T')


limiteDatos = 2500
x = np.arange(limiteDatos)
yaw = np.arange(limiteDatos)*0
pitch = np.arange(limiteDatos)*0
roll = np.arange(limiteDatos)*0
D = np.arange(limiteDatos)*0

graficaYaw = win.addPlot(title="Yaw")
graficaPitch = win.addPlot(title="Pitch")
graficaRoll = win.addPlot(title="Roll")

graficaYaw.setYRange(-90,90)
graficaPitch.setYRange(-90,90)
graficaRoll.setYRange(-90,90)

curvaYaw = graficaYaw.plot(x,yaw, pen = pg.mkPen('r', width=2))
curvaPitch = graficaPitch.plot(x,pitch, pen = pg.mkPen('y', width=2))
curvaRoll = graficaRoll.plot(x,roll, pen = pg.mkPen('b', width=2))

graficaPitch.plot(x,D, pen = pg.mkPen('g', width=3))
graficaRoll.plot(x,D, pen = pg.mkPen('g', width=3))
graficaYaw.plot(x,D, pen = pg.mkPen('g', width=3))

i = 0
j = 0
k = 0



def EsNumero(numero):
    try:
        float(numero)
        return True
    except Exception:
        return False

def updateYaw():
    global curvaYaw, k, timerYaw, limiteDatos, yaw
    if (k<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == 'Y'):
                print "Yaw"
                yaw[k] = dato

            curvaYaw.setData(yaw)
            k += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerYaw.stop()
        #exit()


def updatePitch():
    global curvaPitch, i, timerPitch, limiteDatos, pitch
    if (i<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == 'P'):
                print "Pitch"
                pitch[i] = dato

            curvaPitch.setData(pitch)
            i += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerPitch.stop()
        #exit()



def updateRoll():
    global curvaRoll, j, timerRoll, limiteDatos, roll
    if (j<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == "R"):
                print "Roll"
                roll[j] = dato

            curvaRoll.setData(roll)
            j += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerRoll.stop()
        #exit()


timerYaw = QtCore.QTimer()
timerYaw.timeout.connect(updateYaw)
timerYaw.start(1)

timerPitch = QtCore.QTimer()
timerPitch.timeout.connect(updatePitch)
timerPitch.start(1)

timerRoll = QtCore.QTimer()
timerRoll.timeout.connect(updateRoll)
timerRoll.start(1)

