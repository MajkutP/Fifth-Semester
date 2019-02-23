#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define del 0.01
#define ro 1
#define mi 1
#define nx 200
#define ny 90
#define i1 50
#define j1 55
#define MAX 20000

#define  yn  del * ny
double yj = del * j1;
int j2 = j1 + 2;

double om;
double kontr_bledu; 

double policzQ(double Q){
	double res = Q * (((pow(yn, 3) - pow(yj, 3) - 3*yj*pow(yn, 2) + 3*pow(yj, 2)*yn))
		/pow(yn,3));
	return res;
}

void WBphi(double Q, double phi[nx+1][ny+1]){
	double Qwy = policzQ(Q);

	for (int j = j1; j < ny + 1; j++)
		phi[0][j] = Q/(2*mi) * 
			(pow(del*j, 3)/3. - pow(del*j, 2)/2.*(yj+yn) + del*j*yj*yn);
	
	for (int j = 0; j < ny + 1; j++)
		phi[nx][j] = Qwy/(2.*mi) 
			* (pow(del*j, 3)/3. - (pow(del*j, 2)/2.)*yn)
			+ (Q*pow(yj, 2)*(-yj+3.*yn)) / (12.*mi); 
	
	for (int i = 1; i < nx; i++)
		phi[i][ny] = phi[0][ny];

	for (int i = i1; i < nx; i++)
		phi[i][0] = phi[0][j1];
	
	for (int j = 1; j < j1 + 1; j++)
		phi[i1][j] = phi[0][j1];
	
	for (int i = 1; i < i1 + 1; i++)
		phi[i][j1] = phi[0][j1];
}

void WBdzeta(double Q, double dzeta[nx+1][ny+1], double phi[nx+1][ny+1]){
	double Qwy = policzQ(Q);
	
	for (int j = j1; j < ny + 1 ; j++)
		dzeta[0][j] = Q/(2.*mi) * (2*del*j-yj-yn);
	
	for (int j = 0; j < ny + 1; j++)
		dzeta[nx][j] = Qwy/(2*mi) * (2*del*j-yn); 
	
	for (int i = 1; i < nx; i++)
		dzeta[i][ny] = 2./(pow(del, 2)) * (phi[i][ny-1]-phi[i][ny]);
	
	for (int i = i1+1; i < nx; i++)
		dzeta[i][0] = 2./(pow(del, 2)) * (phi[i][1]-phi[i][0]);
	
	for (int j = 1; j < j1; j++)
		dzeta[i1][j] = 2./(pow(del, 2)) * (phi[i1+1][j]-phi[i1][j]);
	
	for (int i=1; i < i1 + 1; i++)
		dzeta[i][j1] = 2./(pow(del, 2)) * (phi[i][j1+1]-phi[i][j1]);
	
		dzeta[i1][j1] = 0.5 * (phi[i1-1][j1] + phi[i1][j1-1]);
}	

void NS(double Q, double dzeta[nx+1][ny+1], double phi[nx+1][ny+1], FILE *f){
	WBphi(Q, phi);

	for(int IT = 1; IT < MAX + 1; IT++){
		if(IT < 2000)
			om = 0;
		else
			om = 1;

		for(int i = 1; i < nx; i++){
			for(int j = 1; j < ny; j++){
				if(i > i1 || j > j1){ //((!(j == j1 && i <= i1) && !(i == i1 && j <= j1)))
					phi[i][j] = 1/4. * (phi[i+1][j]+phi[i-1][j]+phi[i][j+1]+phi[i][j-1] - pow(del, 2)*dzeta[i][j]);
 					dzeta[i][j] = 1./4. * (dzeta[i+1][j]+dzeta[i-1][j]+dzeta[i][j+1]+dzeta[i][j-1])
 					 - om*(ro/(16.*mi)) * ((phi[i][j+1]-phi[i][j-1])*(dzeta[i+1][j]-dzeta[i-1][j]) 
 					 	- (phi[i+1][j] - phi[i-1][j])*(dzeta[i][j+1] - dzeta[i][j-1]));
				}
			}
		}

		WBdzeta(Q, dzeta, phi);	
		kontr_bledu = 0.;
		for(int i = 1; i < nx; i++)
			kontr_bledu += phi[i+1][j2]+phi[i-1][j2]+phi[i][j2+1]+phi[i][j2-1]
			-4.*phi[i][j2]-pow(del, 2)*dzeta[i][j2];
	}

	for (int i = 0 ; i < nx + 1; ++i){
    	for (int j = 0; j < ny + 1; ++j){
    		double u = 0.;
    		double v = 0.;
    		u = (phi[i][j+1] - phi[i][j-1])/(2*del);
    		v = -(phi[i+1][j] - phi[i-1][j])/(2*del);

    		if(i > i1 || j > j1)
   				fprintf(f, "%f %f %f %f %f %f\n", i*del, j*del, phi[i][j], dzeta[i][j], u, v);
   			else 
   				fprintf(f, "%f %f %f %f %f %f\n", i*del, j*del, phi[i1][j1], dzeta[i1][j1], u, v);
     	}
	}
}	

int main(){
	FILE *ff1, *ff2, *ff3; 
	ff1 = fopen("1.dat", "w"); 
	ff2 = fopen("2.dat", "w");
	ff3 = fopen("3.dat", "w");

	double phi[nx+1][ny+1]; double dzeta[nx+1][ny+1];
	for(int i = 0; i <nx ; i++){
		for(int j = 0; j < ny; j++){
			phi[i][j] = 0.;
			dzeta[i][j] = 0.;
		}
	}

	NS(-1000., phi, dzeta, ff1);
	NS(-4000., phi, dzeta, ff2);
	NS(4000., phi, dzeta, ff3);

	fclose(ff1);
	fclose(ff2);
	fclose(ff3);
}	
