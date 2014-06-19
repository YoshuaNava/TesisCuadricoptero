"""
ldr.py
 
Display analog data from Arduino using Python (matplotlib)
 
Author: Mahesh Venkitachalam
Website: electronut.in
"""
 
import sys, serial, argparse
import numpy as np
from time import sleep
from collections import deque
 
import matplotlib.pyplot as plt
import matplotlib.animation as animation
 
# plot class
class AnalogPlot:
    # constr
    def __init__(self, strPort, maxLen):
        # open serial port
        self.ser = serial.Serial(strPort,115200)
         
        self.ax = deque([0.0]*maxLen)
        self.ay = deque([0.0]*maxLen)
        self.az = deque([0.0]*maxLen)
        self.aw = deque([0.0]*maxLen)
        self.maxLen = maxLen
     
    # add to buffer
    def addToBuf(self, buf, val):
        if len(buf) < self.maxLen:
            buf.append(val)
        else:
            buf.pop()
            buf.appendleft(val)
     
    # add data
    def add(self, data):
        assert(len(data) == 2)
        self.addToBuf(self.ax, data[0])
        self.addToBuf(self.ay, data[1])
        self.addToBuf(self.az, data[1])
        self.addToBuf(self.aw, data[1])
     
    # update plot
    def update(self, frameNum, a0, a1):
        try:
            line = self.ser.readline()
            data = [float(val) for val in line.split()]
            # print data
            if(len(data) == 4):
                self.add(data)
                a0.set_data(range(self.maxLen), self.ax)
                a1.set_data(range(self.maxLen), self.ay)
                a2.set_data(range(self.maxLen), self.az)
                a3.set_data(range(self.maxLen), self.aw)
        except ValueError:
            print line
        except KeyboardInterrupt:
            print('exiting')
        finally:
            self.ser.flushInput()
        return a0,
     
    # clean up
    def close(self):
        # close serial
        self.ser.flush()
        self.ser.close()
     
    # main() function
def main():
        # expects 1 arg - serial port string
        if(len(sys.argv) != 2):
            print 'Example usage: python showdata.py "/dev/tty.usbmodem411"'
            exit(1)
            
        #strPort = '/dev/tty.usbserial-A7006Yqh'
        strPort = sys.argv[1];
        
         
        print('reading from serial port %s...' % strPort)
         
        # plot parameters
        analogPlot = AnalogPlot(strPort, 100)
         
        print('plotting data...')
         
        # set up animation
        fig = plt.figure()
        ax = plt.axes(xlim=(0, 100), ylim=(-91, 91))
        a0, = ax.plot([], [])
        a1, = ax.plot([], [])
        a2, = ax.plot([], [])
        a3, = ax.plot([], [])
        anim = animation.FuncAnimation(fig, analogPlot.update,
                                       fargs=(a0, a1, a2, a3),
                                        interval=50)
         
        # show plot
        plt.show()
        # clean up
        analogPlot.close()
         
        print('exiting.')
 
# call main
if __name__ == '__main__':
    main()