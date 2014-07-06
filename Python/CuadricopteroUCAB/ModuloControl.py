# -*- coding: utf-8 -*-

import pygame
import pygame.display
import pygame.joystick
import time
import ModuloSerial as Serial

__BOTON_1 = 0
__BOTON_2 = 1
__BOTON_3 = 2
__BOTON_4 = 3
__BOTON_5 = 4
__BOTON_6 = 5
__BOTON_7 = 6
__BOTON_8 = 7
__BOTON_9 = 8
__BOTON_10 = 9
__BOTON_11 = 10
__BOTON_10 = 11
__TRACKPAD_x = 0
__TRACKPAD_y = 1
__RUEDA_DERECHA_x = 2
__RUEDA_DERECHA_y = 3
__RUEDA_IZQUIERDA = 4

__CODIGO_MOVIMIENTO = 'M'
__CODIGO_CONSTANTES = 'K'
__CODIGO_APAGAR = 'Z'

__multiplicadorConstantes = 1000

calibrarYPR = 'R'
MAXIMO_ANGULO = 90





    
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



def Ejecutar(puertoSerial):
    
    pygame.display.init()
    
    
    joystick_object = DetectarJoystick()
    
    if (joystick_object != None):
        estado_boton_QUIT = joystick_object.get_button(__BOTON_9)    
        
        while (estado_boton_QUIT == 0):
            eventos = pygame.event.get()
            for evento in eventos:
                if evento.type == pygame.JOYAXISMOTION:                
                    movimientoX_trackpad = joystick_object.get_axis(__TRACKPAD_x)
                    movimientoY_trackpad = -joystick_object.get_axis(__TRACKPAD_y)
                    if (movimientoX_trackpad != 0):
                        print 'Trackpad, Posicion en x= %f' %round(movimientoX_trackpad)
                    if (movimientoY_trackpad != 0):
                        print 'Trackpad, Posicion en y= %f' %movimientoY_trackpad
    
                    movimientoX_ruedaDerecha = joystick_object.get_axis(__RUEDA_DERECHA_x)
                    movimientoY_ruedaDerecha = -joystick_object.get_axis(__RUEDA_DERECHA_y)
                    if (movimientoX_ruedaDerecha != 0) or (movimientoY_ruedaDerecha != 0):
                        print 'Rueda Derecha, Posicion en x= %f' %movimientoX_ruedaDerecha
                        print 'Rueda Derecha, Posicion en y= %f' %movimientoY_ruedaDerecha
                        comandoPitch = int(movimientoY_ruedaDerecha*MAXIMO_ANGULO) + 90
                        comandoRoll = int(movimientoX_ruedaDerecha*MAXIMO_ANGULO) + 90
                        checksum = comandoPitch + comandoRoll
                        print 'Comando de pitch= %d' %(comandoPitch-90)
                        print 'Comando de roll= %d' %(comandoRoll-90)
                        #print 'Modo de ejecucion= %c' %ord(calibrarYPR)
                        print 'Checksum= %d' %checksum
                        
                        Serial.EnviarComandoCuadricoptero(puertoSerial, __CODIGO_MOVIMIENTO, comandoPitch, comandoRoll, checksum)
                        
    
"""                if evento.type == pygame.JOYBUTTONDOWN:
                    estado_boton_1 = joystick_object.get_button(__BOTON_1)
                    if(estado_boton_1 == 1):
                        codigo = 'K'
                        checksum = incremento_kP_velocidad*__multiplicadorConstantes + ord('+') + ord('P')
                        puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                        puertoSerial.write('+')
                        puertoSerial.write('P')
                        Serial.EnviarEnteroSerial(puertoSerial,incremento_kP_velocidad*multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,__multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,checksum)
                        print("Incrementar proporcional de PItch")
                    estado_boton_2 = joystick_object.get_button(__BOTON_2)
                    if(estado_boton_2 == 1):
                        checksum = incremento_kD_velocidad*multiplicadorConstantes + ord('+') + ord('D')
                        puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                        puertoSerial.write('+')
                        puertoSerial.write('D')
                        Serial.EnviarEnteroSerial(puertoSerial,incremento_kD_velocidad*multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,__multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,checksum)
                        print("Incrementar derivada de Pitch")
                    estado_boton_3 = joystick_object.get_button(__BOTON_3)
                    if(estado_boton_3 == 1):
                        checksum = incremento_kP_velocidad*multiplicadorConstantes + ord('-') + ord('P')
                        puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                        puertoSerial.write('-')
                        puertoSerial.write('P')
                        Serial.EnviarEnteroSerial(puertoSerial,incremento_kP_velocidad*multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,__multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,checksum)
                        print("Decrementar proporcional de Pitch")
                    estado_boton_4 = joystick_object.get_button(__BOTON_4)
                    if(estado_boton_4 == 1):
                        codigo = 'K'
                        checksum = incremento_kD_velocidad*multiplicadorConstantes + ord('-') + ord('D')
                        puertoSerial.write(CODIGO_INCREMENTO_CONSTANTES)
                        puertoSerial.write('-')
                        puertoSerial.write('D')
                        Serial.EnviarEnteroSerial(puertoSerial,incremento_kD_velocidad*multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,__multiplicadorConstantes)
                        Serial.EnviarEnteroSerial(puertoSerial,checksum)
                        print("Decrementar derivada de Pitch")"""
                        
                        
                    estado_boton_QUIT = joystick_object.get_button(__BOTON_9)
                    estado_boton_R1 = joystick_object.get_button(__BOTON_6)
                    
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
    
    Serial.EnviarComandoCuadricoptero(puertoSerial, codigo, comandoPitch, comandoRoll, calibrarYPR, checksum)
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
    
    Serial.EnviarComandoCuadricoptero(puertoSerial, codigo, comandoPitch, comandoRoll, calibrarYPR, checksum)
    time.sleep(0.01)
        
    
    joystick_object.quit()
    #destroy objects and clean up
    pygame.joystick.quit()