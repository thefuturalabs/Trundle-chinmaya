<?php
include '../connection.php';

$vehicle_id=$_POST['vehicle_id'];

$name = $_POST['name'];
$regNo = $_POST['reg_no'];
$price = $_POST['price'];
$color = $_POST['color'];
$fuelType = $_POST['fuel_type'];
$type = $_POST['type'];



$query1=mysqli_query($con,"UPDATE `vehicle` SET `name`='$name',`reg_no`='$regNo',`price`='$price',`color`='$color',`fuel_type`='$fuelType' WHERE vehicle_id='$vehicle_id'");



if($query1)
{
	$myarray['message'] = 'updated';
}

else
{

	$myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>