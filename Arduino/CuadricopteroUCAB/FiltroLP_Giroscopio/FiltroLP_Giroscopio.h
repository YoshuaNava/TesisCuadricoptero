//Low pass butterworth filter order=5 alpha1=0.11111111111111
class FiltroLP_Giroscopio
{
	public:
		FiltroLP_Giroscopio()
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
			v[10] = (1.282636042570e-3 * x)
				 + ( -0.1254306222 * v[0])
				 + (  1.4704234653 * v[1])
				 + ( -7.8421377597 * v[2])
				 + ( 25.0611744663 * v[3])
				 + (-53.1479862213 * v[4])
				 + ( 78.1589265786 * v[5])
				 + (-80.7107042958 * v[6])
				 + ( 57.7692425085 * v[7])
				 + (-27.4087376610 * v[8])
				 + (  7.7752294283 * v[9]);
			return 
				 (v[10] - v[0])
				+5 * (v[2] - v[8])
				+10 * (v[6] - v[4]);
		}
};