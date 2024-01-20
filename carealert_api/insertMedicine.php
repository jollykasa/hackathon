<?php
    include('dbconnection.php');
    $con=dbconnection();
    if(isset($_POST["m_pname"])){
        $m_pname=$_POST["m_pname"];
    }else return;
    if(isset($_POST["m_name"])){
        $m_name=$_POST["m_name"];
    }else return;
    if(isset($_POST["m_date"])){
        $m_date=$_POST["m_date"];
    }else return;
    if(isset($_POST["m_time"])){
        $m_time=$_POST["m_time"];
    }else return;
    if(isset($_POST["m_image"])){
        $m_image=$_POST["m_image"];
    }else return;
    // print($m_name.$m_date.$m_time.$m_image);
    $sql="INSERT INTO medication (m_pname,m_medicine,m_image, m_time, m_date) VALUES('$m_pname', '$m_medicine', '$m_image','$m_time','$m_date');";
    print($sql);
    // $result =mysqli_query($con,$sql);
    // $arr=[];
    // if($result){
    //     $arr["sucess"]="true";
    // }else{
    //     $arr["sucess"]="false";
    // }
    // print(json_encode($arr));
?>