Instalación
==================

(Mejorar)
En la carpeta src:
sudo apt-get install libsdl-image1.2-dev
cd pygame
python setup.py build
sudo python setup.py install


ROS Indigo Igloo
Pararse en la carpeta raiz (esta), y hacer catkin_make
source devel/setup.bash
rosrun comunicacion_serial run.py
rosrun logitech_rumblepad_ii run.py
rosrun rqt_plot rqt_plot
	poner en la barra /estado_cuadricoptero


Trabajo realizado por Luis Vicens y Yoshua Nava, estudiantes de Ingeniería Informática de la Universidad Católica Andrés Bello.



