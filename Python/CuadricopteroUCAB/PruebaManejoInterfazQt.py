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
        self.plot_posPitch.setTitle("Pitch (Grados)")
        self.plot_posRoll.setTitle("Roll (Grados)")
        self.plot_posYaw.setTitle("Yaw (Grados)")
        self.plot_velPitch.setTitle("Pitch (Grados/Segundo)")
        self.plot_velRoll.setTitle("Roll (Grados/Segundo)")
        self.plot_velYaw.setTitle("Yaw (Grados/Segundo)")
        self.plot_altura.setTitle("Altura (Centimetros)")
        
        #Objetos para gestionar las acciones del usuario sobre los botones de la interfaz.
        self.botonIniciarCom = self.ui.pB_iniciarComunicacion
        self.botonDetenerCom = self.ui.pB_detenerComunicacion
        self.chBoxGraficarDatos = self.ui.chBox_graficarDatosSensores
        self.chBoxEnviarComandos = self.ui.chBox_enviarComandosJoystick
        
        #Por defecto se grafican los datos de los sensores.
        self.graficarDatos = True
        self.chBoxGraficarDatos.toggle()
        
        #Por defecto no se envian comandos desde el Joystick, para evitar accidentes al presionarlo inadvertidamente.
        self.enviarComandos = False
        
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
        
        self.show()
        
        
        
    def chBoxGraficarStateChanged(self):
        self.graficarDatos = not(self.graficarDatos)
        print self.graficarDatos
        
    def chBoxEnviarComandosStateChanged(self):
        self.enviarComandos = not(self.enviarComandos)
        print self.enviarComandos


    def setDataArrays(self):
        datosPosPitch = 0
        datosPosRoll = 0
        datosPosYaw = 0

        
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
        print 'hola'
        if(self.graficarDatos == True):
            self.plot_posPitch.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('y', width=2))
            self.plot_posRoll.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('b', width=2))
            self.plot_posYaw.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('r', width=2))
            self.plot_velPitch.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('y', width=2))
            self.plot_velRoll.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('b', width=2))
            self.plot_velYaw.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('r', width=2))
            self.plot_altura.plot(np.random.normal(size=100), clear=True, pen = pg.mkPen('g', width=2))

ventana = VentanaPrincipal()
""" TODO:
    1) Aqui se podria llamar a un hilo que maneje el puerto serial y reciba la instanciacion de la ventana,
    de modo que pueda llamar al metodo updatePlots de la ventana (que hay que mejorarlo, ahorita solo es 
    un stub para pruebas) conforme le lleguen datos. De esa manera, las graficas se actualizarian conforme
    lleguen los datos, y no se quedaria pegada la interfaz.El hilo, ademas, tendria metodos para enviar 
    comandos del Joystick de forma inmediata al cuadricoptero.
    Si se aprieta el boton Iniciar en la interfaz, el hilo inicia su ejecucion (Start). Si se aprieta el boton
    Detener en la interfaz, el hilo se detiene. Si se vuelve a presionar el boton Iniciar, el hilo deberia 
    empezar a pasar datos de nuevo a la interfaz (El hilo deberia hacer flush cuando se llama a sus metodos
    Start y Resume)

    2) Al levantarse la ventana principal deberia levantarse tambien un hilo que maneje los eventos del Joystick
    y guarde     el estado del mismo en variables de la Ventana (Se debe pasar la ventana como parametro al hilo
    del Joystick)
"""