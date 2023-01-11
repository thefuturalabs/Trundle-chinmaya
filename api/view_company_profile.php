<?php
include '../connection.php';

$company_id = $_POST['company_id'];
$data = mysqli_query($con,"select * from company where login_id = '$company_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['phn_no'];
$myarray['place'] = $row['place'];

echo json_encode($myarray);
?>