# -*- coding: utf-8 -*-

"""import pyqtgraph.examples

pyqtgraph.examples.run()"""

import pyqtgraph as pg
import numpy as np
from pyqtgraph.Qt import QtGui, QtCore

app = QtGui.QApplication([])

win = pg.GraphicsWindow(title="Basic plotting examples")
win.resize(1000,600)
win.setWindowTitle('pyqtgraph example: Plotting')

grafica = win.addPlot(title="Updating plot")
curve = grafica.plot(pen='y')
data = np.random.normal(size=(10,1000))
ptr = 0
def update():
    global curve, data, ptr, grafica
    curve.setData(data[ptr%10])
    if ptr == 0:
        grafica.enableAutoRange('xy', False)  ## stop auto-scaling after the first data set is plotted
    ptr += 1
timer = QtCore.QTimer()
timer.timeout.connect(update)
timer.start(50)
