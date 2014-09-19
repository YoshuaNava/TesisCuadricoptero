# -*- coding: utf-8 -*-
import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
from ModuloComunicacion import HiloSerial


app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Datos de los sensores")
#win.setWindowFlags(QtCore.Qt.WindowStaysOnTopHint)
win.resize(1300,700)
win.setWindowTitle('Datos de los sensores')


tasaBaudios = 38400
limiteDatos = 500
nombrePuertoSerial = "/dev/ttyUSB0"
hiloComunicacion = HiloSerial(None, limiteDatos, nombrePuerto = nombrePuertoSerial, tasaBaudios = tasaBaudios)
hiloComunicacion.start()

x = np.arange(limiteDatos)
yaw = np.arange(limiteDatos)*0  
pitch = np.arange(limiteDatos)*0
roll = np.arange(limiteDatos)*0
D = np.arange(limiteDatos)*0

graficaYaw = win.addPlot(title="Yaw")
graficaPitch = win.addPlot(title="Pitch")
graficaRoll = win.addPlot(title="Roll")

graficaYaw.setYRange(-180,180)
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



def updateYaw():
    global curvaYaw, k, timerYaw, limiteDatos, yaw, hiloComunicacion
    #yaw = hiloComunicacion.velocidadYaw
    yaw = hiloComunicacion.posicionYaw
    curvaYaw.setData(yaw)



def updatePitch():
    global curvaPitch, i, timerPitch, limiteDatos, pitch, hiloComunicacion
    #pitch = hiloComunicacion.velocidadPitch
    pitch = hiloComunicacion.posicionPitch
    curvaPitch.setData(pitch)



def updateRoll():
    global curvaRoll, j, timerRoll, limiteDatos, roll, hiloComunicacion
    #roll = hiloComunicacion.velocidadRoll 
    roll = hiloComunicacion.posicionRoll
    curvaRoll.setData(roll)


timerYaw = QtCore.QTimer()
timerYaw.timeout.connect(updateYaw)
timerYaw.start(0.5)

timerPitch = QtCore.QTimer()
timerPitch.timeout.connect(updatePitch)
timerPitch.start(0.5)

timerRoll = QtCore.QTimer()
timerRoll.timeout.connect(updateRoll)
timerRoll.start(0.5)



