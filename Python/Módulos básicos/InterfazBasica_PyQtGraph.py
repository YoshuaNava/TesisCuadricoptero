# -*- coding: utf-8 -*-
"""
Created on Wed Aug  6 15:34:47 2014

@author: alfredoso
"""

import pyqtgraph as pg
from pyqtgraph.Qt import QtCore, QtGui
import numpy as np
from pyqtgraph.dockarea import *


aplicacion = QtGui.QApplication([])
ventana = QtGui.QMainWindow()

areaDock = DockArea()
ventana.setCentralWidget(areaDock)
ventana.resize(1000,600)
ventana.setWindowTitle('pyqtgraph example: dockarea')

plotDock_1 = Dock("Dock2 - Plot", size=(500,200))
plotDock_2 = Dock("Dock3 - Plot", size=(500,200))
opcionesDock = Dock("Dock4 - Options", size=(1000,200))

layoutOpciones = pg.LayoutWidget()
labelOpciones = QtGui.QLabel("Opciones")
botonPrueba = QtGui.QPushButton('Prueba')

layoutOpciones.addWidget(labelOpciones, row = 0, col = 0)
layoutOpciones.addWidget(botonPrueba, row = 1, col = 1)
opcionesDock.addWidget(layoutOpciones)

plot_1 = pg.PlotWidget("Aleatorio 1")
plot_1.Plot(np.random.normal(size=100))
plotDock_1.addWidget(plot_1)

plot_2 = pg.PlotWidget("Aleatorio 2")
plot_2.Plot(np.random.normal(size=100))
plotDock_2.addWidget(plot_2)

areaDock.addDock(plotDock_1,"left")
areaDock.addDock(plotDock_2,"right")
areaDock.addDock(opcionesDock,"bottom")

ventana.show()