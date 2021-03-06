#!/usr/bin/env python

import rospy
from exportador_estado_csv.msg import *
from os.path import expanduser

handlerArchivo = None
numMensajes = 0
separadorColumnas = ","
separadorFilas = "\n"
carpetaHome = expanduser("~")

def procesarMensajeEstado(mensajeEstado):
    global numMensajes, handlerArchivo
    if (numMensajes == 0):
        handlerArchivo = open(carpetaHome + "/estado.csv", "w+")
        filaArchivo = "TiempoEjecucion" + separadorColumnas + "AnguloPitch" + separadorColumnas + "AnguloRoll" + separadorColumnas + "AnguloYaw" + separadorColumnas + "VelocidadPitch" + separadorColumnas + "VelocidadRoll" + separadorColumnas + "VelocidadYaw" + separadorColumnas + "Altura" + separadorColumnas + "EstadoEncendido" + separadorColumnas + "MensajesRecibidos" + separadorFilas
        handlerArchivo.write(filaArchivo)
    else:
        filaArchivo = str(mensajeEstado.tiempoEjecucion.secs + float(mensajeEstado.tiempoEjecucion.nsecs)/1000000000) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.anguloPitch) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.anguloRoll) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.anguloYaw)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.velocidadPitch) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.velocidadRoll) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.velocidadYaw)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.altura) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.encendido) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.mensajesRecibidos)  + separadorFilas
        handlerArchivo.write(filaArchivo)
    print filaArchivo    
    numMensajes = numMensajes + 1
    
    #rospy.loginfo(mensajePose)



def listener():
    rospy.init_node('exportador_estado_csv', anonymous=True)
    rospy.Subscriber('estado_cuadricoptero', EstadoCuadricoptero, procesarMensajeEstado)
    rospy.spin()
        
if __name__ == '__main__':
    try:
        listener()
    except rospy.ROSInterruptException:
        if (handlerArchivo != None):
            handlerArchivo.close()
