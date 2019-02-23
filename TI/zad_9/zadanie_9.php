<?php
interface ReaderInterface {
	public function _save();
 /*
* Metoda _save()
* Funkcjonalnosc metody - odczyt danych z QUERY_STRING i zapis do bazy danych dbm
* 1) Jezeli sa parametry w QUERY_STRING
* klucz -> data & czas
* wartosc -> wprowadzone w postaci typu JSON
* 2) Jezeli brak danych w QUERY_STRING
* wpis do bazy {"query_string":"null"}
*/

	public function _read();
 /*
* Metoda _read()
* Funkcjonalnoœæ metody - odczyt wszystkich rekordów z bazy danych i przes³anie do klienta
* w formacie klucz => wartosc
*/
}

class DBServer implements ReaderInterface{

private $database = "files/data.db";
private $storedData = array();
private $dba;
private $dbh;
private $key;

public function _save(){
  $param1 = $_GET['param1'];
  $param2 = $_GET['param2'];
  $this->key = date("Y-m-d H:i:s");
  $this->dba = dba_open($this->database, "c");
  
  if($param1 == ""&&$param2 == "") {
			$this->storedData['query_string'] = 'null';
  } 
  else if($param1 == "") {
			$this->storedData['param2'] = $_GET['param2'];
  } 
  else if($param2 == "") {
			$this->storedData['param1'] = $_GET['param1'];
  } 
  else {
			$this->storedData['param1'] = $_GET['param1'];
			$this->storedData['param2'] = $_GET['param2'];
  }
  
  $serialized_data = serialize(json_encode($this->storedData));
  dba_insert($this->key, $serialized_data, $this->dba);
  dba_close($this->dba);
}

public function _read(){
echo '<!DOCTYPE html><head><link type="text/css" rel="stylesheet" href="zadanie_9.css"></head>';

echo "<body>";
echo "<table>";
echo "<tr>";
echo "<th>Data</th>";
echo "<th>Values</th>";
echo "</tr>";

$this->dba = dba_open($this->database, "r");
$key = dba_firstkey($this->dba);
		echo "<tr>";
           while($key){
            $serialized_data = dba_fetch($key, $this->dba);
            $this->storedData = unserialize($serialized_data);
            echo "<tr><td>".$key."</td><td>".$this->storedData."</td></tr>";
            $key = dba_nextkey($this->dba);
        }
dba_close($this->dba);        
echo "</tr>";   
echo "</table>";
echo "</body>";
echo "</html>";
  }
}

$dbServer = new DBServer;

$dbServer -> _save();
$dbServer -> _read();
?>