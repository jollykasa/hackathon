<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
 header("Access-Control-Allow-Headers: X-Requested-With");
    include('dbconnection.php');
    $con=dbconnection();
    $sql="SELECT * FROM profiles;";
    $result=mysqli_query($con,$sql);

    $arr=[];
    while($row=mysqli_fetch_array($result)){
        $arr[]=$row;
    }
    print(json_encode($arr));
?>