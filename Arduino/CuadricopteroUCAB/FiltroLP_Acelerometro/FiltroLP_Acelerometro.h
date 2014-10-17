//Low pass butterworth filter order=5 alpha1=0.08 
class FiltroLP_Acelerometro
{
	public:
		FiltroLP_Acelerometro()
		{
			for(int i=0; i <= 5; i++)
				v[i]=0.0;
		}
	private:
		double v[6];
	public:
		double step(double x) //class II 
		{
			v[0] = v[1];
			v[1] = v[2];
			v[2] = v[3];
			v[3] = v[4];
			v[4] = v[5];
			v[5] = (4.894360861347e-4 * x)
				 + (  0.1923885960 * v[0])
				 + ( -1.2739998815 * v[1])
				 + (  3.4397133108 * v[2])
				 + ( -4.7517753747 * v[3])
				 + (  3.3780113946 * v[4]);
			return 
				 (v[0] + v[5])
				+5 * (v[1] + v[4])
				+10 * (v[2] + v[3]);
		}
};
