# -*- coding: utf-8 -*-
"""
Created on Thu Aug  7 21:32:36 2014

@author: alfredoso
"""
import PyQt4.uic as uic
import pyqtgraph as pg
from pyqtgraph.Qt import QtCore, QtGui
import numpy as np
import os
import time
from ModuloComandos import HiloJoystick
from ModuloComunicacion import HiloSerial

pg.mkQApp()

rutaArchivos = os.path.dirname(os.path.abspath(__file__))
archivoUi = os.path.join(rutaArchivos, 'InterfazPrincipalQt.ui')
PlantillaVentana, ClaseBasePlantilla = uic.loadUiType(archivoUi)

class VentanaPrincipal(ClaseBasePlantilla):
    def __init__(self):
        ClaseBasePlantilla.__init__(self)
        self.setWindowTitle("Estación de Control")
        
        self.ui = PlantillaVentana()
        self.ui.setupUi(self)

        #Objetos plotItem, mediante ellos se actualizan las graficas.        
        self.plot_posPitch = self.ui.posicionPitchPlot.getPlotItem()
        self.plot_posRoll = self.ui.posicionRollPlot.getPlotItem()
        self.plot_posYaw = self.ui.posicionYawPlot.getPlotItem()        
        self.plot_velPitch = self.ui.velocidadPitchPlot.getPlotItem()
        self.plot_velRoll = self.ui.velocidadRollPlot.getPlotItem()
        self.plot_velYaw = self.ui.velocidadYawPlot.getPlotItem()
        self.plot_altura = self.ui.alturaPlot.getPlotItem()
        
        #Configuracion de las propiedades de las graficas.
        self.plot_posPitch.setYRange(-90,90)
        self.plot_posRoll.setYRange(-90,90)
        self.plot_posYaw.setYRange(-90,90)
        self.plot_velPitch.setYRange(-90,90)
        self.plot_velRoll.setYRange(-90,90)
        self.plot_velYaw.setYRange(-90,90)
        self.plot_altura.setYRange(0,150)
        self.plot_posPitch.showGrid(x=True, y=True, alpha=1.0)
        self.plot_posRoll.showGrid(x=True, y=True, alpha=1.0)
        self.plot_posYaw.showGrid(x=True, y=True, alpha=1.0)
        self.plot_velPitch.showGrid(x=True, y=True, alpha=1.0)
        self.plot_velRoll.showGrid(x=True, y=True, alpha=1.0)
        self.plot_velYaw.showGrid(x=True, y=True, alpha=1.0)
        self.plot_altura.showGrid(x=True, y=True, alpha=1.0)
        self.plot_posPitch.setTitle("Pitch (Grados)")
        self.plot_posRoll.setTitle("Roll (Grados)")
        self.plot_posYaw.setTitle("Yaw (Grados)")
        self.plot_velPitch.setTitle("Pitch (Grados/Segundo)")
        self.plot_velRoll.setTitle("Roll (Grados/Segundo)")
        self.plot_velYaw.setTitle("Yaw (Grados/Segundo)")
        self.plot_altura.setTitle("Altura (Centimetros)")

        #Variables para almacenar los valores que se graficaran
        self.mensajesEstadoRecibidos = 0
        self.limiteDatosGraficas = 300
        self.datosPosPitch = np.arange(self.limiteDatosGraficas)*0.0
        self.datosPosRoll = np.arange(self.limiteDatosGraficas)*0.0
        self.datosPosYaw = np.arange(self.limiteDatosGraficas)*0.0
        self.datosVelPitch = np.arange(self.limiteDatosGraficas)*0.0
        self.datosVelRoll = np.arange(self.limiteDatosGraficas)*0.0
        self.datosVelYaw = np.arange(self.limiteDatosGraficas)*0.0
        self.datosAltura = np.arange(self.limiteDatosGraficas)*0.0
        self.datosTiempoRecepcion = np.arange(self.limiteDatosGraficas)*0.0
        
        
        #Objetos para gestionar las acciones del usuario sobre los botones de la interfaz.
        self.botonIniciarCom = self.ui.pB_iniciarComunicacion
        self.botonDetenerCom = self.ui.pB_detenerComunicacion
        self.chBoxGraficarDatos = self.ui.chBox_graficarDatosSensores
        self.chBoxEnviarComandos = self.ui.chBox_enviarComandosJoystick
        
        
        #Por defecto se grafican los datos de los sensores.
        self.graficarDatos = True
        self.chBoxGraficarDatos.toggle()
        
        #Por defecto no se envian comandos desde el Joystick, para evitar accidentes al presionarlo inadvertidamente.
        self.enviarComandos = True
        self.chBoxEnviarComandos.toggle()
        
        #Manejadores de eventos para los botones.
        self.botonIniciarCom.clicked.connect(self.iniciarComunicacion)
        self.botonDetenerCom.clicked.connect(self.detenerComunicacion)
        self.chBoxGraficarDatos.stateChanged.connect(self.chBoxGraficarStateChanged)
        self.chBoxEnviarComandos.stateChanged.connect(self.chBoxEnviarComandosStateChanged)

        #Objetos para gestionar los labels de la interfaz.
        self.label_estadoCom = self.ui.titulo_estadoComunicacion 
        self.label_estadoCom.setText("Comunicacion inactiva")
        self.label_timerSesion = self.ui.tiempoEjecucion
        self.label_timerSesion.setText("00:00")

        #Al empezar la ejecucion del programa el boton de detener comunicacion debe aparecer desactivado.        
        self.botonDetenerCom.setStyleSheet('background-color:#cdc9c9;')                
        
        #Variables para manejar la comunicacion y el tiempo de ejecucion.
        self.comunicacionIniciada = False
        self.tiempoEjecucionMinutos = 0
        self.tiempoEjecucionSegundos = 0
        
        #Variables para manejar el hilo del Joystick, y los comandos que este emita.
        self.motoresEncendidos = 0
        self.comandoPitch = 0.0
        self.comandoRoll = 0.0
        self.comandoAltura = ord('=')
        self.hiloJoystick = HiloJoystick(ventana = self)
        self.hiloJoystick.start()
        
        self.tasaBaudios = 38400
        self.nombrePuertoSerial = "/dev/ttyUSB0"
        self.hiloComunicacion = HiloSerial(ventana = self, limiteDatos = self.limiteDatosGraficas, nombrePuerto = self.nombrePuertoSerial, tasaBaudios = self.tasaBaudios)
        
        self.show()

        
        
    def chBoxGraficarStateChanged(self):
        self.graficarDatos = not(self.graficarDatos)
        #print self.graficarDatos
        
    def chBoxEnviarComandosStateChanged(self):
        self.enviarComandos = not(self.enviarComandos)
        #print self.enviarComandos


    def setDatos(self, datosPosYaw, datosPosPitch, datosPosRoll, datosVelYaw, datosVelPitch, datosVelRoll, datosAltura, mensajesRecibidos):
        self.datosPosPitch = datosPosPitch
        self.datosPosRoll = datosPosRoll
        self.datosPosYaw = datosPosYaw
        self.datosVelPitch = datosVelPitch
        self.datosVelRoll = datosVelRoll
        self.datosVelYaw = datosVelYaw
        self.datosAltura = datosAltura
        self.mensajesEstadoRecibidos = mensajesRecibidos
        self.datosTiempoRecepcion[self.mensajesEstadoRecibidos] = time.clock()
        
        """print "\nDatos de tiempo = "
        print "tiempo= " + str(self.datosTiempoRecepcion[self.mensajesEstadoRecibidos])
        print "valor de pitch= " + str(self.datosPosPitch[self.mensajesEstadoRecibidos])"""


    def setComandosMovimiento(self, comandoPitch, comandoRoll, comandoAltura):
        """print comandoPitch
        print comandoRoll
        print comandoAltura"""
        self.comandoPitch = comandoPitch
        self.comandoRoll = comandoRoll
        self.comandoAltura = comandoAltura
        if (self.enviarComandos == True) and (self.comunicacionIniciada == True):
            self.hiloComunicacion.enviarComandosMovimiento(comandoPitch, comandoRoll, comandoAltura)
            
        
    def setComandoEncendido(self, comando):
        """print comando"""
        self.motoresEncendidos = comando
        if (self.enviarComandos == True) and (self.comunicacionIniciada == True): 
            self.hiloComunicacion.enviarComandoEncendido(comando)
        
    def iniciarComunicacion(self):
        if(self.comunicacionIniciada == False):
            print "Iniciar comunicacion"
            self.label_estadoCom.setText("Comunicacion activa")
            self.botonIniciarCom.setStyleSheet('background-color:#cdc9c9;')
            self.botonDetenerCom.setStyleSheet('background-color: rgb(255,0,0);')
            self.tiempoInicioEjecucion = time.localtime(time.time())
            self.comunicacionIniciada = True
            self.timerTiempoEjecucion = QtCore.QTimer()
            self.timerTiempoEjecucion.timeout.connect(self.updateTimerLabel)
            self.timerTiempoEjecucion.start(1000)
            self.hiloComunicacion.start()
        
        
    def detenerComunicacion(self):
        if(self.comunicacionIniciada == True):
            print "Detener comunicacion"
            self.label_estadoCom.setText("Comunicacion inactiva")
            self.botonDetenerCom.setStyleSheet('background-color:#cdc9c9;')
            self.botonIniciarCom.setStyleSheet('background-color: rgb(0,230,0);')
            self.tiempoEjecucionMinutos = 0
            self.tiempoEjecucionSegundos = 0            
            self.comunicacionIniciada = False
            self.timerTiempoEjecucion.stop()
            self.label_timerSesion.setText("00:00")
            self.hiloComunicacion.stop()
            

    def updateTimerLabel(self):
        if(self.tiempoEjecucionSegundos < 60):
            self.tiempoEjecucionSegundos += 1
        else:
            self.tiempoEjecucionSegundos = 0
            self.tiempoEjecucionMinutos += 1
            
        if(self.tiempoEjecucionMinutos < 10):
            textoTimer = "0" + str(self.tiempoEjecucionMinutos) + ":"
        else:
            textoTimer = str(self.tiempoEjecucionMinutos) + ":"

        if(self.tiempoEjecucionSegundos < 10):
            textoTimer += "0" + str(self.tiempoEjecucionSegundos)
        else:
            textoTimer += str(self.tiempoEjecucionSegundos)
            
        self.label_timerSesion.setText(textoTimer)
        self.updatePlots()
            
        
    def updatePlots(self):
        if(self.graficarDatos == True):
            """self.plot_posPitch.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('y', width=2))
            self.plot_posRoll.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('b', width=2))
            self.plot_posYaw.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('r', width=2))
            self.plot_velPitch.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('y', width=2))
            self.plot_velRoll.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('b', width=2))
            self.plot_velYaw.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('r', width=2))
            self.plot_altura.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('g', width=2))"""
            self.plot_posPitch.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosPosPitch[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('y', width=2))
            self.plot_posRoll.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosPosRoll[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('b', width=2))
            self.plot_posYaw.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosPosYaw[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('r', width=2))
            self.plot_velPitch.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosVelPitch[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('y', width=2))
            self.plot_velRoll.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosVelRoll[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('b', width=2))
            self.plot_velYaw.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosVelYaw[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('r', width=2))
            self.plot_altura.plot(x=self.datosTiempoRecepcion[1:self.mensajesEstadoRecibidos], y=self.datosAltura[1:self.mensajesEstadoRecibidos], clear=True, pen = pg.mkPen('g', width=2))
            
            
ventana = VentanaPrincipal()

""" TODO:
    1) El hilo de comunicacion debe tener metodos para enviar comandos del Joystick de forma inmediata al cuadricoptero.
    2) Si se vuelve a presionar el boton Iniciar, el hilo deberia empezar a pasar datos de nuevo a la interfaz (El hilo deberia hacer flush cuando se llama a sus metodos
    Start y Resume)

"""