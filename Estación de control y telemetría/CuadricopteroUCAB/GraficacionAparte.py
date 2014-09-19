# -*- coding: utf-8 -*-
import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore
import serial
import time
import numpy as np
from threading import Thread


class HiloSerial:
    def __init__(self, limiteDatos, nombrePuerto, tasaBaudios):
        self.__CODIGO_INICIO_MENSAJE = 255        
        self.__CODIGO_MENSAJE_ENCENDIDO = 0
        self.__CODIGO_MENSAJE_COMANDO = 1
        self.__CODIGO_MENSAJE_ACK_QR = 6
        self.__CODIGO_MENSAJE_ESTADO = 7
        
        self.limiteDatos = limiteDatos
        self.posicionYaw = np.arange(self.limiteDatos)*0
        self.posicionPitch = np.arange(self.limiteDatos)*0
        self.posicionRoll = np.arange(self.limiteDatos)*0
        self.velocidadYaw = np.arange(self.limiteDatos)*0
        self.velocidadPitch = np.arange(self.limiteDatos)*0
        self.velocidadRoll = np.arange(self.limiteDatos)*0
        self.altura = np.arange(self.limiteDatos)*0
        self.mensajesEstadoRecibidos = 0
        self.nombrePuerto = nombrePuerto
        self.tasaBaudios = tasaBaudios
                
        self.puertoSerial = serial.Serial(port=self.nombrePuerto, baudrate=self.tasaBaudios, timeout=0.05)
        self.puertoSerial.setDTR(False)
        time.sleep(0.5)
        self.detenerComunicacion = False        
        self.hilo = Thread(target=self.run)
        
    def start(self):
        self.detenerComunicacion = False
        if (self.hilo.isAlive() == False):
            self.hilo = Thread(target=self.run)
            self.hilo.start()


    def stop(self):
        #self.cerrarPuerto()
        self.detenerComunicacion = True

    def abrirPuerto(self):
        self.puertoSerial = serial.Serial(self.nombrePuerto, self.tasaBaudios)
    
        
    def cerrarPuerto(self):
        self.puertoSerial.close()
        
        
    def run(self):
        while (self.detenerComunicacion == False):
            self.recibirComandos()
            
            
    def enviarComandosMovimiento(self, comandoPitch, comandoRoll, comandoAltura):
        checksum = self.__CODIGO_INICIO_MENSAJE ^ self.__CODIGO_MENSAJE_COMANDO ^ int(comandoPitch) ^ int(comandoRoll) ^ comandoAltura
        paquete = chr(self.__CODIGO_INICIO_MENSAJE) + chr(self.__CODIGO_MENSAJE_COMANDO) + chr(int(comandoPitch)) + chr(int(comandoRoll)) + chr(int(comandoAltura)) + chr(checksum)
        self.puertoSerial.write(paquete)        
        """for i in range(6):
            print (ord(paquete[i]))"""
        

        
    def enviarComandoEncendido(self, comando):
        checksum = self.__CODIGO_INICIO_MENSAJE ^ self.__CODIGO_MENSAJE_ENCENDIDO ^ comando
        paquete = chr(self.__CODIGO_INICIO_MENSAJE) + chr(self.__CODIGO_MENSAJE_ENCENDIDO) + chr(comando) + chr(checksum)
        self.puertoSerial.write(paquete)
        self.mensajesEstadoRecibidos = 0
        """        for i in range(4):  
            print (ord(paquete[i]))"""

        
            
    def recibirComandos(self):
    #    serialport = AbrirPuerto()
    #    if (serialport.inWaiting() > 0)
        header = self.cardinalCaracter_Validar(self.puertoSerial.read())
        if (header == self.__CODIGO_INICIO_MENSAJE):
            comando = self.cardinalCaracter_Validar(self.puertoSerial.read())
            if (comando == self.__CODIGO_MENSAJE_ESTADO):
                P_posicionYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_posicionYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                posicionPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())                
                posicionRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velocidadYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velocidadYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velocidadPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velocidadPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velocidadRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velocidadRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                altura = self.cardinalCaracter_Validar(self.puertoSerial.read())
                checksum = self.cardinalCaracter_Validar(self.puertoSerial.read())
    
                if((header != None) and (comando != None) and (P_posicionYaw != None) and (posicionPitch != None) and (posicionRoll != None) and (P_velocidadYaw != None) and (P_velocidadPitch != None) and (P_velocidadRoll != None) and (N_posicionYaw != None) and (N_velocidadYaw != None) and (N_velocidadPitch != None) and (N_velocidadRoll != None) and (altura != None) and (checksum != None)):
                    if ((header ^ comando ^ P_posicionYaw ^ N_posicionYaw ^ posicionPitch ^ posicionRoll ^ P_velocidadYaw ^ N_velocidadYaw ^ P_velocidadPitch ^ N_velocidadPitch ^ P_velocidadRoll ^ N_velocidadRoll ^ altura) == checksum):
                        if (self.mensajesEstadoRecibidos + 1 >= self.limiteDatos):
                            self.mensajesEstadoRecibidos = 1
                            self.posicionYaw = np.arange(self.limiteDatos)*0
                            self.posicionPitch = np.arange(self.limiteDatos)*0
                            self.posicionRoll = np.arange(self.limiteDatos)*0
                            self.velocidadYaw = np.arange(self.limiteDatos)*0
                            self.velocidadPitch = np.arange(self.limiteDatos)*0
                            self.velocidadRoll = np.arange(self.limiteDatos)*0
                            self.altura = np.arange(self.limiteDatos)*0
                        else:
                            self.mensajesEstadoRecibidos = self.mensajesEstadoRecibidos + 1
                            
                        if (P_posicionYaw > 0):
                            self.posicionYaw[self.mensajesEstadoRecibidos] = P_posicionYaw
                        else:
                            self.posicionYaw[self.mensajesEstadoRecibidos] = - N_posicionYaw
                        
                        self.posicionPitch[self.mensajesEstadoRecibidos] = posicionPitch - 90
                        self.posicionRoll[self.mensajesEstadoRecibidos] = posicionRoll - 90

                        if (P_velocidadYaw > 0):
                            self.velocidadYaw[self.mensajesEstadoRecibidos] = P_velocidadYaw
                        else:
                            self.velocidadYaw[self.mensajesEstadoRecibidos] = - N_velocidadYaw
                        if (P_velocidadPitch > 0):
                            self.velocidadPitch[self.mensajesEstadoRecibidos] = P_velocidadPitch
                        else:
                            self.velocidadPitch[self.mensajesEstadoRecibidos] = - N_velocidadPitch
                        if (P_velocidadRoll > 0):
                            self.velocidadRoll[self.mensajesEstadoRecibidos] = P_velocidadRoll
                        else:
                            self.velocidadRoll[self.mensajesEstadoRecibidos] = - N_velocidadRoll
                        
                        self.altura[self.mensajesEstadoRecibidos] = altura

                        print "Estado del cuadricoptero:"
                        print "Angulo de Yaw = " + str(self.posicionYaw[self.mensajesEstadoRecibidos])
                        print "Angulo de Pitch = " + str(self.posicionPitch[self.mensajesEstadoRecibidos])
                        print "Angulo de Roll = " + str(self.posicionRoll[self.mensajesEstadoRecibidos])
                        print "Velocidad de Yaw = " + str(self.velocidadYaw[self.mensajesEstadoRecibidos])
                        print "Velocidad de Pitch = " + str(self.velocidadPitch[self.mensajesEstadoRecibidos])
                        print "Velocidad de Roll = " + str(self.velocidadRoll[self.mensajesEstadoRecibidos])
                        print "Altura = " + str(self.altura[self.mensajesEstadoRecibidos])
                        print "Mensajes recibidos = " + str(self.mensajesEstadoRecibidos)
                        print "\n"
                        
                        return True
                    else:
                        return False

            if (comando == self.__CODIGO_MENSAJE_ACK_QR):
                codigoACK = self.cardinalCaracter_Validar(self.puertoSerial.read())
                checksum = self.cardinalCaracter_Validar(self.puertoSerial.read())
                
                
                if ((header ^ comando ^ codigoACK) == checksum):
                    print "ACK DE ENCENDIDO/APAGADO!!!!!"
                    return True
                else:
                    return False            


    def cardinalCaracter_Validar(self, caracter):
        if(len(caracter) > 0):
            if((ord(caracter) >= 0) and (ord(caracter) <= 255)):
                return ord(caracter)
        else:
            return 1000










app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Datos de los sensores")
#win.setWindowFlags(QtCore.Qt.WindowStaysOnTopHint)
win.resize(1300,700)
win.setWindowTitle('Datos de los sensores')


tasaBaudios = 38400
limiteDatos = 500
nombrePuertoSerial = "/dev/ttyUSB0"
hiloComunicacion = HiloSerial(limiteDatos, nombrePuerto = nombrePuertoSerial, tasaBaudios = tasaBaudios)
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
    yaw = hiloComunicacion.velocidadYaw
    #yaw = hiloComunicacion.posicionYaw
    curvaYaw.setData(yaw)



def updatePitch():
    global curvaPitch, i, timerPitch, limiteDatos, pitch, hiloComunicacion
    pitch = hiloComunicacion.velocidadPitch
    #pitch = hiloComunicacion.posicionPitch
    curvaPitch.setData(pitch)



def updateRoll():
    global curvaRoll, j, timerRoll, limiteDatos, roll, hiloComunicacion
    roll = hiloComunicacion.velocidadRoll 
    #roll = hiloComunicacion.posicionRoll
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



