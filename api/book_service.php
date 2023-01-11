<?php
include '../connection.php';

$customer_id = $_POST['customer_id'];
$service_id = $_POST['service_id'];




$sql = mysqli_query($con, "INSERT INTO service_book (customer_id,service_id) VALUES('$customer_id','$service_id')");
$data = mysqli_query($con,"select * from service_book where customer_id = '$customer_id' and service_id='$service_id'");
$row = mysqli_fetch_assoc($data);

if ($sql) {

    $myarray['result'] = "booked";
    $myarray['status'] =  $row['status'] ;
} else {
    $myarray['result'] = 'Failed';
}
echo json_encode($myarray);
