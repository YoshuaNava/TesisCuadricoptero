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

    xaxis = joystick_object.get_axis(0)
    yaxis = joystick_object.get_axis(1)
    wheel = joystick_object.get_axis(2)
    trigger = joystick_object.get_button(0)
    top = joystick_object.get_button(1)
    #from above, you have number of axes and buttons
    #could assign more if your joystick has more
    

    print '%f %f %f %d %d' %(xaxis, yaxis, wheel, trigger, top)
    #print values to console for debugging
    #analog channels (axes) range -1 to 1
    #digital channels (buttons) are 1 or 0
    
    while True:
        eventos = pygame.event.get()
        for evento in eventos:
            if evento.type == pygame.JOYAXISMOTION:                
                movimientoX_trackpad = joystick_object.get_axis(TRACKPAD_x)
                movimientoY_trackpad = -joystick_object.get_axis(TRACKPAD_y)
                if (movimientoX_trackpad != 0):
                    print 'Trackpad, Posicion en x= %f' %movimientoX_trackpad
                if (movimientoY_trackpad != 0):
                    print 'Trackpad, Posicion en y= %f' %movimientoY_trackpad

                movimientoX_ruedaDerecha = joystick_object.get_axis(RUEDA_DERECHA_x)
                movimientoY_ruedaDerecha = -joystick_object.get_axis(RUEDA_DERECHA_y)
                if (movimientoX_ruedaDerecha != 0):
                    print 'Rueda Derecha, Posicion en x= %f' %movimientoX_ruedaDerecha
                if (movimientoY_ruedaDerecha != 0):
                    print 'Rueda Derecha, Posicion en y= %f' %movimientoY_ruedaDerecha

            if evento.type == pygame.JOYBUTTONDOWN:
                print 'Boton %d, Valor %d' %(BOTON_1+1,joystick_object.get_button(BOTON_1))
                print 'Boton %d, Valor %d' %(BOTON_2+1,joystick_object.get_button(BOTON_2))
                print 'Boton %d, Valor %d' %(BOTON_3+1,joystick_object.get_button(BOTON_3))
                print 'Boton %d, Valor %d' %(BOTON_4+1,joystick_object.get_button(BOTON_4))




joystick_object.quit()
#destroy objects and clean up
pygame.joystick.quit()