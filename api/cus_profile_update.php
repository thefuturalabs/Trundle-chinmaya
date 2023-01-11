<?php
include '../connection.php';

$customer_id=$_POST['customer_id'];

$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];
$dob = $_POST['dob'];

$place = $_POST['place'];

$query1=mysqli_query($con,"UPDATE `customer` SET `name`='$name',`email`='$email',`mobile`='$phn_no',`dob`='$dob',`place`='$place' WHERE login_id='$customer_id'");



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