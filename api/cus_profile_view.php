<?php
include '../connection.php';

$customer_id = $_POST['customer_id'];
$data = mysqli_query($con,"select * from customer where login_id = '$customer_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['mobile'];
$myarray['dob'] = $row['dob'];
$myarray['place'] = $row['place'];

echo json_encode($myarray);
?>