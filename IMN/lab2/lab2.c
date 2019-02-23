#include <stdio.h>
#include <math.h>

double f(double u, double beta, double N, double gamma){
    return (beta*N-gamma)*u-beta*pow(u,2);
}

double F1(double U1, double U2, double un, double delt, double a11, double a12, double alpha, double beta){
    return U1 - un - delt*(a11*(alpha*U1-beta*pow(U1,2)) + a12*(alpha*U2-beta*pow(U2,2)));
}

double F2(double U1, double U2, double un, double delt, double a21, double a22, double alpha, double beta){
    return U2 - un - delt*(a21*(alpha*U1-beta*pow(U1,2)) + a22*(alpha*U2-beta*pow(U2,2)));
}

int main(){
	FILE *fPicard_ut, *fNewton_ut, *fRK_ut;
	fPicard_ut = fopen("Picard_ut.dat","w");	
	fNewton_ut = fopen("Newton_ut.dat","w");
	fRK_ut = fopen("RK_ut.dat","w");	

	double N = 500.; //liczba osob, u + z = N
	double beta = 0.001; //czestosc kontaktow 
	double gamma = 0.1; //czas trawania choroby
	double tMax = 100; double tDel = 0.1;
	double u0 = 1.; //jedna osoba zarazona na starcie
	double TOL = pow(10,-6);
	double mikroMax = 20.;
	double alpha = beta*N-gamma; //wspolne dla Picarda i Newtona
	double u_mikro, u_mikro1, u_n;
	
	//Metoda Picarda
    u_n = u0;
	for(double t = 0.; t <= tMax; t += tDel){
        u_mikro = u_n; 
        for(double mikro = 0.; mikro < mikroMax; mikro += 1){
        	u_mikro1 = u_n;
        	u_mikro1 = u_mikro1 + (tDel/2.) * ((alpha*u_n - beta*pow(u_n,2)) + (alpha*u_mikro - beta*pow(u_mikro,2)));
        	u_mikro = u_mikro1;

        	if(fabs(u_mikro1 - u_mikro) < TOL){
        		break;
        	}	
        }
        u_n = u_mikro;
        fprintf(fPicard_ut, "%f %f %f\n", t, u_n, N-u_n);
    }   

 	//Metoda Newtona
    u_n = u0;
	for(double t = 0.; t <= tMax; t += tDel){
        u_mikro = u_n;
        u_mikro1 = u_mikro; 
        for(double mikro = 0.; mikro < mikroMax; mikro += 1){
        	u_mikro1 = u_mikro - (u_mikro-u_n - tDel/2.*((alpha*u_n-beta*pow(u_n,2)) + alpha*u_mikro - beta*pow(u_mikro,2)))/(1.0 - tDel/2. * (alpha - 2*beta*u_mikro));
        	u_mikro = u_mikro1;

        	if(fabs(u_mikro1 - u_mikro) < TOL){
        		break;
        	}	
        }
        u_n = u_mikro;
        fprintf(fNewton_ut, "%f %f %f\n", t, u_n, N-u_n);
    } 

 	//Metoda RK
    double c1 = 1./2. - sqrt(3.)/6.; 
    double c2 = 1./2. + sqrt(3.)/6.;
    double b1 = 1./2.;
    double b2 = 1./2.;
    double a11 = 1./4.;
    double a12 = 1./4. - sqrt(3.)/6.;
    double a22 = 1./4.;
    double a21 = 1./4. + sqrt(3.)/6.;
    double m11 = 0; double m12 = 0; double m21 = 0; double m22 = 0;
    u_n = u0;
    double u_np = 0;
    double U1 = 0;
    double U2 = 0;
    double U1p = 0;
    double U2p = 0;
    double delU1 = 0;
    double delU2 = 0;

    for(double t = 0.; t <= tMax; t += tDel){
        u_np = u_n;
        U1 = u_np;
        U2 = u_np;

         for(double mikro = 0.; mikro < mikroMax; mikro += 1){
            U1p = U1; 
            U2p = U2;

            m11 = 1 - tDel*a11*(alpha-2*beta*U1);
            m12 = -tDel*a12*(alpha-2*beta*U2);
            m21 = -tDel*a21*(alpha-2*beta*U1);
            m22 = 1 - tDel*a22*(alpha-2*beta*U2);

            delU1 = (F2(U1, U2, u_n, tDel, a21, a22, alpha, beta)*m12 - F1(U1, U2, u_n, tDel, a11, a12, alpha, beta)*m22)/(m11*m22-m12*m21);           
            delU1 = (F1(U1, U2, u_n, tDel, a11, a12, alpha, beta)*m21 - F2(U1, U2, u_n, tDel, a21, a22, alpha, beta)*m11)/(m11*m22-m12*m21);

            U1 = U1p + delU1;
            U2 = U2p + delU2;  

            if(fabs(U1 - U1p) < TOL && fabs(U2 - U2p)< TOL){
                break;
            }   
         }   

        u_n = u_np + tDel*(b1*f(U1,beta,N,gamma) + b2*f(U2,beta,N,gamma));
        fprintf(fRK_ut, "%f %f %f\n", t, u_n, N-u_n);
    }

 	fclose(fPicard_ut), fclose(fNewton_ut), fclose(fRK_ut);   
}