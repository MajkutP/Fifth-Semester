package com.postgresqlProject;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.sql.SQLException;

public class PobieranieRaportowWybor {
    public static void display() {
        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Wybór raportu");

        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10,10,10,10));
        grid.setVgap(8);
        grid.setHgap(10);

        Button Historia_Zamowien = new Button("Historia zamówień");
        Button ilosc_przeprowadzonych_transakcji = new Button("(1) Ilosc (nie)przeprowadzonych transakcji");
        Button  produkty_ponizej_danej_kwoty = new Button("(2) Produkty ponizej danej kwoty");
        Button producent_statystyki_sprzedazy = new Button("(3) Producent statystyki sprzedazy");

        Label arg1 = new Label("(1) Stan realizacji zamówienia:");
        TextField field1 = new TextField();
        field1.setPromptText("{0,1}");

        Label arg2 = new Label("(2) Kwota:");
        TextField field2 = new TextField();
        field2.setPromptText("int");

        Label arg3 = new Label("(2) Producent:");
        TextField field3 = new TextField();
        field3.setPromptText("String");

        GridPane.setConstraints(Historia_Zamowien, 1, 4);
        GridPane.setConstraints(ilosc_przeprowadzonych_transakcji, 0, 3);
        GridPane.setConstraints(produkty_ponizej_danej_kwoty, 1, 3);
        GridPane.setConstraints(producent_statystyki_sprzedazy, 0, 4);
        GridPane.setConstraints(arg1, 0, 0);
        GridPane.setConstraints(field1, 1, 0);
        GridPane.setConstraints(arg2, 0, 1);
        GridPane.setConstraints(field2, 1, 1);
        GridPane.setConstraints(arg3, 0, 2);
        GridPane.setConstraints(field3, 1, 2);

        Historia_Zamowien.setOnAction( e -> {
            try {
                PobieranieRaportowWidok.display("Historia_Zamowien", 0, 0, null);
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            window.close();
        });

        ilosc_przeprowadzonych_transakcji.setOnAction( e -> {
            try {
                PobieranieRaportowWidok.display("ilosc_przeprowadzonych_transakcji", Integer.parseInt(field1.getText()), 0, null);
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            window.close();
        });

        produkty_ponizej_danej_kwoty.setOnAction( e -> {
            try {
                PobieranieRaportowWidok.display("produkty_ponizej_danej_kwoty", 0, Integer.parseInt(field2.getText()), null);
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            window.close();
        });

        producent_statystyki_sprzedazy.setOnAction( e -> {
            try {
                PobieranieRaportowWidok.display("producent_statystyki_sprzedazy", 0, 0, field3.getText());
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            window.close();
        });

        grid.getChildren().addAll(Historia_Zamowien, ilosc_przeprowadzonych_transakcji, produkty_ponizej_danej_kwoty);
        grid.getChildren().addAll(producent_statystyki_sprzedazy,  arg1, field1, arg2, field2, arg3, field3);

    Scene scene = new Scene(grid, 700, 200);
        window.setScene(scene);
        window.showAndWait();
    }
}
