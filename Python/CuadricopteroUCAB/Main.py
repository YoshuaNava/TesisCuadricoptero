# -*- coding: utf-8 -*-

import ModuloSerial as Serial
import ModuloTelemetria as Graficas
import ModuloControl as Control


nombrePuerto = "/dev/ttyUSB1"
tasaBaudios = 115200


puertoSerial = Serial.AbrirPuerto(nombrePuerto, tasaBaudios)
Control.Ejecutar(puertoSerial)
print Control.NumDigitos(3)

Serial.CerrarPuerto(puertoSerial)