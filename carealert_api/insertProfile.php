<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
 header("Access-Control-Allow-Headers: X-Requested-With");
    include('dbconnection.php');
    if(isset($_POST["p_name"])){
        $p_name=$_POST["p_name"];
    }else return;
    if(isset($_POST["p_age"])){
        $p_age=$_POST["p_age"];
    }else return;
    if(isset($_POST["p_image"])){
        $p_image=$_POST["p_image"];
    }else return;
    $con=dbconnection();
    
    $sql="INSERT INTO profiles(p_name,p_age,p_image) VALUES ('$p_name','$p_age','$p_image');";

    // print(json_encode($sql));
    $result =mysqli_query($con,$sql);
    $arr=[];
    if($result){
        $arr["sucess"]="true";
    }else{
        $arr["sucess"]="false";
    }
    print(json_encode($arr));
?>