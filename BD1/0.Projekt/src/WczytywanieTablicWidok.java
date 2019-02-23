package com.postgresqlProject;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.Scene;
import javafx.scene.control.TableView;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.util.Callback;

import java.sql.ResultSet;
import java.sql.SQLException;

public class WczytywanieTablicWidok {
    public static void display(String tablica) throws SQLException {
        ObservableList<ObservableList> data = FXCollections.observableArrayList();
        TableView tableview = new TableView();

        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        window.setTitle("Zawartosc tablicy");

        String SQL = "Select * from sklepmuzyczny." + tablica;
        ResultSet rs = App.con.createStatement().executeQuery(SQL);

        for(int i=0 ; i<rs.getMetaData().getColumnCount(); i++){
            final int j = i;
            TableColumn col = new TableColumn(rs.getMetaData().getColumnName(i+1));
            col.setCellValueFactory(new Callback<CellDataFeatures<ObservableList,String>,ObservableValue<String>>(){
                public ObservableValue<String> call(CellDataFeatures<ObservableList, String> param) {
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

        Scene scene = new Scene(tableview, 800, 300);
        window.setScene(scene);
        window.showAndWait();
    }
}
