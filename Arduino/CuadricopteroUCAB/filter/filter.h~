//Low pass butterworth filter order=5 alpha1=0.088888888888889 
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
			v[5] = (7.736592173272e-4 * x)
				 + (  0.1592697856 * v[0])
				 + ( -1.0832227576 * v[1])
				 + (  3.0148492554 * v[2])
				 + ( -4.3145467989 * v[3])
				 + (  3.1988934205 * v[4]);
			return 
				 (v[0] + v[5])
				+5 * (v[1] + v[4])
				+10 * (v[2] + v[3]);
		}
};
