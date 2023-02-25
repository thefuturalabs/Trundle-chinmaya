<?php
include '../connection.php';

$vehicle_id = $_POST['vehicle_id'];
$data = mysqli_query($con,"SELECT company.name, company.phn_no, company.email, company.place, company.file FROM `vehicle` join company on vehicle.company_id=company.company_id where vehicle.vehicle_id='$vehicle_id'");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['phn_no'];
$myarray['image'] = $row['file'];
$myarray['place'] = $row['place'];

echo json_encode($myarray);
?>