#!/usr/bin/env python

from handler_serial import HandlerSerial
from comunicacion_serial.msg import *
import rospy

__MAXIMO_ANGULO_COMANDO = 10
publisher = None
handlerSerial = None
tiempoInicioEjecucion = 0

def callbackEnvioComandoEncendido(mensaje):
    #rospy.loginfo(rospy.get_caller_id()+"I heard %s",data)
    global handlerSerial
    handlerSerial.enviarComandoEncendido(mensaje.encendido)
    
    
def callbackEnvioComandoMovimiento(mensaje):
    #rospy.loginfo(rospy.get_caller_id()+"I heard %s",data)
    global handlerSerial
    handlerSerial.enviarComandoMovimiento(mensaje.comandoPitch + __MAXIMO_ANGULO_COMANDO, mensaje.comandoRoll + __MAXIMO_ANGULO_COMANDO, mensaje.comandoAltura)


def secuenciaRecepcion():
    global tiempoInicioEjecucion
    resultadoAccion = handlerSerial.recibirComandos()
    if (resultadoAccion == True):
	if (handlerSerial.mensajesEstadoRecibidos == 1):
	    tiempoInicioEjecucion = rospy.get_rostime()
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
	estado.tiempoEjecucion = rospy.get_rostime() - tiempoInicioEjecucion
        estado.anguloPitch = handlerSerial.posicionPitch
        estado.anguloRoll = handlerSerial.posicionRoll
        estado.anguloYaw = handlerSerial.posicionYaw
        estado.velocidadPitch = handlerSerial.velocidadPitch
        estado.velocidadRoll = handlerSerial.velocidadRoll
        estado.velocidadYaw = handlerSerial.velocidadYaw
        estado.altura = handlerSerial.altura
        estado.encendido = handlerSerial.encendidoMotores
        estado.mensajesRecibidos = handlerSerial.mensajesEstadoRecibidos
        rospy.loginfo(estado)
        publisher.publish(estado)



def run():
    global publisher, handlerSerial, tiempoInicioEjecucion
    publisher = rospy.Publisher('estado_cuadricoptero', EstadoCuadricoptero, queue_size=10)
    rospy.init_node('ManejadorPuertoSerial', anonymous=True)    
    frecuencia = rospy.Rate(1000)    
    handlerSerial = HandlerSerial(nombrePuerto = "/dev/ttyUSB0", tasaBaudios = 38400)
    handlerSerial.abrirPuerto()
    rospy.Subscriber("encendido_cuadricoptero", ComandoEncendido, callbackEnvioComandoEncendido)
    rospy.Subscriber("movimientos_cuadricoptero", ComandoMovimiento, callbackEnvioComandoMovimiento)
    while not rospy.is_shutdown():
        secuenciaRecepcion()
        frecuencia.sleep()
    handlerSerial.cerrarPuerto()
        
if __name__ == '__main__':
    try:
        run()
    except rospy.ROSInterruptException: pass
    
