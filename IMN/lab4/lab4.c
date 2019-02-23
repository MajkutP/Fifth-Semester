#include <stdio.h>
#include <math.h>

double ro1(double x, double y, double xmax, double  ymax, double  xsig, double  ysig, double param){
	return exp(-pow(x - param * xmax, 2)/pow((xsig), 2) - pow(y - 0.5 * ymax, 2)/pow((ysig), 2));
}

double ro2(double x, double y, double xmax, double  ymax, double  xsig, double  ysig, double param){
	return  -exp(-pow(x - param * xmax, 2)/pow((xsig), 2) - pow(y - 0.5 * ymax, 2)/pow((ysig), 2));
}

void RelGlob(double wg, FILE *f, FILE *fPOT, FILE * fBL){
	double Eps = 1.; double del = 0.1;
	int nx = 150; int ny = 100;
	double xmax = del * nx;
	double ymax = del * ny;
	double TOL = pow(10, -8); 
	double V0 = 0.;  double V1 = 10.; double V2 = 0.;
	double xsig = 0.1 * xmax; double ysig = 0.1 * ymax; 
	double param1 = 0.35; double param2 = 0.65;
	int iter = 0;

	double Vs[nx + 1][ny + 1];
	double Vn[nx + 1][ny + 1];
	double Sit1 = 0.; double Sit = 0.;
	for (int i = 0; i < nx + 1; i++){ 
		Vs[i][0] = 10.0;
		for (int j = 1; j < ny + 1; ++j){ 
			Vs[i][j] = 0.0;
		}	
	}

	for (int i = 0; i < nx + 1; i++){ 
		Vn[i][0] = 10.0;
		for (int j = 1; j < ny + 1; ++j){ 
			Vn[i][j] = 0.0;
		}	
	}

	do{
		for (int i = 1; i < nx; i++){ 
			for (int j = 1; j < ny; ++j){ 
				Vn[i][j] = 1/4. * (Vs[i + 1][j] + Vs[i - 1][j] + Vs[i][j + 1] + Vs[i][j - 1]
					+ pow(del, 2) / Eps * (ro1(del * i, del * j, xmax, ymax, xsig, ysig, param1)
					+ ro2(del * i, del * j, xmax, ymax, xsig, ysig, param2)));
			}	
		}
		for (int j = 1; j < ny; j++){
			Vn[0][j] = Vn[1][j];
		}
		for (int j = 1; j < ny; j++){
			Vn[nx][j] = Vn[nx-1][j];
		}		
		for (int i = 0; i < nx + 1; i++){
			for (int j = 0; j < ny + 1; j++){
				Vs[i][j] = (1. - wg) * Vs[i][j] + wg * Vn[i][j];
			}
		}
		Sit1 = Sit;
		Sit = 0.;
		for (int i = 0; i < nx; i++){
			for (int j = 0; j < ny; j++){
				Sit += pow(del, 2) * ((0.5 * pow((Vs[i + 1][j] - Vs[i][j])/del, 2)) 
					+ 0.5 * pow((Vs[i][j + 1] - Vs[i][j])/del, 2)
					- Vs[i][j] * (ro1(del * i, del * j, xmax, ymax, xsig, ysig, param1)
					+ ro2(del * i, del * j, xmax, ymax, xsig, ysig, param2)));
			}
		}
		iter += 1;
		//if(iter == 25) break;
		fprintf(f, "%d %f \n",iter, Sit);  //S = S(it)
	}while(fabs((Sit-Sit1)/Sit1) >= TOL);

	for (int i = 0; i < nx + 1; i++){         //mapa zrelaksowanego potencjalu
		for (int j = 0; j < ny + 1 ; j++)
			fprintf(fPOT, "%f %f %f \n",del * i, del * j, Vn[i][j]);
	}

	for (int i = 0; i < nx + 1; i++){		// blad rozwiazaia
		for (int j = 0; j < ny + 1 ; j++){
			double temp  = pow(del, 2) * Vn[i][j]
				+ (ro1(del * i, del * j, xmax, ymax, xsig, ysig, param1)
				+ ro2(del * i, del * j, xmax, ymax, xsig, ysig, param2))/Eps;
			fprintf(fBL, "%f %f %f \n", del * i, del * j, temp);
		}	
	}	
}

void RelLok(double wl, FILE *f){
	double Eps = 1.; double del = 0.1;
	int nx = 150; int ny = 100;
	double xmax = del * nx;
	double ymax = del * ny;
	double TOL = pow(10, -8);
	double V0 = 0.;  double V1 = 10.; double V2 = 0.;
	double xsig = 0.1 * xmax; double ysig = 0.1 * ymax;
	double param1 = 0.35; double param2 = 0.65;
	int iter = 0; 

	double V[nx + 1][ny + 1];
	double Sit1 = 0.; double Sit = 0.;
	for (int i = 0; i < nx + 1; i++){ 
		V[i][0] = 10.0;
		for (int j = 1; j < ny + 1; ++j){ 
			V[i][j] = 0.0;
		}	
	}

	do{
		for (int i = 1; i < nx; i++){ 
			for (int j = 1; j < ny; ++j){ 
				V[i][j] = (1.- wl) * V[i][j] + (wl/4.) * (V[i + 1][j] + V[i - 1][j] + V[i][j + 1] + V[i][j - 1]
					+ pow(del, 2) / Eps * (ro1(del * i, del * j, xmax, ymax, xsig, ysig, param1)
					+ ro2(del * i, del * j, xmax, ymax, xsig, ysig, param2)));
			}	
		}
		for (int j = 1; j < ny; j++){
			V[0][j] = V[1][j];
		}
		for (int j = 1; j < ny; j++){
			V[nx][j] = V[nx-1][j];
		}		
	
		Sit1 = Sit;
		Sit = 0.;
		for (int i = 0; i < nx; i++){
			for (int j = 0; j < ny; j++){
				Sit += pow(del, 2) * ((0.5 * pow((V[i + 1][j] - V[i][j])/del, 2)) 
					+ 0.5 * pow((V[i][j + 1] - V[i][j])/del, 2)
					- V[i][j] * (ro1(del * i, del * j, xmax, ymax, xsig, ysig, param1)
					+ ro2(del * i, del * j, xmax, ymax, xsig, ysig, param2)));
			}
		}
		iter += 1;
		//if(iter == 25) break;
		fprintf(f, "%d %f \n", iter, Sit);  //S = S(it)
	}while(fabs((Sit-Sit1)/Sit1) >= TOL);	
}

int main(){
	FILE *f1, *f2, *f3, *f4, *f5, *f6, *f7, *f8;
	f1 = fopen("1SOM1.dat", "w"); f5 = fopen("2SOM1.dat", "w"); 
	f2 = fopen("1SOM2.dat", "w"); f6 = fopen("2SOM2.dat", "w");
	f3 = fopen("1POT.dat", "w"); f7 = fopen("2SOM3.dat", "w");
	f4 = fopen("1BL.dat", "w"); f8 = fopen("2SOM4.dat", "w"); 

	double wg1 = 0.6; double wg2 = 1.0;
	double wl = 1.0; double wl2 = 1.4; double wl3 = 1.8; double wl4 = 1.9; 

	RelGlob(wg1, f1, f3, f4);
	RelGlob(wg2, f2, f3, f4);
	RelLok(wl, f5);
	RelLok(wl2, f6);
	RelLok(wl3, f7);
	RelLok(wl4, f8);

	fclose(f1); fclose(f4); fclose(f5); fclose(f8);
	fclose(f2); fclose(f3); fclose(f6); fclose(f7); 
} 