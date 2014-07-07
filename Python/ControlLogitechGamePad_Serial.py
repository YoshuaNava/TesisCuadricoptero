# -*- coding: utf-8 -*-
"""
Created on Thu Jun 19 13:38:24 2014

@author: alfredoso
"""

import pygame
import pygame.display
import pygame.joystick
from pygame.locals import *
import serial
import struct
import math
import time

BOTON_1 = 0
BOTON_2 = 1
BOTON_3 = 2
BOTON_4 = 3
BOTON_5 = 4
BOTON_6 = 5
BOTON_7 = 6
BOTON_8 = 7
BOTON_9 = 8
BOTON_10 = 9
BOTON_11 = 10
BOTON_10 = 11
TRACKPAD_x = 0
TRACKPAD_y = 1
RUEDA_DERECHA_x = 2
RUEDA_DERECHA_y = 3
RUEDA_IZQUIERDA = 4

CODIGO_COMANDO = 'C'
CODIGO_INCREMENTO_CONSTANTES = 'K'

incremento_kP_velocidad = 0.01
incremento_kD_velocidad = 0.01
multiplicadorConstantes = 1000

strPuerto = "/dev/ttyUSB1"
tasaBaudios = 115200
calibrarYPR = 'R'
MAXIMO_ANGULO = 90



def NumDigitos(numero):
    if  numero == 0:
        return 1
    else:
        return int(math.log10(numero))+1


def EnviarEnteroSerial(puerto, numero):
    numero_low = int(numero % 256)
    numero_high = int(numero / 256)
    #print numero_low
    #print numero_high
    puerto.write(struct.pack('B',numero_low))
    puerto.write(struct.pack('B',numero_high))
    

def EnviarComandoCuadricoptero(puerto, codigo, comandoPitch, comandoRoll, calibrarYPR, checksum):
    puerto.write(codigo)
    EnviarEnteroSerial(puerto,comandoPitch)
    EnviarEnteroSerial(puerto,comandoRoll)
    puerto.write(calibrarYPR)
    EnviarEnteroSerial(puerto,checksum)

    
def DetectarJoystick():
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





pygame.display.init()

puertoSerial = serial.Serial(strPuerto, tasaBaudios)

joystick_object = DetectarJoystick()

