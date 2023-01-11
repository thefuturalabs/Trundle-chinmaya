<?php
include '../connection.php';

$customer_id = $_POST['customer_id'];
$feedback = $_POST['feedback'];




$sql = mysqli_query($con, "INSERT INTO feedback (customer_id,feedback) VALUES('$customer_id','$feedback')");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);
