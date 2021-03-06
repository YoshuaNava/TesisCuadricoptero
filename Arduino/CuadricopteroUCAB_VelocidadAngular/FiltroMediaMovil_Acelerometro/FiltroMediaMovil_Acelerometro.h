class FiltroMediaMovil_Acelerometro
{
	public:
		FiltroMediaMovil_Acelerometro()
		{
			numeroVentanas = 40;
			factorAmortiguacion =  1/((double) numeroVentanas);
			for(i=0; i < numeroVentanas; i++)
			{
				v[i]=0.0;
			}
		}
	private:
		int i;
		double v[40];
		int numeroVentanas;
		double factorAmortiguacion;
		double valorFiltrado;
	public:
		double step(double x) //class II 
		{
			for(i=0; i < numeroVentanas-1; i++)
			{
				v[i] = v[i+1];
			}
			v[numeroVentanas-1] = x;
			valorFiltrado = 0;
			for(i=0; i < numeroVentanas; i++)
			{
				valorFiltrado += (double) factorAmortiguacion*v[i];
			}
			return valorFiltrado;
		}
};
