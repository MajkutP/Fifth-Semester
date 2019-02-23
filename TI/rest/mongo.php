<?php
class db_mongo {
private $user = "grazyna" ;
private $pass = "pass";
private $host = "pascal.fis.agh.edu.pl";
private $base = "grazyna";
private $coll = "student_majkutp";
private $conn;
private $dbase;
private $collection;
function __construct() {
$this->conn = new Mongo("mongodb://{$this->user}:{$this->pass}@{$this->host}/{$this->base}");
$this->dbase = $this->conn->selectDB($this->base);
$this->collection = $this->dbase->selectCollection($this->coll);
}
function select() {
$cursor = $this->collection->find();
$table = iterator_to_array($cursor);
return $table ;
}
function insert($user) {
$ret = $this->collection->insert($user) ;
return $ret;
}
function update($ident,$user,$flag) {
if ( $flag ) {
$rec = new MongoId($ident);
$filter = array ( '_id' => $rec );
} else {
$filter = array ( 'ident' => $ident );
}
$update = array ( '$set' => $user );
$option = array ( 'w' => 1 );
$ret = $this->collection->update($filter,$update,$option);
return $ret['nModified'];
}
function delete($ident,$flag) {
if ( $flag ) {
$rec = new MongoId($ident);
$filter = array ( '_id' => $rec );
} else {
$filter = array ( 'ident' => $ident );
}
$option = array( 'justOne' => true, 'w' => 1 );
$ret = $this->collection->remove($filter,$option);
return $ret['n'];
}}
