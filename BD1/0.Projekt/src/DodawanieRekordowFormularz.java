package com.postgresqlProject;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DodawanieRekordowFormularz {
    public static void display(String tablica){
        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Dodanie rekordu do bazy");

        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10,10,10,10));
        grid.setVgap(8);
        grid.setHgap(10);

        if(tablica.equals("zamowienie")){
            Label label1 = new Label("id_zamowienia:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("id_klienta:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("int");
            GridPane.setConstraints(field2, 1, 1);

            Label label3 = new Label("kwota:");
            GridPane.setConstraints(label3, 0,2);
            TextField field3 = new TextField();
            field3.setPromptText("int");
            GridPane.setConstraints(field3, 1, 2);

            Label label4 = new Label("data_zamowienia:");
            GridPane.setConstraints(label4, 0,3);
            TextField field4 = new TextField();
            field4.setPromptText("dd/mm/rr");
            GridPane.setConstraints(field4, 1, 3);

            Label label5 = new Label("data_odbioru:");
            GridPane.setConstraints(label5, 0,4);
            TextField field5 = new TextField();
            field5.setPromptText("dd/mm/rr");
            GridPane.setConstraints(field5, 1, 4);

            Label label6 = new Label("czy_zrealizowano:");
            GridPane.setConstraints(label6, 0,5);
            TextField field6 = new TextField();
            field6.setPromptText("{0,1}");
            GridPane.setConstraints(field6, 1, 5);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 6);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 6);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.zamowienie (id_zamowienia, id_klienta, kwota, data_zamowienia, data_odbioru, czy_zrealizowano) VALUES (?,?,?,?,?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setInt(2, Integer.parseInt(field2.getText()));
                    pst.setInt(3, Integer.parseInt(field3.getText()));
                    pst.setString(4, field4.getText());
                    pst.setString(5, field5.getText());
                    pst.setInt(6, Integer.parseInt(field6.getText()));
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2, label3, field3, label4, field4, label5, field5, label6, field6);
        }

        if(tablica.equals("klient")){
            Label label1 = new Label("id_klienta:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("imie:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("String");
            GridPane.setConstraints(field2, 1, 1);

            Label label3 = new Label("nazwisko:");
            GridPane.setConstraints(label3, 0,2);
            TextField field3 = new TextField();
            field3.setPromptText("String");
            GridPane.setConstraints(field3, 1, 2);

            Label label4 = new Label("telefon:");
            GridPane.setConstraints(label4, 0,3);
            TextField field4 = new TextField();
            field4.setPromptText("String");
            GridPane.setConstraints(field4, 1, 3);

            Label label5 = new Label("email:");
            GridPane.setConstraints(label5, 0,4);
            TextField field5 = new TextField();
            field5.setPromptText("String");
            GridPane.setConstraints(field5, 1, 4);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 5);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 5);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.klient (id_klienta, imie, nazwisko, telefon, email) VALUES (?,?,?,?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setString(2, field2.getText());
                    pst.setString(3, field3.getText());
                    pst.setString(4, field4.getText());
                    pst.setString(5, field5.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2, label3, field3, label4, field4, label5, field5);
        }

        if(tablica.equals("historia_adres")){
            Label label1 = new Label("data_zmiany_adresu:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("dd/mm/rr");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("id_klienta:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("int");
            GridPane.setConstraints(field2, 1, 1);

            Label label3 = new Label("adres:");
            GridPane.setConstraints(label3, 0,2);
            TextField field3 = new TextField();
            field3.setPromptText("String");
            GridPane.setConstraints(field3, 1, 2);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 3);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 3);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.historia_adres (data_zmiany_adresu, id_klienta, adres) VALUES (?,?,?)");
                    pst.setString(1, field1.getText());
                    pst.setInt(2, Integer.parseInt(field2.getText()));
                    pst.setString(3, field3.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2, label3, field3);
        }

        if(tablica.equals("zamowienie_produkt")){
            Label label1 = new Label("id_produktu:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("id_zamowienia:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("int");
            GridPane.setConstraints(field2, 1, 1);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 2);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 2);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.zamowienie_produkt (id_produktu, id_zamowienia) VALUES (?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setInt(2, Integer.parseInt(field2.getText()));
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2);
        }

        if(tablica.equals("zdjecie_produkt")){
            Label label1 = new Label("id_zdjecia:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("id_produktu:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("int");
            GridPane.setConstraints(field2, 1, 1);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 2);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 2);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.zdjecie_produkt (id_zdjecia, id_produktu) VALUES (?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setInt(2, Integer.parseInt(field2.getText()));
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2);
        }

        if(tablica.equals("produkt")){
            Label label1 = new Label("id_produktu:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label3 = new Label("id_producenta:");
            GridPane.setConstraints(label3, 0,1);
            TextField field3 = new TextField();
            field3.setPromptText("int");
            GridPane.setConstraints(field3, 1, 1);

            Label label4 = new Label("id_dzialu:");
            GridPane.setConstraints(label4, 0,2);
            TextField field4 = new TextField();
            field4.setPromptText("int");
            GridPane.setConstraints(field4, 1, 2);

            Label label5 = new Label("opis:");
            GridPane.setConstraints(label5, 0,3);
            TextField field5 = new TextField();
            field5.setPromptText("String");
            GridPane.setConstraints(field5, 1, 3);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 4);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 4);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.produkt (id_produktu, id_producenta, id_dzialu, opis) VALUES (?,?,?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setInt(2, Integer.parseInt(field3.getText()));
                    pst.setInt(3, Integer.parseInt(field4.getText()));
                    pst.setString(4, field5.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label3, field3, label4, field4, label5, field5);
        }

        if(tablica.equals("dzial")){
            Label label1 = new Label("id_dzialu:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("nazwa_dzialu:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("String");
            GridPane.setConstraints(field2, 1, 1);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 2);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 2);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.dzial (id_dzialu, nazwa_dzialu) VALUES (?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setString(2, field2.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2);
        }

        if(tablica.equals("kategoria")){
            Label label1 = new Label("id_kategorii:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("id_dzialu:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("int");
            GridPane.setConstraints(field2, 1, 1);

            Label label3 = new Label("nazwa_kategorii:");
            GridPane.setConstraints(label3, 0,2);
            TextField field3 = new TextField();
            field3.setPromptText("String");
            GridPane.setConstraints(field3, 1, 2);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 3);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 3);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.kategoria (id_kategorii, id_dzialu, nazwa_kategorii) VALUES (?,?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setInt(2, Integer.parseInt(field2.getText()));
                    pst.setString(3, field3.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2, label3, field3);
        }

        if(tablica.equals("producent")){
            Label label1 = new Label("id_producenta:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("nazwa_producenta:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("String");
            GridPane.setConstraints(field2, 1, 1);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 2);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 2);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.producent (id_producenta, nazwa_producenta) VALUES (?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setString(2, field2.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2);
        }

        if(tablica.equals("zdjecie")){
            Label label1 = new Label("id_zdjecia:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("int");
            GridPane.setConstraints(field1, 1, 0);

            Label label3 = new Label("data_zdjecia:");
            GridPane.setConstraints(label3, 0,1);
            TextField field3 = new TextField();
            field3.setPromptText("dd/mm/rr");
            GridPane.setConstraints(field3, 1, 1);

            Label label4 = new Label("base64:");
            GridPane.setConstraints(label4, 0,2);
            TextField field4 = new TextField();
            field4.setPromptText("String");
            GridPane.setConstraints(field4, 1, 2);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 3);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 3);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.zdjecie (id_zdjecia, data_zdjecia, base64) VALUES (?,?,?)");
                    pst.setInt(1, Integer.parseInt(field1.getText()));
                    pst.setString(2, field3.getText());
                    pst.setString(3, field4.getText());
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label3, field3, label4, field4);
        }

        if(tablica.equals("historia_cen")){
            Label label1 = new Label("data_ceny:");
            GridPane.setConstraints(label1, 0,0);
            TextField field1 = new TextField();
            field1.setPromptText("dd/mm/rr");
            GridPane.setConstraints(field1, 1, 0);

            Label label2 = new Label("id_produktu:");
            GridPane.setConstraints(label2, 0,1);
            TextField field2 = new TextField();
            field2.setPromptText("int");
            GridPane.setConstraints(field2, 1, 1);

            Label label3 = new Label("cena:");
            GridPane.setConstraints(label3, 0,2);
            TextField field3 = new TextField();
            field3.setPromptText("int");
            GridPane.setConstraints(field3, 1, 2);

            Button button = new Button("Wyślij dane");
            GridPane.setConstraints(button, 1, 3);
            Label err = new Label();
            GridPane.setConstraints(err, 0, 3);

            button.setOnAction(e->{
                try {
                    PreparedStatement pst = App.con.prepareStatement("INSERT INTO sklepmuzyczny.historia_cen (data_ceny, id_produktu, cena) VALUES (?,?,?)");
                    pst.setString(1, field1.getText());
                    pst.setInt(2, Integer.parseInt(field2.getText()));
                    pst.setInt(3, Integer.parseInt(field3.getText()));
                    pst.executeUpdate();
                    err.setText("Wysłano dane");
                } catch (SQLException exc) {
                    err.setText("Niepoprawne dane");
                }
            });

            grid.getChildren().addAll(err, button, label1, field1, label2, field2, label3, field3);
        }

        Scene scene = new Scene(grid, 500, 300);
        window.setScene(scene);
        window.showAndWait();
    }
}
