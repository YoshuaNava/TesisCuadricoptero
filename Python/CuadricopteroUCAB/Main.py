# -*- coding: utf-8 -*-

import ModuloSerial as Serial
import ModuloTelemetria as Graficas
import ModuloControl as Control
import FuncionesComunes as Comun


nombrePuerto = "/dev/ttyUSB1"
tasaBaudios = 115200


puertoSerial = Serial.AbrirPuerto(nombrePuerto, tasaBaudios)
#Graficas.Ejecutar(puertoSerial)
Control.Ejecutar(puertoSerial)
print Comun.NumDigitos(3)

Serial.CerrarPuerto(puertoSerial)