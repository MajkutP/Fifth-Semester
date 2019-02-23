package com.postgresqlProject;

import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.layout.HBox;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.sql.SQLException;

public class WczytywanieTablicListaTablic {
    public static void display() {
        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Wybor tablicy do wyświetlenia");
        window.setMinWidth(400);

        Label label = new Label();
        label.setText("Wybór tablicy: ");
        ChoiceBox<String> choiceBox = new ChoiceBox<>();
        choiceBox.getItems().addAll("zamowienie", "klient", "historia_adres");
        choiceBox.getItems().addAll("zamowienie_produkt", "produkt", "dzial", "zdjecie_produkt");
        choiceBox.getItems().addAll("kategoria", "producent", "zdjecie", "historia_cen");
        choiceBox.setOnAction( e -> {
            try {
                WczytywanieTablicWidok.display(choiceBox.getValue());
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            window.close();
        });

        HBox layout = new HBox(10);
        layout.setPadding(new Insets(20, 20, 20, 20));
        layout.getChildren().addAll(label, choiceBox);
        layout.setAlignment(Pos.TOP_CENTER);

        Scene scene = new Scene(layout, 300, 340);
        window.setScene(scene);
        window.showAndWait();
    }
}
