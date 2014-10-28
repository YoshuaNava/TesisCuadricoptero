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
			v[5] = (1.282581078961e-3 * x)
				 + (  0.1254306222 * v[0])
				 + ( -0.8811300754 * v[1])
				 + (  2.5452528683 * v[2])
				 + ( -3.8060181193 * v[3])
				 + (  2.9754221097 * v[4]);
			return 
				 (v[0] + v[5])
				+5 * (v[1] + v[4])
				+10 * (v[2] + v[3]);
		}
};
