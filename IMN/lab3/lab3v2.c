#include <stdio.h>
#include <math.h>

double f(double x, double v){
	return v;
}

double g(double x, double v, double alpha){
	return alpha*(1. - pow(x, 2))*v - x;
}

double F(double x, double xn, double v, double vn, double delT){
	return xn - x - (delT/2.)*(f(x, v) + f(xn, vn));
}

double G(double x, double xn, double v, double vn, double delT, double alpha){
 	return vn - v - (delT/2.)*(g(x, v, alpha) + g(xn, vn, alpha));
}

void metodaTrapezow(double *x, double *v, double delT, double alpha){
	double xnk = *x;
	double vnk = *v;
	double xn = *x;
	double vn = *v;

	double del = pow(10, -10);
	while(!0){
		double a11 = 1.;
		double a12 = -delT/2.;
		double a21 = a12*(-2.*alpha*xnk*vnk - 1.);
		double a22 = 1. - delT/2.*alpha*(1. - pow(xnk, 2));
		double dx = (a22*(-F(xn, xnk, vn, vnk, delT)) - a12*(-G(xn, xnk, vn, vnk, delT, alpha)))/((a11*a22) - (a12*a21));
		double dv = (a11*(-G(xn, xnk, vn, vnk, delT, alpha)) - a21*(-F(xn, xnk, vn, vnk, delT)))/((a11*a22) - (a12*a21));
		xnk = xnk + dx;
		vnk = vnk + dv;

		if((fabs(dx)<del) && (fabs(dv)<del)){
			*x = xnk;
			*v = vnk;
			break;
		}
	}
}

void metodaRK2(double *x, double *v, double delT, double alpha){
	double k1x = *v;
	double k1v = alpha*(1. - pow(*x, 2))*(*v) - *x;
	double k2x = *v + delT * k1v;
	double k2v = alpha*(1. - pow((*x +delT*k1x), 2)) * (*v + delT*k1v) - (*x + delT*k1x);
	double x1 = *x + (delT/2.) * (k1x + k2x);
	double v1 = *v + (delT/2.) * (k1v + k2v);
	*x = x1;
	*v = v1;
}

void Wykonaj(double TOL, FILE *f1, FILE *f2, FILE *f3, FILE *f4, int fun){
	double xn = 0.01; double vn = 0.;
	double t = 0.;  double delT = 1.;
	double S = 0.75; double p = 2;
	double tMax = 40.; double alpha = 5.;
	double Ex = 0.; double Ev = 0.;

	do{
		double xn1t = xn;
		double vn1t = vn;
		if(fun == 1)
			metodaTrapezow(&xn1t, &vn1t, delT, alpha);
		else
			metodaRK2(&xn1t, &vn1t, delT, alpha);
		if(fun == 1)
			metodaTrapezow(&xn1t, &vn1t, delT, alpha);
		else
			metodaRK2(&xn1t, &vn1t, delT, alpha);
		double xn2t = xn;
		double vn2t = vn;
		if(fun == 1)
			metodaTrapezow(&xn2t, &vn2t, 2*delT, alpha);
		else
			metodaRK2(&xn2t, &vn2t, 2*delT, alpha);

		Ex = (xn1t - xn2t)/(pow(2., p) - 1.);
		Ev = (vn1t - vn2t)/(pow(2., p) - 1.);

		double maxExEv;
		if(fabs(Ex) > fabs(Ev)) maxExEv = Ex;
		else maxExEv = Ev;

		if(fabs(maxExEv) < TOL)
		{
			t = t + 2*delT;
			xn = xn1t;
			vn = vn1t;
			fprintf(f1, "%f %f \n",xn, t);
			fprintf(f2, "%f %f \n",vn, t);
			fprintf(f3, "%f %f \n",delT, t);
			fprintf(f4, "%f %f \n",vn, xn);
		}

		delT = pow((S*TOL/fabs(maxExEv)), (1./(p + 1.)))*delT;

	}while(t < tMax);
}



int main(){
	FILE *f1, *f2, *f3, *f4, *f5, *f6, *f7, *f8;
	FILE *f9, *f10, *f11, *f12, *f13, *f14, *f15, *f16;
	f1 = fopen("w1.dat", "w"); f5 = fopen("w5.dat", "w"); f9 = fopen("w9.dat", "w"); f13 = fopen("w13.dat", "w");
	f2 = fopen("w2.dat", "w"); f6 = fopen("w6.dat", "w"); f10 = fopen("w10.dat", "w"); f14 = fopen("w14.dat", "w");
	f3 = fopen("w3.dat", "w"); f7 = fopen("w7.dat", "w"); f11 = fopen("w11.dat", "w"); f15 = fopen("w15.dat", "w");
	f4 = fopen("w4.dat", "w"); f8 = fopen("w8.dat", "w"); f12 = fopen("w12.dat", "w"); f16 = fopen("w16.dat", "w");

	double TOL1 = pow(10, -2); double TOL2 = pow(10, -5);
	int tr = 1;
	int rk2 = 2;

	Wykonaj(TOL1, f1, f2, f3, f4, tr);
	Wykonaj(TOL2, f5, f6, f7, f8, tr);
	Wykonaj(TOL1, f9, f10, f11, f12, rk2);
	Wykonaj(TOL2, f13, f14, f15, f16, rk2);

	fclose(f1); fclose(f4); fclose(f5); fclose(f8); fclose(f9); fclose(f12); fclose(f13); fclose(f16);
	fclose(f2); fclose(f3); fclose(f6); fclose(f7); fclose(f10); fclose(f11); fclose(f14); fclose(f15);
} 