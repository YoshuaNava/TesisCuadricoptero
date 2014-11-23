# -*- coding: utf-8 -*-
"""
Created on Mon Aug 11 08:10:57 2014

@author: alfredoso
"""

# -*- coding: utf-8 -*-

import pygame
import pygame.display
import pygame.joystick
import time
from threading import Thread




class HandlerJoystick:

    def __init__(self):
	###########################CONSTANTES###########################
        self.__BOTON_2 = 1				#ENCENDER MOTORES
        self.__BOTON_4 = 3				#APAGAR MOTORES
        self.__BOTON_5 = 4
        self.__BOTON_6 = 5				#CONSIGNAS EN 0
        self.__BOTON_7 = 6
        self.__RUEDA_DERECHA_x = 2		#CONTROL DE PITCH
        self.__RUEDA_DERECHA_y = 3		#CONTROL DE YAW
        self.__RUEDA_IZQUIERDA_x = 0	#CONTROL VELOCIDAD BASE PWM
        self.__RUEDA_IZQUIERDA_y = 1        

        self.__CODIGO_AUMENTAR_ALTURA = '+'
        self.__CODIGO_DISMINUIR_ALTURA = '-'
        self.__CODIGO_MANTENER_ALTURA = '='
        self.__CODIGO_ENCENDER = 1
        self.__CODIGO_APAGAR = 0
        self.__MAXIMO_ANGULO_COMANDO = 70
        self.__VELOCIDAD_MAXIMA_PWM = 240
        self.__VELOCIDAD_BASE_PWM = 120
        self.__MAXIMA_ALTURA = 150
        self.__FACTOR_EXPONENCIAL = 0.7
    ###########################VARIABLES###########################    
        self.comandoPitch = 0.0
        self.comandoRoll = 0.0
        self.comandoAltura = self.__VELOCIDAD_BASE_PWM
        self.motoresEncendidos = 0
        self.comandoEncendidoEjecutado = False
        self.comandoMovimientoEjecutado = False
                        
        self.hilo = Thread(target=self.run)


            
    
		###########################################################################
        ##DETECTA EL JOYSTICK IMPRIME LA INFORMACION Y RETORNA EL OBJETO JOYSTICK##
		###########################################################################
    def detectarJoystick(self):
        pygame.joystick.init() #initialize joystick module
        pygame.joystick.get_init() #verify initialization (boolean)    
        joystick_count = pygame.joystick.get_count()#get number of joysticks
        print('%d joystick(s) connected' %joystick_count)#print number
        
        if (joystick_count == 1):
            joystick_object = pygame.joystick.Joystick(0)
            #create an instance of a joystick
            #first joystick is [0] in the list
            #haven't had much luck with multiple joysticks
        
            joystick_object.get_name()
            print joystick_object.get_name()
            #grab joystick name - flightstick, gravis...
            #can (and is in this case) be done before initialization
        
            joystick_object.init()
        
            joystick_object.get_init()
            #verify initialization (maybe cool to do some
            #error trapping with this so game doesn't crash
        
            num_axes = joystick_object.get_numaxes()
            num_buttons = joystick_object.get_numbuttons()
        
            print 'Joystick has %d axes and %d buttons' %(num_axes, num_buttons)
        
                            
            #necessary for os to pass joystick events
            self.joystick_object = joystick_object
    
    

		##############################################################################################################################################
        ##HILO DE EJECUCION DEL JOYSTICK							         																		##
		##############################################################################################################################################
		## Busca el control de joystick y a patir de alli maneja los siguientes eventos de manera separada:                                         ##
 		##          1)Rueda derecha: maneja movimientos en pitch(rueda derecha x) y en roll (rueda derecha y)                                       ##
 		##          2)Rueda izquierda: maneja las velocidades en altura                                                                             ##
 		##          3)Botorn 2: envia senal de encendido al cuadricoptero                                                                           ##
 		##          4)boton 4: envia senal de apagado al cuadricoptero                                                                              ##
		##          5)boton 6 (R1): Envia 0 a las consignas de pitch y roll                                                                         ##
 		##############################################################################################################################################
    def run(self):        
        pygame.display.init()        
        pygame.event.pump()

        if (self.joystick_object != None):

            estado_boton_DELTA = self.joystick_object.get_button(self.__BOTON_4)
            
            #while (estado_boton_DELTA == 0):
            self.comandoEncendidoEjecutado = False
            self.comandoMovimientoEjecutado = False
            eventos = pygame.event.get()
            for evento in eventos:                
                if evento.type == pygame.JOYAXISMOTION:
                    movimientoX_ruedaDerecha = self.joystick_object.get_axis(self.__RUEDA_DERECHA_x)
                    movimientoY_ruedaDerecha = -self.joystick_object.get_axis(self.__RUEDA_DERECHA_y)
                    
                    movimientoX_ruedaIzquierda = self.joystick_object.get_axis(self.__RUEDA_IZQUIERDA_x)
                    movimientoY_ruedaIzquierda = self.joystick_object.get_axis(self.__RUEDA_IZQUIERDA_y)

                    if ((movimientoY_ruedaDerecha == 0) and (self.comandoPitch != 0)):
                        self.comandoPitch = 0
                        
                    if ((movimientoX_ruedaDerecha == 0) and (self.comandoRoll != 0)):                         
                        self.comandoRoll = 0
                        
                    if ((movimientoY_ruedaIzquierda == 0) and (self.comandoAltura != self.__VELOCIDAD_BASE_PWM)):
                        self.comandoAltura = 0
                        
                    if (movimientoX_ruedaDerecha != 0) or (movimientoY_ruedaDerecha != 0) or (movimientoY_ruedaIzquierda != 0):
                        #print 'Rueda Derecha, Posicion en x= %f' %movimientoX_ruedaDerecha
                        #print 'Rueda Derecha, Posicion en y= %f' %movimientoY_ruedaDerecha
                        exponencialPitch = ((1-self.__FACTOR_EXPONENCIAL)*movimientoY_ruedaDerecha) + (self.__FACTOR_EXPONENCIAL*movimientoY_ruedaDerecha**3)
                        self.comandoPitch = exponencialPitch*self.__MAXIMO_ANGULO_COMANDO
                        exponencialRoll = ((1-self.__FACTOR_EXPONENCIAL)*movimientoX_ruedaDerecha) + (self.__FACTOR_EXPONENCIAL*movimientoX_ruedaDerecha**3)
                        self.comandoRoll = exponencialRoll*self.__MAXIMO_ANGULO_COMANDO
                        self.comandoAltura = self.__VELOCIDAD_BASE_PWM + (self.__VELOCIDAD_MAXIMA_PWM - self.__VELOCIDAD_BASE_PWM)*(-1)*movimientoY_ruedaIzquierda
                    
                        #print 'Comando de pitch= %f' %(self.comandoPitch)
                        #print 'Comando de roll= %f' %(self.comandoRoll)                            
                        
                        self.comandoMovimientoEjecutado = True
