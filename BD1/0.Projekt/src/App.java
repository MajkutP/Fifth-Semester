package com.postgresqlProject;

import java.sql.Connection;
import java.sql.DriverManager;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import javafx.application.Application;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class App extends Application {
    private static int lport;
    private static String rhost;
    public static Connection con = null;

    private static void sshConnection(){
        String user = "6majkutp";
        String password = "17061997p";
        String host = "pascal.fis.agh.edu.pl";
        int port=22;
        try
        {
            JSch jsch = new JSch();
            Session session = jsch.getSession(user, host, port);
            lport = 8001;
            rhost = "localhost";
            int rport = 5432;
            session.setPassword(password);
            session.setConfig("StrictHostKeyChecking", "no");
            session.connect();
            int assinged_port=session.setPortForwardingL(lport, rhost, rport);
        }
        catch(Exception e){System.err.print(e);}
    }

    public static void main(String[] args) {
        try{
            sshConnection();
        } catch(Exception ex){
            ex.printStackTrace();
        }

        String driver = "org.postgresql.Driver";
        String url = "jdbc:postgresql://" + rhost +":" + lport + "/";
        String db = "u6majkutp";
        String dbUser = "u6majkutp";
        String dbPasswd = "6majkutp";
        String schema = "?searchpath=sklepmuzyczny";
        try{
            Class.forName(driver);
            con = DriverManager.getConnection(url+db, dbUser, dbPasswd);
            launch(args);
        }
        catch (Exception e){
            System.out.println("Nie udało się połączyć z bazą danych");
        }
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        primaryStage.setTitle("Sklep Muzyczny");

        Button dodajRekord = new Button(); dodajRekord.setText("Dodaj rekord");
        Button wczytajTablice = new Button(); wczytajTablice.setText("Wczytaj dane");
        Button pobierzRaport = new Button(); pobierzRaport.setText("Pobierz raport");
        dodajRekord.setOnAction( e -> DodawanieRekordowListaTablic.display());
        wczytajTablice.setOnAction( e -> WczytywanieTablicListaTablic.display());
        pobierzRaport.setOnAction( e -> PobieranieRaportowWybor.display());

        VBox layout = new VBox(10);
        layout.getChildren().addAll(dodajRekord, wczytajTablice, pobierzRaport);
        layout.setAlignment(Pos.CENTER);

        Scene scene = new Scene(layout, 300, 200);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

}
