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
#import ModuloSerial as Serial




class HiloJoystick:

    def __init__(self, ventana):
        self.__BOTON_2 = 1
        self.__BOTON_4 = 3
        self.__BOTON_5 = 4
        self.__BOTON_7 = 6
        self.__RUEDA_DERECHA_x = 2
        self.__RUEDA_DERECHA_y = 3
        
        self.__CODIGO_AUMENTAR_ALTURA = '+'
        self.__CODIGO_DISMINUIR_ALTURA = '-'
        self.__CODIGO_MANTENER_ALTURA = '='
        self.__CODIGO_ENCENDER = 1
        self.__CODIGO_APAGAR = 0
        self.MAXIMO_ANGULO = 20
        
        self.comandoPitch = 0.0
        self.comandoRoll = 0.0
        self.comandoAltura = ord('=')
        self.motoresEncendidos = 0
        
        if (ventana != None):
            self.ventanaPrincipal = ventana
        else:
            self.ventanaPrincipal = None
                
        self.hilo = Thread(target=self.run)


    
    def start(self):
        if (self.hilo.isAlive() == False):
            self.hilo.start()
        else:
            self.hilo = Thread(target=self.run)
            self.hilo.start()        
            
                
    

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
        
            pygame.event.pump()
            #necessary for os to pass joystick events
            return joystick_object
    
    
    def enviarComandosMovimientoVentana(self):
        if(self.ventanaPrincipal != None):
            self.ventanaPrincipal.setComandosMovimiento(self.comandoPitch, self.comandoRoll, self.comandoAltura)
            
    def enviarComandoEncendidoVentana(self):
        if(self.ventanaPrincipal != None):
            self.ventanaPrincipal.setComandoEncendido(self.motoresEncendidos)
    
    def run(self):
        
        pygame.display.init()
                
        joystick_object = self.detectarJoystick()
        
        if (joystick_object != None):

            estado_boton_DELTA = joystick_object.get_button(self.__BOTON_4)
            
            #while (estado_boton_DELTA == 0):
            while (True):
                eventos = pygame.event.get()
                for evento in eventos:                
                    if evento.type == pygame.JOYAXISMOTION:
                        movimientoX_ruedaDerecha = joystick_object.get_axis(self.__RUEDA_DERECHA_x)
                        movimientoY_ruedaDerecha = -joystick_object.get_axis(self.__RUEDA_DERECHA_y)
                        
                        if ((movimientoY_ruedaDerecha == 0) and (self.comandoPitch != 0)):
                            self.comandoPitch = 0
                            
                        if ((movimientoX_ruedaDerecha == 0) and (self.comandoRoll != 0)):                            
                            self.comandoRoll = 0
                            
                        if (movimientoX_ruedaDerecha != 0) or (movimientoY_ruedaDerecha != 0):
                            #print 'Rueda Derecha, Posicion en x= %f' %movimientoX_ruedaDerecha
                            #print 'Rueda Derecha, Posicion en y= %f' %movimientoY_ruedaDerecha
                            self.comandoPitch = movimientoY_ruedaDerecha*self.MAXIMO_ANGULO
                            self.comandoRoll = movimientoX_ruedaDerecha*self.MAXIMO_ANGULO
                            #print 'Comando de pitch= %d' %(self.comandoPitch)
                            #print 'Comando de roll= %d' %(self.comandoRoll)
                        
                        self.enviarComandosMovimientoVentana()
                            
        
                    if evento.type == pygame.JOYBUTTONDOWN:
                        estado_boton_X = joystick_object.get_button(self.__BOTON_2)
                        estado_boton_DELTA = joystick_object.get_button(self.__BOTON_4)
                        estado_boton_L1 = joystick_object.get_button(self.__BOTON_5)
                        estado_boton_L2 = joystick_object.get_button(self.__BOTON_7)

                        if(estado_boton_X == 1) or (estado_boton_DELTA == 1):
                            if (estado_boton_X == 1):
                                self.motoresEncendidos = 1
                                #print 'Boton X: ' + str(estado_boton_X)
                                
                            if (estado_boton_DELTA == 1):
                                self.motoresEncendidos = 0
                                #print 'Boton DELTA: ' + str(estado_boton_DELTA)
                                
                            self.enviarComandoEncendidoVentana()
                        else:
                            if (estado_boton_L1 != 0) and (estado_boton_L2 == 0):
                                self.comandoAltura = ord('+')
                            if (estado_boton_L1 == 0) and (estado_boton_L2 != 0):
                                self.comandoAltura = ord('-')
                            if (estado_boton_L1 == 0) and (estado_boton_L2 == 0):
                                self.comandoAltura = ord('=')
                                
                            self.enviarComandosMovimientoVentana()

                    
     #                   print 'Boton R1, Valor %d' %(estado_boton_R1)
                time.sleep(0) #Permitir que otros hilos pasen a ejecutarse. Es como un yield()
        
        
    

        
            
        
        joystick_object.quit()
        #destroy objects and clean up
        pygame.joystick.quit()
        
    
