#!/usr/bin/env python

from handler_joystick import HiloJoystick
from logitech_rumblepad_ii.msg import *
import rospy





def run():
    publisherEncendido = rospy.Publisher('encendido_cuadricoptero', Encendido, queue_size=10)
    publisherMovimientos = rospy.Publisher('movimientos_cuadricoptero', Movimiento, queue_size=10)
    rospy.init_node('ManejadorJoystick', anonymous=True)
    frecuencia = rospy.Rate(100)
    hiloJoystick = HiloJoystick()
    hiloJoystick.detectarJoystick()
    
    while not rospy.is_shutdown():
        hiloJoystick.run()
        if (hiloJoystick.comandoEncendidoEjecutado == True):            
            rospy.loginfo("encendido")
        if (hiloJoystick.comandoMovimientoEjecutado == True):
            rospy.loginfo("movimiento")
        frecuencia.sleep()
        
if __name__ == '__main__':
    try:
        run()
    except rospy.ROSInterruptException: pass