if (joystick_object != None):
    estado_boton_QUIT = joystick_object.get_button(BOTON_9)    
    
    while (estado_boton_QUIT == 0):
        eventos = pygame.event.get()
        for evento in eventos:
            if evento.type == pygame.JOYAXISMOTION:                
                movimientoX_trackpad = joystick_object.get_axis(TRACKPAD_x)
                movimientoY_trackpad = -joystick_object.get_axis(TRACKPAD_y)
                if (movimientoX_trackpad != 0):
                    print 'Trackpad, Posicion en x= %f' %round(movimientoX_trackpad)
                if (movimientoY_trackpad != 0):
                    print 'Trackpad, Posicion en y= %f' %movimientoY_trackpad

                movimientoX_ruedaDerecha = joystick_object.get_axis(RUEDA_DERECHA_x)
                movimientoY_ruedaDerecha = -joystick_object.get_axis(RUEDA_DERECHA_y)
                if (movimientoX_ruedaDerecha != 0) or (movimientoY_ruedaDerecha != 0):
                    print 'Rueda Derecha, Posicion en x= %f' %movimientoX_ruedaDerecha
                    print 'Rueda Derecha, Posicion en y= %f' %movimientoY_ruedaDerecha
                    comandoPitch = int(movimientoY_ruedaDerecha*MAXIMO_ANGULO) + 90
                    comandoRoll = int(movimientoX_ruedaDerecha*MAXIMO_ANGULO) + 90
                    checksum = comandoPitch + comandoRoll + ord(calibrarYPR)
                    print 'Comando de pitch= %d' %(comandoPitch-90)
                    print 'Comando de roll= %d' %(comandoRoll-90)
                    print 'Modo de ejecucion= %c' %ord(calibrarYPR)
                    print 'Checksum= %d' %checksum
                    
                    EnviarComandoCuadricoptero(puertoSerial, CODIGO_COMANDO, comandoPitch, comandoRoll, calibrarYPR, checksum)
                    

            if evento.type == pygame.JOYBUTTONDOWN:
                estado_boton_1 = joystick_object.get_button(BOTON_1)
                if(estado_boton_1 == 1):
                    codigo = 'K'
                    checksum = incremento_kP_velocidad*multiplicadorConstantes + ord('+') + ord('P')
                    puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                    puertoSerial.write('+')
                    puertoSerial.write('P')
                    EnviarEnteroSerial(puertoSerial,incremento_kP_velocidad*multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,checksum)
                    print("Incrementar proporcional de PItch")
                estado_boton_2 = joystick_object.get_button(BOTON_2)
                if(estado_boton_2 == 1):
                    checksum = incremento_kD_velocidad*multiplicadorConstantes + ord('+') + ord('D')
                    puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                    puertoSerial.write('+')
                    puertoSerial.write('D')
                    EnviarEnteroSerial(puertoSerial,incremento_kD_velocidad*multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,checksum)
                    print("Incrementar derivada de Pitch")
                estado_boton_3 = joystick_object.get_button(BOTON_3)
                if(estado_boton_3 == 1):
                    checksum = incremento_kP_velocidad*multiplicadorConstantes + ord('-') + ord('P')
                    puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                    puertoSerial.write('-')
                    puertoSerial.write('P')
                    EnviarEnteroSerial(puertoSerial,incremento_kP_velocidad*multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,checksum)
                    print("Decrementar proporcional de Pitch")
                estado_boton_4 = joystick_object.get_button(BOTON_4)
                if(estado_boton_4 == 1):
                    codigo = 'K'
                    checksum = incremento_kD_velocidad*multiplicadorConstantes + ord('-') + ord('D')
                    puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                    puertoSerial.write('-')
                    puertoSerial.write('D')
                    EnviarEnteroSerial(puertoSerial,incremento_kD_velocidad*multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,multiplicadorConstantes)
                    EnviarEnteroSerial(puertoSerial,checksum)
                    print("Decrementar derivada de Pitch")
                    
                    
                estado_boton_QUIT = joystick_object.get_button(BOTON_9)
                estado_boton_R1 = joystick_object.get_button(BOTON_6)
                
                print 'Boton 1, Valor %d' %(estado_boton_1)
                print 'Boton 2, Valor %d' %(estado_boton_2)
                print 'Boton 3, Valor %d' %(estado_boton_3)
                print 'Boton 4, Valor %d' %(estado_boton_4)
                print 'Boton R1, Valor %d' %(estado_boton_R1)


codigo = '~'
calibrarYPR = '_'
comandoPitch = 90
comandoRoll = 90
checksum = comandoPitch + comandoRoll + ord(calibrarYPR)
print 'Comando de pitch= %d' %comandoPitch
print 'Comando de roll= %d' %comandoRoll
print 'Modo de ejecucion= %c' %ord(calibrarYPR)
print 'Checksum= %d' %checksum

EnviarComandoCuadricoptero(puertoSerial, codigo, comandoPitch, comandoRoll, calibrarYPR, checksum)
time.sleep(0.01)

codigo = '~'
calibrarYPR = '_'
comandoPitch = 90
comandoRoll = 90
checksum = comandoPitch + comandoRoll + ord(calibrarYPR)
print 'Comando de pitch= %d' %comandoPitch
print 'Comando de roll= %d' %comandoRoll
print 'Modo de ejecucion= %c' %ord(calibrarYPR)
print 'Checksum= %d' %checksum

EnviarComandoCuadricoptero(puertoSerial, codigo, comandoPitch, comandoRoll, calibrarYPR, checksum)
time.sleep(0.01)
    

joystick_object.quit()
#destroy objects and clean up
pygame.joystick.quit()