//Low pass butterworth filter order=5 alpha1=0.2 
class FiltroLP_Acelerometro
{
	public:
		FiltroLP_Acelerometro()
		{
			for(int i=0; i <= 10; i++)
				v[i]=0.0;
		}
	private:
		double v[11];
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
			v[10] = (1.444012505809e-2 * x)
				 + ( -0.0194702056 * v[0])
				 + (  0.2457944789 * v[1])
				 + ( -1.4178354897 * v[2])
				 + (  5.0684687085 * v[3])
				 + (-12.3805033980 * v[4])
				 + ( 21.5497311933 * v[5])
				 + (-27.2283920008 * v[6])
				 + ( 24.7527859843 * v[7])
				 + (-15.3934447280 * v[8])
				 + (  5.8228425322 * v[9]);
			return 
				 (v[10] - v[0])
				+5 * (v[2] - v[8])
				+10 * (v[6] - v[4]);
		}
};


