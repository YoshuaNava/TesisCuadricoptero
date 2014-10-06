#!/usr/bin/env python

import rospy
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
        filaArchivo = "Angulo Pitch" + separadorColumnas + "Angulo Roll" + separadorColumnas + "Angulo Yaw" + separadorColumnas + "Velocidad Pitch" + separadorColumnas + "Velocidad Roll" + separadorColumnas + "Velocidad Yaw" + separadorColumnas + "Altura" + separadorColumnas + "Estado de encendido" + separadorColumnas + "Mensajes Recibidos" + separadorFilas
        handlerArchivo.write(filaArchivo)
    else:
        filaArchivo = str(mensajePose.pose.pose.position.x) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.anguloPitch) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.anguloRoll) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.anguloYaw)  + separadorFilas
        filaArchivo = filaArchivo + str(mensajeEstado.velocidadPitch) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.velocidadRoll) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeEstado.velocidadYaw)  + separadorFilas
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
    print "hola"
    rospy.spin()
        
if __name__ == '__main__':
    try:
        listener()
    except rospy.ROSInterruptException:
        if (handlerArchivo != None):
            handlerArchivo.close()
