<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
 header("Access-Control-Allow-Headers: X-Requested-With");
    include('dbconnection.php');
    $h_pname=$_POST["h_pname"];
    $con=dbconnection();
    // print(json_encode($h_pname));
    $sql="SELECT * FROM history_medication WHERE h_pname='".$h_pname."'";
    // print(json_encode($sql));
    $result=mysqli_query($con,$sql);
    $arr=[];
    while($row=mysqli_fetch_array($result)){
        $arr[]=$row;
    }
    print(json_encode($arr));
?>