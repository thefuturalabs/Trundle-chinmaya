<?php
include '../connection.php';

$service_id = $_POST['service_id'];





$sql = mysqli_query($con, "DELETE FROM service where service_id = '$service_id'");
// $list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Remove';
}
echo json_encode($myarray);
