<?php
include '../connection.php';

$company_id = $_POST['company_id'];
$type = $_POST['type'];
$name = $_POST['name'];
$place = $_POST['place'];
$mobile = $_POST['mobile'];



$sql = mysqli_query($con, "INSERT INTO service (company_id,type,name,place,mobile) VALUES('$company_id','$type','$name','$place','$mobile')");
$data = mysqli_insert_id($con);
$row = mysqli_query($con,"select * from service where service_id = '$data'");
$row1 = mysqli_fetch_assoc($row);
$list = array();

if ($sql) {

    $myarray['service_id'] = $row1['service_id'] ;
    $myarray['msg'] = 'done' ;
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);
