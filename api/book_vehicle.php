<?php
include '../connection.php';

$customer_id = $_POST['customer_id'];
$vehicle_id = $_POST['vehicle_id'];




$sql = mysqli_query($con, "INSERT INTO vehicle_book (customer_id,vehicle_id) VALUES('$customer_id','$vehicle_id')");
$data = mysqli_query($con,"select * from vehicle_book where customer_id = '$customer_id' and vehicle_id='$vehicle_id'");
$row = mysqli_fetch_assoc($data);

if ($sql) {

    $myarray['result'] = "booked";
    $myarray['status'] =  $row['status'] ;
} else {
    $myarray['result'] = 'Failed';
}
echo json_encode($myarray);
