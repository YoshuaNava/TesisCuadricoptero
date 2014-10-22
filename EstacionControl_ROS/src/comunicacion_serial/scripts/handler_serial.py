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
        self.__CODIGO_MENSAJE_TELEMETRIA_TOTAL = 8
        

        self.anguloYaw = 0
        self.anguloPitch = 0
        self.anguloRoll = 0        
        self.G_Yaw = 0;
        self.G_Pitch = 0;
        self.G_Roll = 0;
        
        #Variables de mensaje de telemetria total.
        self.G_Yaw_filtrada = 0;
        self.G_Pitch_filtrada = 0;
        self.G_Roll_filtrada = 0;
        self.Ax = 0;
        self.Ay = 0;
        self.Az = 0;
        self.Ax_filtrada = 0;
        self.Ay_filtrada = 0;
        self.Az_filtrada = 0;
        self.posZ = 0
        self.posZ_filtrada = 0;
        self.velZ = 0;
        self.motorDelantero = 0;
        self.motorTrasero = 0;
        self.motorDerecho = 0;
        self.motorIzquierdo = 0;
        #Fin de variables mensaje de telemetria total.

        self.encendidoMotores = 0;
        self.mensajesRecibidos = 0
        self.nombrePuerto = nombrePuerto
        self.tasaBaudios = tasaBaudios
                
        self.puertoSerial = serial.Serial(port=self.nombrePuerto, baudrate=self.tasaBaudios, timeout=0.05)


    def abrirPuerto(self):
        self.puertoSerial = serial.Serial(self.nombrePuerto, self.tasaBaudios)
    
        
    def cerrarPuerto(self):
        self.puertoSerial.close()
            
            
    def enviarComandoMovimiento(self, comandoPitch, comandoRoll, comandoAltura):
        checksum = self.__CODIGO_INICIO_MENSAJE ^ self.__CODIGO_MENSAJE_COMANDO ^ int(comandoPitch) ^ int(comandoRoll) ^ int(comandoAltura)
        paquete = chr(self.__CODIGO_INICIO_MENSAJE) + chr(self.__CODIGO_MENSAJE_COMANDO) + chr(int(comandoPitch)) + chr(int(comandoRoll)) + chr(int(comandoAltura)) + chr(checksum)
        self.puertoSerial.write(paquete)        
        """for i in range(6):
            print (ord(paquete[i]))"""
        

        
    def enviarComandoEncendido(self, comando):
        checksum = self.__CODIGO_INICIO_MENSAJE ^ self.__CODIGO_MENSAJE_ENCENDIDO ^ comando
        paquete = chr(self.__CODIGO_INICIO_MENSAJE) + chr(self.__CODIGO_MENSAJE_ENCENDIDO) + chr(comando) + chr(checksum)
        self.puertoSerial.write(paquete)
        #self.mensajesEstadoRecibidos = 0
        """        for i in range(4):  
            print (ord(paquete[i]))"""

        
            
    def recibirComandos(self):
        header = self.cardinalCaracter_Validar(self.puertoSerial.read())
        if (header == self.__CODIGO_INICIO_MENSAJE):
            comando = self.cardinalCaracter_Validar(self.puertoSerial.read())
            if (comando == self.__CODIGO_MENSAJE_ACK_QR):
                codigoACK = self.cardinalCaracter_Validar(self.puertoSerial.read())
                checksum = self.cardinalCaracter_Validar(self.puertoSerial.read())
                
                
                if ((header ^ comando ^ codigoACK) == checksum):
                    print "ACK DE ENCENDIDO/APAGADO!!!!!"
                    self.ultimoComandoRecibido = comando
                    return True
                else:
                    return False


            if (comando == self.__CODIGO_MENSAJE_ESTADO):
                P_anguloYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_anguloYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                anguloPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())                
                anguloRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velocidadYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velocidadYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velocidadPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velocidadPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velocidadRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velocidadRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                posZ = self.cardinalCaracter_Validar(self.puertoSerial.read())
                encendidoMotores = self.cardinalCaracter_Validar(self.puertoSerial.read())
                checksum = self.cardinalCaracter_Validar(self.puertoSerial.read())
    
                if((header != None) and (comando != None) and (P_anguloYaw != None) and (anguloPitch != None) and (anguloRoll != None) and (P_velocidadYaw != None) and (P_velocidadPitch != None) and (P_velocidadRoll != None) and (N_anguloYaw != None) and (N_velocidadYaw != None) and (N_velocidadPitch != None) and (N_velocidadRoll != None) and (posZ != None) and (encendidoMotores != None) and (checksum != None)):
                    if ((header ^ comando ^ P_anguloYaw ^ N_anguloYaw ^ anguloPitch ^ anguloRoll ^ P_velocidadYaw ^ N_velocidadYaw ^ P_velocidadPitch ^ N_velocidadPitch ^ P_velocidadRoll ^ N_velocidadRoll ^ posZ ^ encendidoMotores) == checksum):

			self.mensajesRecibidos = self.mensajesRecibidos + 1
                            
                        if (P_anguloYaw > 0):
                            self.anguloYaw = P_anguloYaw
                        else:
                            self.anguloYaw = - N_anguloYaw
                        
                        self.anguloPitch = anguloPitch - 90
                        self.anguloRoll = anguloRoll - 90

                        if (P_velocidadYaw > 0):
                            self.G_Yaw = P_velocidadYaw
                        else:
                            self.G_Yaw = - N_velocidadYaw
                        if (P_velocidadPitch > 0):
                            self.G_Pitch = P_velocidadPitch
                        else:
                            self.G_Pitch = - N_velocidadPitch
                        if (P_velocidadRoll > 0):
                            self.G_Roll = P_velocidadRoll
                        else:
                            self.G_Roll = - N_velocidadRoll
                        
                        self.posZ = posZ

                        self.encendidoMotores = encendidoMotores
                        self.ultimoComandoRecibido = comando

                        return True
                    else:
                        return False


            if (comando == self.__CODIGO_MENSAJE_TELEMETRIA_TOTAL):
                P_anguloYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_anguloYaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_anguloPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_anguloPitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_anguloRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_anguloRoll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_G_Yaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_G_Yaw = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_G_Pitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_G_Pitch = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_G_Roll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_G_Roll = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_G_Yaw_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_G_Yaw_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_G_Pitch_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_G_Pitch_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_G_Roll_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_G_Roll_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_Ax = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_Ax = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_Ay = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_Ay = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_Az = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_Az = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_Ax_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_Ax_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_Ay_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_Ay_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_Az_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_Az_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                posZ = self.cardinalCaracter_Validar(self.puertoSerial.read())
                posZ_filtrada = self.cardinalCaracter_Validar(self.puertoSerial.read())
                P_velZ = self.cardinalCaracter_Validar(self.puertoSerial.read())
                N_velZ = self.cardinalCaracter_Validar(self.puertoSerial.read())
                motorDelantero = self.cardinalCaracter_Validar(self.puertoSerial.read())
                motorTrasero = self.cardinalCaracter_Validar(self.puertoSerial.read())
                motorDerecho = self.cardinalCaracter_Validar(self.puertoSerial.read())
                motorIzquierdo = self.cardinalCaracter_Validar(self.puertoSerial.read())
                encendidoMotores = self.cardinalCaracter_Validar(self.puertoSerial.read())
                checksum = self.cardinalCaracter_Validar(self.puertoSerial.read())
                #print encendidoMotores
                print checksum
                
                validacionCamposMensaje = (header != None) and (comando != None) and (P_anguloYaw != None) and (P_anguloPitch != None) and (P_anguloRoll != None) and (P_G_Yaw != None) and (P_G_Pitch != None) and (P_G_Roll != None) and (P_G_Yaw_filtrada != None) and (P_G_Pitch_filtrada != None) and (P_G_Roll_filtrada != None)
                validacionCamposMensaje = validacionCamposMensaje and (N_anguloYaw != None) and (N_anguloPitch != None) and (N_anguloRoll != None) and (N_G_Yaw != None) and (N_G_Pitch != None) and (N_G_Roll != None) and (N_G_Yaw_filtrada != None) and (N_G_Pitch_filtrada != None) and (N_G_Roll_filtrada != None)
                validacionCamposMensaje = validacionCamposMensaje and (P_Ax != None) and (N_Ax != None) and (P_Ay != None) and (N_Ay != None) and (P_Az != None) and (N_Az != None) and (P_Ax_filtrada != None) and (N_Ax_filtrada != None) and (P_Ay_filtrada != None) and (N_Ay_filtrada != None) and (P_Az_filtrada != None) and (N_Az_filtrada != None)
                validacionCamposMensaje = validacionCamposMensaje and (posZ != None) and (posZ_filtrada != None) and (P_velZ != None) and (N_velZ != None) and (motorDelantero != None) and (motorTrasero != None) and (motorDerecho != None) and (motorIzquierdo != None) and (encendidoMotores != None) and (checksum != None)
                if(validacionCamposMensaje):
                    checksumMensajeRecibido = (header ^ comando ^ P_anguloYaw ^ N_anguloYaw ^ P_anguloPitch ^ N_anguloPitch ^ P_anguloRoll ^ N_anguloRoll ^ P_G_Yaw ^ N_G_Yaw ^ P_G_Pitch ^ N_G_Pitch ^ P_G_Roll ^ N_G_Roll ^ P_G_Yaw_filtrada ^ N_G_Yaw_filtrada ^ P_G_Pitch_filtrada ^ N_G_Pitch_filtrada ^ P_G_Roll_filtrada ^ N_G_Roll_filtrada)
                    checksumMensajeRecibido = (checksumMensajeRecibido ^ P_Ax ^ N_Ax ^ P_Ay ^ N_Ay ^ P_Az ^ N_Az ^ P_Ax_filtrada ^ N_Ax_filtrada ^ P_Ay_filtrada ^ N_Ay_filtrada ^ P_Az_filtrada ^ N_Az_filtrada ^ posZ ^ posZ_filtrada ^ P_velZ ^ N_velZ ^ motorDelantero ^ motorTrasero ^ motorDerecho ^ motorIzquierdo ^ encendidoMotores)
                    if (checksumMensajeRecibido == checksum):

                        self.mensajesRecibidos = self.mensajesRecibidos + 1
                            
                        if (P_anguloYaw > 0):
                            self.anguloYaw = P_anguloYaw
                        else:
                            self.anguloYaw = - N_anguloYaw                        
                        if (P_anguloPitch > 0):
                            self.anguloPitch = P_anguloPitch
                        else:
                            self.anguloPitch = - N_anguloPitch
                        if (P_anguloRoll > 0):
                            self.anguloRoll = P_anguloRoll
                        else:
                            self.anguloRoll = - N_anguloRoll                            
                            
                        if (P_G_Yaw > 0):
                            self.G_Yaw = P_G_Yaw
                        else:
                            self.G_Yaw = - N_G_Yaw
                        if (P_G_Pitch > 0):
                            self.G_Pitch = P_G_Pitch
                        else:
                            self.G_Pitch = - N_G_Pitch
                        if (P_G_Roll > 0):
                            self.G_Roll = P_G_Roll
                        else:
                            self.G_Roll = - N_G_Roll
                            
                        if (P_G_Yaw_filtrada > 0):
                            self.G_Yaw_filtrada = P_G_Yaw_filtrada
                        else:
                            self.G_Yaw_filtrada = - N_G_Yaw_filtrada
                        if (P_G_Pitch_filtrada > 0):
                            self.G_Pitch_filtrada = P_G_Pitch_filtrada
                        else:
                            self.G_Pitch_filtrada = - N_G_Pitch_filtrada
                        if (P_G_Roll_filtrada > 0):
                            self.G_Roll_filtrada = P_G_Roll_filtrada
                        else:
                            self.G_Roll_filtrada = - N_G_Roll_filtrada

                        if (P_Ax > 0):
                            self.Ax = P_Ax
                        else:
                            self.Ax = - N_Ax
                        if (P_Ay > 0):
                            self.Ay = P_Ay
                        else:
                            self.Ay = - N_Ay
                        if (P_Az > 0):
                            self.Az = P_Az
                        else:
                            self.Az = - N_Az

                        if (P_Ax_filtrada > 0):
                            self.Ax_filtrada = P_Ax_filtrada
                        else:
                            self.Ax_filtrada = - N_Ax_filtrada
                        if (P_Ay_filtrada > 0):
                            self.Ay_filtrada = P_Ay_filtrada
                        else:
                            self.Ay_filtrada = - N_Ay_filtrada
                        if (P_Az_filtrada > 0):
                            self.Az_filtrada = P_Az_filtrada
                        else:
                            self.Az_filtrada = - N_Az_filtrada
                            
                        self.posZ = posZ
                        self.posZ_filtrada = posZ_filtrada
                        
                        if (P_velZ > 0):
                            self.velZ = P_velZ
                        else:
                            self.velZ = - N_velZ

                        self.motorDelantero = motorDelantero
                        self.motorTrasero = motorTrasero
                        self.motorDerecho = motorDerecho
                        self.motorIzquierdo = motorIzquierdo
                        
                        self.encendidoMotores = encendidoMotores
                        self.ultimoComandoRecibido = comando

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
