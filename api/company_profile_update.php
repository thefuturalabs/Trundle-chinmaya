<?php
include '../connection.php';

$company_id=$_POST['company_id'];

$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];


$place = $_POST['place'];

$query1=mysqli_query($con,"UPDATE `company` SET `name`='$name',`email`='$email',`phn_no`='$phn_no',`place`='$place' WHERE login_id='$company_id'");



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