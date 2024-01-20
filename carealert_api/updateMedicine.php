<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
 header("Access-Control-Allow-Headers: X-Requested-With");
    include('dbconnection.php');
    if(isset($_POST["id"])){
        $id=$_POST["id"];
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
    $con=dbconnection();
    print($id.$m_name.$m_date.$m_time.$m_image);
    // $sql="UPDATE `orders` SET `table_id`='$table_id',`o_quantity`=$o_quantity,`time`='$time' WHERE `item_id`=$item_id AND `table_id`='$pretable_id'";
    
    // // print(json_encode($sql));
    // $result =mysqli_query($con,$sql);
    // $arr=[];
    // if($result){
    //     $arr["sucess"]="true";
    // }else{
    //     $arr["sucess"]="false";
    // }
    // print(json_encode($arr));
?>