#!/usr/bin/env python

from handler_serial import HandlerSerial
from comunicacion_serial.msg import *
import rospy

__MAXIMO_ANGULO_COMANDO = 45
publisherEstado = None
publisherTelemetria = None
handlerSerial = None
tiempoInicioEjecucion = 0
__CODIGO_MENSAJE_ESTADO = 7
__CODIGO_MENSAJE_TELEMETRIA_TOTAL = 8

def callbackEnvioComandoEncendido(mensaje):
    #rospy.loginfo(rospy.get_caller_id()+"I heard %s",data)
    global handlerSerial
    handlerSerial.enviarComandoEncendido(mensaje.encendido)
    
    
def callbackEnvioComandoMovimiento(mensaje):
    #rospy.loginfo(rospy.get_caller_id()+"I heard %s",data)
    global handlerSerial
    handlerSerial.enviarComandoMovimiento(mensaje.comandoPitch + __MAXIMO_ANGULO_COMANDO, mensaje.comandoRoll + __MAXIMO_ANGULO_COMANDO, mensaje.comandoAltura)


def secuenciaRecepcion():
    global tiempoInicioEjecucion, publisherEstado, publisherTelemetria, handlerSerial, __CODIGO_MENSAJE_ESTADO, __CODIGO_MENSAJE_TELEMETRIA_TOTAL
    resultadoAccion = handlerSerial.recibirComandos()
    if (resultadoAccion == True):
	if (handlerSerial.mensajesRecibidos == 1):
	    tiempoInicioEjecucion = rospy.get_rostime()
        if (handlerSerial.ultimoComandoRecibido == __CODIGO_MENSAJE_ESTADO):
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
            estado.anguloPitch = handlerSerial.anguloPitch
            estado.anguloRoll = handlerSerial.anguloRoll
            estado.anguloYaw = handlerSerial.anguloYaw
            estado.velocidadPitch = handlerSerial.G_Pitch
            estado.velocidadRoll = handlerSerial.G_Roll
            estado.velocidadYaw = handlerSerial.G_Yaw
            estado.altura = handlerSerial.posZ
            estado.encendido = handlerSerial.encendidoMotores
            estado.mensajesRecibidos = handlerSerial.mensajesRecibidos
            rospy.loginfo(estado)
            publisherEstado.publish(estado)
        if (handlerSerial.ultimoComandoRecibido == __CODIGO_MENSAJE_TELEMETRIA_TOTAL):
            telemetria = TelemetriaTotal()
            telemetria.tiempoEjecucion = rospy.get_rostime() - tiempoInicioEjecucion
            telemetria.anguloPitch = handlerSerial.anguloPitch
            telemetria.anguloRoll = handlerSerial.anguloRoll
            telemetria.anguloYaw = handlerSerial.anguloYaw
            telemetria.G_Pitch = handlerSerial.G_Pitch
            telemetria.G_Roll = handlerSerial.G_Roll
            telemetria.G_Yaw = handlerSerial.G_Yaw
            telemetria.G_Pitch_filtrada = handlerSerial.G_Pitch_filtrada
            telemetria.G_Roll_filtrada = handlerSerial.G_Roll_filtrada
            telemetria.G_Yaw_filtrada = handlerSerial.G_Yaw_filtrada
            telemetria.Ax = handlerSerial.Ax
            telemetria.Ay = handlerSerial.Ay
            telemetria.Az = handlerSerial.Az
            telemetria.Ax_filtrada = handlerSerial.Ax_filtrada
            telemetria.Ay_filtrada = handlerSerial.Ay_filtrada
            telemetria.Az_filtrada = handlerSerial.Az_filtrada
            telemetria.posZ = handlerSerial.posZ
            telemetria.posZ_filtrada = handlerSerial.posZ_filtrada
            telemetria.velZ = handlerSerial.velZ
            telemetria.motorDelantero = handlerSerial.motorDelantero
            telemetria.motorTrasero = handlerSerial.motorTrasero
            telemetria.motorDerecho = handlerSerial.motorDerecho
            telemetria.motorIzquierdo = handlerSerial.motorIzquierdo
            telemetria.encendido = handlerSerial.encendidoMotores
            telemetria.mensajesRecibidos = handlerSerial.mensajesRecibidos
            rospy.loginfo(telemetria)
            publisherTelemetria.publish(telemetria)            





def run():
    global publisherEstado, publisherTelemetria, handlerSerial, tiempoInicioEjecucion
    publisherEstado = rospy.Publisher('estado_cuadricoptero', EstadoCuadricoptero, queue_size=10)
    publisherTelemetria = rospy.Publisher('telemetria_total', TelemetriaTotal, queue_size=10)
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
    
