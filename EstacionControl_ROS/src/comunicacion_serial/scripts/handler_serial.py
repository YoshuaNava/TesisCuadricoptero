#!/usr/bin/env python

import serial
import numpy as np
from threading import Thread



class HandlerSerial:
    def __init__(self, nombrePuerto, tasaBaudios):
        self.__CODIGO_INICIO_MENSAJE = 255        
        self.__CODIGO_MENSAJE_ENCENDIDO = 0
        self.__CODIGO_MENSAJE_COMANDO = 1
        self.__CODIGO_MENSAJE_ACK_QR = 6
        self.__CODIGO_MENSAJE_ESTADO = 7
        

        self.posicionYaw = 0
        self.posicionPitch = 0
        self.posicionRoll = 0
        self.velocidadYaw = 0
        self.velocidadPitch = 0
        self.velocidadRoll = 0
        self.altura = 0
        self.mensajesEstadoRecibidos = 0
        self.nombrePuerto = nombrePuerto
        self.tasaBaudios = tasaBaudios
                
        self.puertoSerial = serial.Serial(port=self.nombrePuerto, baudrate=self.tasaBaudios, timeout=0.05)


    def abrirPuerto(self):
        self.puertoSerial = serial.Serial(self.nombrePuerto, self.tasaBaudios)
    
        
    def cerrarPuerto(self):
        self.puertoSerial.close()
            
            
    def enviarComandoMovimiento(self, comandoPitch, comandoRoll, comandoAltura):
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

			self.mensajesEstadoRecibidos = self.mensajesEstadoRecibidos + 1
                            
                        if (P_posicionYaw > 0):
                            self.posicionYaw = P_posicionYaw
                        else:
                            self.posicionYaw = - N_posicionYaw
                        
                        self.posicionPitch = posicionPitch - 90
                        self.posicionRoll = posicionRoll - 90

                        if (P_velocidadYaw > 0):
                            self.velocidadYaw = P_velocidadYaw
                        else:
                            self.velocidadYaw = - N_velocidadYaw
                        if (P_velocidadPitch > 0):
                            self.velocidadPitch = P_velocidadPitch
                        else:
                            self.velocidadPitch = - N_velocidadPitch
                        if (P_velocidadRoll > 0):
                            self.velocidadRoll = P_velocidadRoll
                        else:
                            self.velocidadRoll = - N_velocidadRoll
                        
                        self.altura = altura

                        

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
    
    
#hilo = HiloSerial(None, 100000, "/dev/ttyUSB0", 38400)
