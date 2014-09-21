#!/usr/bin/env python

from handler_serial import HandlerSerial
from comunicacion_serial.msg import *
import rospy

publisher = None
handlerSerial = None

def callbackEnvioComandoEncendido(data):
    rospy.loginfo(rospy.get_caller_id()+"I heard %s",data.data)
    
    
def callbackEnvioComandoMovimiento(data):
    rospy.loginfo(rospy.get_caller_id()+"I heard %s",data.data)


def secuenciaRecepcion():
    resultadoAccion = handlerSerial.recibirComandos()
    if (resultadoAccion == True):
        """
        print "Estado del cuadricoptero:"
        print "Angulo de Yaw = " + str(handlerSerial.posicionYaw)
        print "Angulo de Pitch = " + str(handlerSerial.posicionPitch)
        print "Angulo de Roll = " + str(handlerSerial.posicionRoll)
        print "Velocidad de Yaw = " + str(handlerSerial.velocidadYaw)
        print "Velocidad de Pitch = " + str(handlerSerial.velocidadPitch)
        print "Velocidad de Roll = " + str(handlerSerial.velocidadRoll)
        print "Altura = " + str(handlerSerial.altura)
        print "Mensajes recibidos = " + str(handlerSerial.mensajesEstadoRecibidos)
        print "\n"
        """
        estado = EstadoCuadricoptero()
        estado.anguloPitch = handlerSerial.posicionPitch
        estado.anguloRoll = handlerSerial.posicionPitch
        estado.anguloYaw = handlerSerial.posicionYaw
        estado.velocidadPitch = handlerSerial.velocidadPitch
        estado.velocidadRoll = handlerSerial.velocidadRoll
        estado.velocidadYaw = handlerSerial.velocidadYaw
        estado.altura = handlerSerial.altura
        estado.encendido = 0
        estado.mensajesRecibidos = handlerSerial.mensajesEstadoRecibidos
        rospy.loginfo(estado)
        publisher.publish(estado)



def run():
    global publisher, handlerSerial
    publisher = rospy.Publisher('estado_cuadricoptero', EstadoCuadricoptero, queue_size=10)
    rospy.init_node('ManejadorPuertoSerial', anonymous=True)    
    frecuencia = rospy.Rate(100)    
    handlerSerial = HandlerSerial(nombrePuerto = "/dev/ttyUSB0", tasaBaudios = 38400)
    handlerSerial.abrirPuerto()
    rospy.Subscriber("encendido_cuadricoptero", Encendido, callbackEnvioComandoEncendido)
    rospy.Subscriber("movimientos_cuadricoptero", Movimiento, callbackEnvioComandoMovimiento)    
    while not rospy.is_shutdown():
        secuenciaRecepcion()
        frecuencia.sleep()
    hiloSerial.cerrarPuerto()
        
if __name__ == '__main__':
    try:
        run()
    except rospy.ROSInterruptException: pass
    