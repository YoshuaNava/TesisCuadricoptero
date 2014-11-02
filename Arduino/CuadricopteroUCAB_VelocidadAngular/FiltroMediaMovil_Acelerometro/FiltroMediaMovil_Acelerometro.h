class FiltroMediaMovil_Acelerometro
{
	public:
		FiltroMediaMovil_Acelerometro()
		{
			numeroVentanas = 20;
			factorAmortiguacion = 1/numeroVentanas;
			for(i=0; i < 20; i++)
				v[i]=0.0;
		}
	private:
		int i;
		double v[20];
		int numeroVentanas;
		double factorAmortiguacion;
		double valorFiltrado;
	public:
		double step(double x) //class II 
		{
			v[0] = v[1];
			v[1] = v[2];
			v[2] = v[3];
			v[3] = v[4];
			v[4] = v[5];
			v[5] = v[6];
			v[6] = v[7];
			v[7] = v[8];
			v[8] = v[9];
			v[9] = v[10];
			v[10] = v[11];
			v[11] = v[12];
			v[12] = v[13];
			v[13] = v[14];
			v[14] = v[15];
			v[15] = v[16];
			v[16] = v[17];
			v[17] = v[18];
			v[18] = v[19];
			v[19] = x;
			valorFiltrado = 0;
			for(i=0; i < 20; i++)
			{
				valorFiltrado += factorAmortiguacion*v[i];
			}
			return valorFiltrado;
		}
};
