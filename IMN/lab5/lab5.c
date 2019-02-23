#include <stdio.h>
#include <math.h>

int iter;
double Sp;
#define nx 128
#define ny 128
double V[nx + 1][ny + 1]; double Vs[nx + 1][ny + 1];

int checkTOL(int k, FILE *f){
	double del = 0.2; 
	double TOL = pow(10, -8); 
	double S = 0.0;
	int true_ = 1;
	int false_ = 0;

	for (int i = 0; i < nx; i += k) {
		for (int j = 0; j < ny; j += k) {
			S += (pow(k * del, 2) / 2.) * 
					(pow((V[i+k][j] - V[i][j])/(2. * k * del) 
					+ (V[i+k][j+k]-V[i][j+k])/(2. * k * del), 2) 
					+ pow((V[i][j+k] - V[i][j])/(2. * k * del) 
					+ (V[i+k][j+k] 
					- V[i+k][j])/(2. * k * del), 2));
		}
	}

	fprintf(f, "%d %g\n", iter, S);
	iter++;

	if (fabs((S - Sp)/Sp) < TOL) {
		return false_;
	}

	if (iter == 1){
		Sp = S; 
	 	return true_;
	}

	Sp = S;
	return true_;
}

void wykonaj(int k, FILE *f, FILE *f2){
		double del = 0.2; 
		int iter = 0;
//rownanie Poissona
		do{
			//przepisanie
			for (int i = 0; i < nx + 1; i ++) {
				for (int j = 0; j < ny + 1; j ++) {
					Vs[i][j] = V[i][j];
				}
			}
			//relaksacja
			for (int i = k; i < nx; i += k) {
				for (int j = k; j < ny; j += k) {
					V[i][j] = 1./4. * (Vs[i+k][j] + Vs[i-k][j] + Vs[i][j+k] + Vs[i][j-k]);
				}
			}
		}while(checkTOL(k, f));

		//siatka
			for (int i = k; i < nx + k; i += k) {
				for (int j = k; j < ny + k; j += k)
					fprintf(f2, "%f", V[i][j]);
				fprintf(f2, "\n");
			}

		//zageszczenie 
		for (int i = 0; i < nx; i += k) {
			for (int j = 0; j < ny; j += k) {

				if ((i+k/2. > 0) && (i+k/2. <nx) && (j+k/2. > 0) && (j+k/2. < ny)){
					V[i+k/2][j+k/2] = 1./4. * (V[i][j] + Vs[i+k][j] + V[i][j+k] + Vs[i+k][j+k]);
				}

				if ((i+k > 0) && (i+k < nx) && (j+k/2. > 0) && (j+k/2. < ny)){
					V[i+k][j+k/2] = 1./2. * (V[i+k][j] + V[i+k][j+k]);
				}

				if ((i+k/2. > 0) && (i+k/2. < nx) && (j+k > 0) && (j+k < ny)){
					V[i+k/2][j+k] = 1./2. * (V[i][j+k] + V[i+k][j+k]);
				}

				if ((i+k/2. > 0) && (i+k/2. < nx) && (j > 0) && (j < ny)){
					V[i+k/2][j] = 1./2. * (V[i][j] + V[i+k][j]);
				}

				if ((i > 0) && (i < nx) && (j+k/2. > 0) && (j+k/2. < ny)){
					V[i][j+k/2] = 1./2. * (V[i][j] + V[i][j+k]);
				}
			}
		}	
}	

int main(){
	FILE *f1, *f2, *f3, *f4, *f5, *f6, *f7, *f8, *f9, *f10;
	f1 = fopen("Sk1.dat", "w"); f6 = fopen("Vk1.dat", "w"); 
	f2 = fopen("Sk2.dat", "w"); f7 = fopen("Vk2.dat", "w");
	f3 = fopen("Sk4.dat", "w"); f8 = fopen("Vk4.dat", "w");
	f4 = fopen("Sk8.dat", "w"); f9 = fopen("Vk8.dat", "w");
	f5 = fopen("Sk16.dat", "w"); f10 = fopen("Vk16.dat", "w"); 

	double del = 0.2; 
	double xmax = del * nx;
	double ymax = del * ny;

	//inicjalizacja, warunki brzegowe Dirichleta
	for (int i = 1; i < nx; i++) {
		for (int j = 1; j < ny; j++) {
			V[i][j] = 0.0;
		}
	}

	for(int y = 0; y < ny + 1; y++)
		V[0][y] =  sin(M_PI * del * y / ymax);
	for(int x = 0; x < ny + 1; x++)
		V[x][ny] =  (-1.) * sin(2. * M_PI * del *x / xmax);
	for(int y = 0; y < ny + 1; y++)
		V[nx][y] =  sin(M_PI * del * y / ymax);
	for(int x = 0; x < ny + 1; x++)
		V[x][0] =  sin(2. * M_PI * del * x / xmax);

	wykonaj(16, f1, f6);
	wykonaj(8, f2, f7);
	wykonaj(4, f3, f8);
	wykonaj(2, f4, f9);
	wykonaj(1, f5, f10);

	fclose(f1); fclose(f4); fclose(f5); fclose(f8); fclose(f9);
	fclose(f2); fclose(f3); fclose(f6); fclose(f7); fclose(f10);
}
