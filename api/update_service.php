<?php
include '../connection.php';

$service_id=$_POST['service_id'];

$name = $_POST['name'];

$phone = $_POST['phone'];
$location = $_POST['location'];

$type = $_POST['type'];



$query1=mysqli_query($con,"UPDATE `service` SET `name`='$name',`mobile`='$phone',`place`='$location' WHERE service_id='$service_id'");



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