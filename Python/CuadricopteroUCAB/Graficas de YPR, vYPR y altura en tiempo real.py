# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-
import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import serial

app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Datos de los sensores")
#win.setWindowFlags(QtCore.Qt.WindowStaysOnTopHint)
win.resize(1200,700)
win.setWindowTitle('Datos de los sensores')

puerto=serial.Serial("/dev/ttyUSB0",115200)
puerto.flushInput()
#ToDo: Deberiamos atrapar SerialException


puerto.write('T')
puerto.write('T')
puerto.write('T')
puerto.write('T')
puerto.write('T')


limiteDatos = 250
x = np.arange(limiteDatos)
D = np.arange(limiteDatos)*0



yaw = np.arange(limiteDatos)*0  
graficaYaw = win.addPlot(title="Yaw")
graficaYaw.setYRange(-90,90)
curvaYaw = graficaYaw.plot(x,yaw, pen = pg.mkPen('r', width=2))
k = 0



pitch = np.arange(limiteDatos)*0
graficaPitch = win.addPlot(title="Pitch")
graficaPitch.setYRange(-90,90)
curvaPitch = graficaPitch.plot(x,pitch, pen = pg.mkPen('y', width=2))
i = 0



roll = np.arange(limiteDatos)*0
graficaRoll = win.addPlot(title="Roll")
graficaRoll.setYRange(-90,90)
curvaRoll = graficaRoll.plot(x,roll, pen = pg.mkPen('b', width=2))
j = 0



Vyaw = np.arange(limiteDatos)*0  
graficaVYaw = win.addPlot(title="vYaw")
graficaVYaw.setYRange(-90,90)
curvaVYaw = graficaVYaw.plot(x,Vyaw, pen = pg.mkPen('r', width=2))
graficaVYaw.plot(x,D, pen = pg.mkPen('g', width=3))
l = 0



Vpitch = np.arange(limiteDatos)*0
graficaVPitch = win.addPlot(title="vPitch")
graficaVPitch.setYRange(-90,90)
curvaVPitch = graficaVPitch.plot(x,Vpitch, pen = pg.mkPen('y', width=2))
graficaVPitch.plot(x,D, pen = pg.mkPen('g', width=3))
m = 0



Vroll = np.arange(limiteDatos)*0
graficaVRoll = win.addPlot(title="vRoll")
graficaVRoll.setYRange(-90,90)
curvaVRoll = graficaVRoll.plot(x,Vroll, pen = pg.mkPen('b', width=2))
graficaVRoll.plot(x,D, pen = pg.mkPen('g', width=3))
n = 0



Altura = np.arange(limiteDatos)*0
graficaAltura = win.addPlot(title="Altura")
graficaAltura.setYRange(0,150)
curvaAltura = graficaAltura.plot(x,Altura, pen = pg.mkPen('w', width=2))
o = 0


def EsNumero(numero):
    try:
        float(numero)
        return True
    except Exception:
        return False


def updateYaw():
    global curvaYaw, timerYaw, limiteDatos, yaw, k
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
    global curvaPitch, timerPitch, limiteDatos, pitch, i
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
    global curvaRoll, timerRoll, limiteDatos, roll, j
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



def updateVYaw():
    global curvaVYaw, timerVYaw, limiteDatos, Vyaw, l
    if (l<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == 'y'):
                print "vYaw"
                Vyaw[l] = dato
                curvaVYaw.setData(Vyaw)
                l += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerVYaw.stop()
        #exit()


def updateVPitch():
    global curvaVPitch, timerVPitch, limiteDatos, Vpitch, m
    if (m<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == 'p'):
                print "vPitch"
                Vpitch[m] = dato
                curvaVPitch.setData(Vpitch)
                m += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerVPitch.stop()
        #exit()



def updateVRoll():
    global curvaVRoll, timerVRoll, limiteDatos, Vroll, n
    if (n<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == "r"):
                print "Roll"
                Vroll[n] = dato
                curvaVRoll.setData(Vroll)
                n += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerVRoll.stop()
        #exit()
        
def updateAltura():
    global curvaAltura, timerAltura, limiteDatos, Altura, o
    if (o<limiteDatos):
        entrada = puerto.readline()
        entrada = list(entrada)
        codigo = entrada[0]
        if(EsNumero(codigo)):
            entrada = puerto.readline()
            entrada = list(entrada)
            codigo = entrada[0]
            
        dato = puerto.readline()
        if(EsNumero(dato)):
            if (codigo == "A"):
                print "Altura"
                Altura[o] = dato
                curvaAltura.setData(Altura)
                o += 1
    else:
        print 'Terminado'
        puerto.write('Z')
        timerAltura.stop()
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

timerVYaw = QtCore.QTimer()
timerVYaw.timeout.connect(updateVYaw)
timerVYaw.start(1)

timerVPitch = QtCore.QTimer()
timerVPitch.timeout.connect(updateVPitch)
timerVPitch.start(1)

timerVRoll = QtCore.QTimer()
timerVRoll.timeout.connect(updateVRoll)
timerVRoll.start(1)

timerAltura = QtCore.QTimer()
timerAltura.timeout.connect(updateAltura)
timerAltura.start(1)
