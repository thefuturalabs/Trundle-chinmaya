<?php
include '../connection.php';

$vehicle_id = $_POST['vehicle_id'];





$sql = mysqli_query($con, "DELETE FROM vehicle where vehicle_id = '$vehicle_id'");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);
