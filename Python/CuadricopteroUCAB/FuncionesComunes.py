# -*- coding: utf-8 -*-
import math



def NumDigitos(numero):
    if  numero == 0:
        return 1
    else:
        return int(math.log10(numero))+1
        
        
def EsNumero(numero):
    try:
        float(numero)
        return True
    except Exception:
        return False