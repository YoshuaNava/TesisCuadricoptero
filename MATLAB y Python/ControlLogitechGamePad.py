import pygame
import pygame.display
import pygame.joystick
from pygame.locals import *

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
RUEDA_IZQUIERDA = 2

pygame.display.init()

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
                if (movimientoX_ruedaDerecha != 0):
                    print 'Rueda Derecha, Posicion en x= %f' %movimientoX_ruedaDerecha
                if (movimientoY_ruedaDerecha != 0):
                    print 'Rueda Derecha, Posicion en y= %f' %movimientoY_ruedaDerecha

            if evento.type == pygame.JOYBUTTONDOWN:
                estado_boton_1 = joystick_object.get_button(BOTON_1)
                estado_boton_2 = joystick_object.get_button(BOTON_2)
                estado_boton_3 = joystick_object.get_button(BOTON_3)
                estado_boton_4 = joystick_object.get_button(BOTON_4)

                estado_boton_QUIT = joystick_object.get_button(BOTON_9)
                estado_boton_START = joystick_object.get_button(BOTON_10)
                
                print 'Boton 1, Valor %d' %(estado_boton_1)
                print 'Boton 2, Valor %d' %(estado_boton_2)
                print 'Boton 3, Valor %d' %(estado_boton_3)
                print 'Boton 4, Valor %d' %(estado_boton_4)
                print 'Boton START, Valor %d' %(estado_boton_START)




joystick_object.quit()
#destroy objects and clean up
pygame.joystick.quit()