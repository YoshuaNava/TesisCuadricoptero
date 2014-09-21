#!/usr/bin/env python

from handler_joystick import HandlerJoystick
from logitech_rumblepad_ii.msg import *
import rospy





def run():
    publisherEncendido = rospy.Publisher('encendido_cuadricoptero', ComandoEncendido, queue_size=10)
    publisherMovimientos = rospy.Publisher('movimientos_cuadricoptero', ComandoMovimiento, queue_size=10)
    rospy.init_node('ManejadorJoystick', anonymous=True)
    frecuencia = rospy.Rate(100)
    handlerJoystick = HandlerJoystick()
    handlerJoystick.detectarJoystick()
    
    while not rospy.is_shutdown():
        handlerJoystick.run()
        if (handlerJoystick.comandoEncendidoEjecutado == True):
            mensajeEncendido = ComandoEncendido()
            mensajeEncendido.encendido = handlerJoystick.motoresEncendidos
            rospy.loginfo("Comando de encendido!")
            rospy.loginfo(mensajeEncendido)
            publisherEncendido.publish(mensajeEncendido)
        if (handlerJoystick.comandoMovimientoEjecutado == True):
            mensajeMovimiento = ComandoMovimiento()
            mensajeMovimiento.comandoPitch = handlerJoystick.comandoPitch
            mensajeMovimiento.comandoRoll = handlerJoystick.comandoRoll
            mensajeMovimiento.comandoAltura = handlerJoystick.comandoAltura
            rospy.loginfo("Comando de movimiento!")
            rospy.loginfo(mensajeMovimiento)
            publisherMovimientos.publish(mensajeMovimiento)
        frecuencia.sleep()
        
if __name__ == '__main__':
    try:
        run()
    except rospy.ROSInterruptException: pass

