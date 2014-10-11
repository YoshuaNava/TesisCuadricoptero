//Band pass butterworth filter order=5 alpha1=0.0006 alpha2=0.0011 
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
			v[10] = (5.734650095996e-6 * x)
				 + ( -0.9898850907 * v[0])
				 + (  9.9087853893 * v[1])
				 + (-44.6344186433 * v[2])
				 + (119.1452872131 * v[3])
				 + (-208.7153921384 * v[4])
				 + (250.7128491912 * v[5])
				 + (-209.1402013075 * v[6])
				 + (119.6307858377 * v[7])
				 + (-44.9075138990 * v[8])
				 + (  9.9897034477 * v[9]);
			return 
				 (v[10] - v[0])
				+5 * (v[2] - v[8])
				+10 * (v[6] - v[4]);
		}
};