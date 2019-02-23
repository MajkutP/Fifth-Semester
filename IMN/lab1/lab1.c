#include <stdio.h>
#include <math.h>

int main(){

	FILE *f1_1, *f1_2, *f1_3;
	FILE *f1_4, *f1_5, *f1_6;
	FILE *f2_1, *f2_2, *f2_3;
	FILE *f2_4, *f2_5, *f2_6;
	FILE *f3_1, *f3_2, *f3_3;
	FILE *f3_4, *f3_5, *f3_6;
	FILE *f4_1, *f4_2, *f4_3, *f4_4;  

	f1_1 = fopen("zad1_1.dat", "w");
	f1_2 = fopen("zad1_2.dat", "w");
	f1_3 = fopen("zad1_3.dat", "w");
	f1_4 = fopen("zad1_4.dat", "w");
	f1_5 = fopen("zad1_5.dat", "w");
	f1_6 = fopen("zad1_6.dat", "w");
	f2_1 = fopen("zad2_1.dat", "w");
	f2_2 = fopen("zad2_2.dat", "w");
	f2_3 = fopen("zad2_3.dat", "w");
	f2_4 = fopen("zad2_4.dat", "w");
	f2_5 = fopen("zad2_5.dat", "w");
	f2_6 = fopen("zad2_6.dat", "w");
	f3_1 = fopen("zad3_1.dat", "w");
	f3_2 = fopen("zad3_2.dat", "w");
	f3_3 = fopen("zad3_3.dat", "w");
	f3_4 = fopen("zad3_4.dat", "w");
	f3_5 = fopen("zad3_5.dat", "w");
	f3_6 = fopen("zad3_6.dat", "w");
	f4_1 = fopen("zad4_1.dat", "w");
	f4_2 = fopen("zad4_2.dat", "w");
	f4_3 = fopen("zad4_3.dat", "w");
	f4_4 = fopen("zad4_4.dat", "w");

	double y0 = 1;
	double ydok = 1;
	double lambda = -1;
	double t = 0;
	
	double y = y0;
	double deltaT1 = 0.01;
	double deltaT2 = 0.1;
	double deltaT3 = 1.0;

 	//2
	double k1;
	double k2;
	double y2 = y0;

	//3
	double h1; 
	double h2;
	double h3;
	double h4;
	double y3 = y0;

	//4
	double del = 10e-4;
	double R = 100.0;
	double L = 0.1;
	double C = 0.001;
	double w0 = 1/sqrt(L*C);
	double T0 = 2*M_PI/w0;
	double Q0 = 0;
	double I0 = 0;

	double V = 10 * sin(w0 * t);
	double w1 = 0.5 * w0;
	double w2 = 0.8 * w0;
	double w3 = 1.0 * w0;
	double w4 = 1.2 * w0;
	double range = 4 * T0;
	double k1q, k1i, k2q, k2i, k3q, k3i, k4q, k4i, Qn, In;

	// 1, 2 ,3
	while(t<5.0){
		t += deltaT1;
		y += deltaT1 * y * lambda;
		ydok = exp(lambda * t);
		fprintf(f1_1, "%f %f\n",t,y);
		fprintf(f1_4, "%f %f\n",t,y-ydok);

		k1 = lambda * y2;
		k2  = lambda * (y2 + deltaT1 * k1);
		y2 += deltaT1/2 * (k1 + k2);
		fprintf(f2_1, "%f %f\n",t,y2);
		fprintf(f2_4, "%f %f\n",t,y2-ydok);

		h1 = lambda * y3;
		h2 = lambda * (y3 + deltaT1/2 * h1);
		h3 = lambda * (y3 + deltaT1/2 * h2);
		h4 = lambda * (y3 + deltaT1 * h3);
		y3 += deltaT1/6 * (h1+2*h2+2*h3+h4);
		fprintf(f3_1, "%f %f\n",t,y3);
		fprintf(f3_4, "%f %f\n",t,y3-ydok);
	}
	y = y0;
	ydok = y0;
	k1 = y0;
	k2 = y0;
	y2 = y0;
	t = 0; 
	h1 = 0;
	h2 = 0;
	h3 = 0;
	y3 = y0;  

	while(t<5.0){
		t += deltaT2;
		y += deltaT2 * y * lambda;
		ydok = exp(lambda * t);
		fprintf(f1_2, "%f %f\n",t,y);
		fprintf(f1_5, "%f %f\n",t,y-ydok);

		k1 = lambda * y2;
		k2  = lambda * (y2 + deltaT2 * k1);
		y2 += deltaT2/2 * (k1 + k2);
		fprintf(f2_2, "%f %f\n",t,y2);
		fprintf(f2_5, "%f %f\n",t,y2-ydok);

		h1 = lambda * y3;
		h2 = lambda * (y3 + deltaT2/2 * h1);
		h3 = lambda * (y3 + deltaT2/2 * h2);
		h4 = lambda * (y3 + deltaT2 * h3);
		y3 += deltaT2/6 * (h1+2*h2+2*h3+h4);
		fprintf(f3_2, "%f %f\n",t,y3);
		fprintf(f3_5, "%f %f\n",t,y3-ydok);
	}
	y = y0;
	ydok = y0;
	k1 = y0;
	k2 = y0;
	y2 = y0;
	t = 0;
	h1 = 0;
	h2 = 0;
	h3 = 0;
	y3 = y0;   


	while(t<5.0){
		t += deltaT3;
		y += deltaT3 * y * lambda;
		ydok = exp(lambda * t);
		fprintf(f1_3, "%f %f\n",t,y);
		fprintf(f1_6, "%f %f\n",t,y-ydok);

		k1 = lambda * y2;
		k2  = lambda * (y2 + deltaT3 * k1);
		y2 += deltaT3/2 * (k1 + k2);
		fprintf(f2_3, "%f %f\n",t,y2);
		fprintf(f2_6, "%f %f\n",t,y2-ydok);

		h1 = lambda * y3;
		h2 = lambda * (y3 + deltaT3/2 * h1);
		h3 = lambda * (y3 + deltaT3/2 * h2);
		h4 = lambda * (y3 + deltaT3 * h3);
		y3 += deltaT3/6 * (h1+2*h2+2*h3+h4);
		fprintf(f3_3, "%f %f\n",t,y3);
		fprintf(f3_6, "%f %f\n",t,y3-ydok);
	}
	y = y0;
	ydok = y0;
	k1 = y0;
	k2 = y0;
	y2 = y0;
	t = 0;
	h1 = 0;
	h2 = 0;
	h3 = 0;
	y3 = y0;    

	//4 dla wv = 1.0 w0
	while (t<range){
		k1q = In;
		k1q =  V/L- 1/(L*C) * Qn - R/L * In;
		k2q = In + del/2 * k1q;
		k2i = 10 * sin(w0 * 1/2*del)/L - 1/(L*C)*(Qn + del/2*k1q)-R/L*(In+del/2*k1i);		
		k3q = In + del/2 * k2i;
		k3i = sin(w0 * 1/2 * del)/L - 1/(L*C) * - R/L*(In+del/2 * k2i);
		k4q = In + del * k3i;
		k4i  = sin(w0 * del)/L - 1/(L*C) * (Qn + del*k3q) - R/L * (In + del*k3i);
		Qn += del/6 * (k1q + 2*k2q + 2*k3q + k4q);
		In += del/6 * (k1i + 2*k2i+ 2*k3i + k4i);
		t += del;

		fprintf(f4_3, "%f %f\n",t,Qn);
	}


	fclose(f1_1); 
	fclose(f1_2);
	fclose(f1_3);
	fclose(f1_4);
	fclose(f1_5);
	fclose(f1_6);
	fclose(f2_1);
	fclose(f2_2);
	fclose(f2_3);
	fclose(f2_4);
	fclose(f2_5);
	fclose(f2_6);
	fclose(f3_1);
	fclose(f3_2);
	fclose(f3_3);
	fclose(f3_4);
	fclose(f3_5);
	fclose(f3_6);
	fclose(f4_1);
	fclose(f4_2);
	fclose(f4_3);
	fclose(f4_4);
}