#			time.sleep(0.05)
                        
    
                if evento.type == pygame.JOYBUTTONDOWN:
                    estado_boton_X = self.joystick_object.get_button(self.__BOTON_2)
                    estado_boton_DELTA = self.joystick_object.get_button(self.__BOTON_4)
                    estado_boton_R1 = self.joystick_object.get_button(self.__BOTON_6)

                    if(estado_boton_X == 1) or (estado_boton_DELTA == 1):
                        if (estado_boton_X == 1):
                            self.motoresEncendidos = 1
                            #print 'Boton X: ' + str(estado_boton_X)
                            
                        if (estado_boton_DELTA == 1):
                            self.motoresEncendidos = 0
                            #print 'Boton DELTA: ' + str(estado_boton_DELTA)
                            
                        self.comandoEncendidoEjecutado = True
                        
                    else:                            
                        if (estado_boton_R1 == 1):
                            self.comandoPitchEnviar = 0.0
                            self.comandoRollEnviar = 0.0
	                    movimientoY_ruedaIzquierda = self.joystick_object.get_axis(self.__RUEDA_IZQUIERDA_y)
                            self.comandoAltura = self.__VELOCIDAD_BASE_PWM + (self.__VELOCIDAD_MAXIMA_PWM - self.__VELOCIDAD_BASE_PWM)*(-1)*movimientoY_ruedaIzquierda
#                            self.comandoAltura = self.__VELOCIDAD_BASE_PWM
                            self.comandoMovimientoEjecutado = True

                
 #                   print 'Boton R1, Valor %d' %(estado_boton_R1)
            #time.sleep(0.075) #Permitir que otros hilos pasen a ejecutarse. Es como un yield()        
