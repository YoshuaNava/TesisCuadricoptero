#!/usr/bin/env python

import rospy
from exportador_telemetria_csv.msg import *
from os.path import expanduser

handlerArchivo = None
numMensajes = 0
separadorColumnas = ","
separadorFilas = "\n"
carpetaHome = expanduser("~")

def procesarMensajeTelemetria(mensajeTelemetria):
    global numMensajes, handlerArchivo
    if (numMensajes == 0):
        handlerArchivo = open(carpetaHome + "/telemetria.csv", "w+")
        filaArchivo = "TiempoEjecucion" + separadorColumnas + "AnguloPitch" + separadorColumnas + "AnguloRoll" + separadorColumnas + "AnguloYaw" + separadorColumnas
        filaArchivo = filaArchivo + "G_Pitch" + separadorColumnas + "G_Roll" + separadorColumnas + "G_Yaw" + separadorColumnas
        filaArchivo = filaArchivo + "G_Pitch_filtrada" + separadorColumnas + "G_Roll_filtrada" + separadorColumnas + "G_Yaw_filtrada" + separadorColumnas
        filaArchivo = filaArchivo + "Ax" + separadorColumnas + "Ay" + separadorColumnas + "Az" + separadorColumnas
        filaArchivo = filaArchivo + "Ax_filtrada" + separadorColumnas + "Ay_filtrada" + separadorColumnas + "Az_filtrada" + separadorColumnas
        filaArchivo = filaArchivo + "posZ" + separadorColumnas + "posZ_filtrada" + separadorColumnas + "velZ" + separadorColumnas
        filaArchivo = filaArchivo + "motorDelantero" + separadorColumnas + "motorTrasero" + separadorColumnas + "motorDerecho" + separadorColumnas + "motorIzquierdo" + separadorColumnas
        filaArchivo = filaArchivo + "EstadoEncendido" + separadorColumnas + "MensajesRecibidos" + separadorFilas
        handlerArchivo.write(filaArchivo)
    else:
        filaArchivo = str(mensajeTelemetria.tiempoEjecucion.secs + float(mensajeTelemetria.tiempoEjecucion.nsecs)/1000000000) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.anguloPitch) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.anguloRoll) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.anguloYaw)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.G_Pitch) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.G_Roll) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.G_Yaw)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.G_Pitch_filtrada) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.G_Roll_filtrada) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.G_Yaw_filtrada)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.Ax) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.Ay) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.Az)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.Ax_filtrada) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.Ay_filtrada) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.Az_filtrada)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.posZ) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.posZ_filtrada) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.velZ) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.motorDelantero)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.motorTrasero)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.motorDerecho)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.motorIzquierdo)  + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.encendido) + separadorColumnas
        filaArchivo = filaArchivo + str(mensajeTelemetria.mensajesRecibidos)  + separadorFilas
        handlerArchivo.write(filaArchivo)
    print filaArchivo    
    numMensajes = numMensajes + 1
    
    #rospy.loginfo(mensajePose)



def listener():
    rospy.init_node('exportador_telemetria_csv', anonymous=True)
    rospy.Subscriber('telemetria_total', TelemetriaTotal, procesarMensajeTelemetria)
    rospy.spin()
        
if __name__ == '__main__':
    try:
        listener()
    except rospy.ROSInterruptException:
        if (handlerArchivo != None):
            handlerArchivo.close()
