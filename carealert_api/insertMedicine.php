<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
 header("Access-Control-Allow-Headers: X-Requested-With");
    include('dbconnection.php');
    if(isset($_POST["m_pname"])){
        $m_pname=$_POST["m_pname"];
    }else return;
    if(isset($_POST["m_medicine"])){
        $m_medicine=$_POST["m_medicine"];
    }else return;
    if(isset($_POST["m_time"])){
        $m_time=$_POST["m_time"];
    }else return;
    if(isset($_POST["m_date"])){
        $m_date=$_POST["m_date"];
    }else return;
    if(isset($_POST["m_image"])){
        $m_image=$_POST["m_image"];
    }else return;
    $con=dbconnection();
    
    $sql="INSERT INTO medication(m_pname,m_medicine,m_time,m_date,m_image) VALUES ('$m_pname','$m_medicine','$m_time','$m_date','$m_image');";

    print(json_encode($sql));
    // $result =mysqli_query($con,$sql);
    // $arr=[];
    // if($result){
    //     $arr["sucess"]="true";
    // }else{
    //     $arr["sucess"]="false";
    // }
    // print(json_encode($arr));
?>