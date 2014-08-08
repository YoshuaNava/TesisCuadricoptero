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
from time import sleep

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
        
        self.plot_posPitch = self.ui.posicionPitchPlot.getPlotItem()
        self.plot_posRoll = self.ui.posicionRollPlot.getPlotItem()
        self.plot_posYaw = self.ui.posicionYawPlot.getPlotItem()        
        self.plot_velPitch = self.ui.velocidadPitchPlot.getPlotItem()
        self.plot_velRoll = self.ui.velocidadRollPlot.getPlotItem()
        self.plot_velYaw = self.ui.velocidadYawPlot.getPlotItem()
        self.plot_altura = self.ui.alturaPlot.getPlotItem()
        
        self.show()

    def SetDataArrays():
        datosPosPitch = 0
        datosPosRoll = 0
        datosPosYaw = 0
        
    def updatePlots():
        print 'hola'        
        

ventana = VentanaPrincipal()
ventana.plot_posPitch.plot(np.random.normal(size=100), clear=True)
sleep(2)
ventana.plot_posPitch.plot(np.random.normal(size=100)*0, clear=True)
sleep(2)
ventana.plot_posPitch.plot(np.random.normal(size=100), clear=True)
sleep(2)
ventana.plot_posPitch.plot(np.random.normal(size=100)*0, clear=True)
sleep(2)
ventana.plot_posPitch.plot(np.random.normal(size=100), clear=True)