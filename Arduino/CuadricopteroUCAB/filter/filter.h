//Low pass butterworth filter order=5 alpha1=0.33333333333333 
class filter
{
	public:
		filter()
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
			v[5] = (1.654233557244e-1 * x)
				 + ( -0.0272522739 * v[0])
				 + ( -0.2299491201 * v[1])
				 + ( -0.8048818948 * v[2])
				 + ( -1.5866151829 * v[3])
				 + ( -1.6448489114 * v[4]);
			return 
				 (v[0] + v[5])
				+5 * (v[1] + v[4])
				+10 * (v[2] + v[3]);
		}
};
