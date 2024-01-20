<?php
function  dbconnection(){
    $con=mysqli_connect("localhost","root","","carealert");
    return $con;
}

?>