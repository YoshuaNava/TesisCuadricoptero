//Low pass butterworth filter order=5 alpha1=0.11111111111111
class FiltroLP_Giroscopio
{
	public:
		FiltroLP_Giroscopio()
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
			v[5] = (2.004152172688e-3 * x)
				 + (  0.0984430331 * v[0])
				 + ( -0.7135520098 * v[1])
				 + (  2.1372530517 * v[2])
				 + ( -3.3387180793 * v[3])
				 + (  2.7524411348 * v[4]);
			return 
				 (v[0] + v[5])
				+5 * (v[1] + v[4])
				+10 * (v[2] + v[3]);
		}
};