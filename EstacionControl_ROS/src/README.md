Estación de control en ROS
==================

(Mejorar)

# Probado con ROS Indigo Igloo.

# Instalación:
# En la carpeta src:
* sudo apt-get install libsdl-image1.2-dev
* cd pygame
* python setup.py build
* sudo python setup.py install



# Ejecución
Pararse en la carpeta raiz (esta), y hacer catkin_make
* EN una terminal ejecutar "roscore"
* Abrir tres terminales, pararse en esta carpeta, y hacer "source devel/setup.bash" en cada una. Luego:
	* Terminal 1: "rosrun comunicacion_serial run.py"
	* Terminal 2: "rosrun logitech_rumblepad_ii run.py"
	* Terminal 3: "rosrun rqt_plot rqt_plot"
		* poner en la barra /estado_cuadricoptero, y presionar ENTER.


Trabajo realizado por Luis Vicens y Yoshua Nava, estudiantes de Ingeniería Informática de la Universidad Católica Andrés Bello.



