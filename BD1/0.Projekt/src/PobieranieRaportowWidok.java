package com.postgresqlProject;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PobieranieRaportowWidok {
    public static void display(String raport, int arg1, int arg2, String arg3) throws SQLException {
        ObservableList<ObservableList> data = FXCollections.observableArrayList();
        TableView tableview = new TableView();
        String SQL = new String();

        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Zawartosc tablicy");

        if(raport.equals("Historia_Zamowien")){
            SQL = "Select * from sklepmuzyczny.Historia_Zamowien";
        }

        if(raport.equals("ilosc_przeprowadzonych_transakcji")){
            SQL = "Select * from ilosc_przeprowadzonych_transakcji(" + arg1 + ")";
        }

        if(raport.equals("produkty_ponizej_danej_kwoty")){
           SQL = "Select * from produkty_ponizej_danej_kwoty(" + arg2 + ")";
        }

        if(raport.equals("producent_statystyki_sprzedazy")){
            SQL = "Select * from producent_statystyki_sprzedazy(\'" + arg3 + "\')";
        }

        ResultSet rs = App.con.createStatement().executeQuery(SQL);

        for(int i=0 ; i<rs.getMetaData().getColumnCount(); i++){
            final int j = i;
            TableColumn col = new TableColumn(rs.getMetaData().getColumnName(i+1));
            col.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<ObservableList,String>, ObservableValue<String>>(){
                public ObservableValue<String> call(TableColumn.CellDataFeatures<ObservableList, String> param) {
                    return new SimpleStringProperty(param.getValue().get(j).toString());
                }
            });

            tableview.getColumns().addAll(col);
        }

        while(rs.next()){
            ObservableList<String> row = FXCollections.observableArrayList();
            for(int i=1 ; i<=rs.getMetaData().getColumnCount(); i++){
                row.add(rs.getString(i));
            }
            data.add(row);

        }

        tableview.setItems(data);

        Scene scene = new Scene(tableview, 600, 400);
        window.setScene(scene);
        window.showAndWait();
    }
}
