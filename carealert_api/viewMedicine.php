<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
 header("Access-Control-Allow-Headers: X-Requested-With");
    include('dbconnection.php');
    $profile_name=$_POST["profile_name"];
    $con=dbconnection();
    // print(json_encode($profile_name));
    $sql="SELECT * FROM medication WHERE m_pname='".$profile_name."'";
    // print(json_encode($sql));
    $result=mysqli_query($con,$sql);

    $arr=[];
    while($row=mysqli_fetch_array($result)){
        $arr[]=$row;
    }
    print(json_encode($arr));
?>