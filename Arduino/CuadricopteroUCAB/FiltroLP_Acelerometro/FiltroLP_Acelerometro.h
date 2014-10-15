//Low pass butterworth filter order=5 alpha1=0.2 
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
			v[5] = (2.193962068846e-2 * x)
				 + (  0.0112635125 * v[0])
				 + ( -0.1111638406 * v[1])
				 + (  0.3863565586 * v[2])
				 + ( -0.9738493318 * v[3])
				 + (  0.9853252393 * v[4]);
			return 
				 (v[0] + v[5])
				+5 * (v[1] + v[4])
				+10 * (v[2] + v[3]);
		}
};
