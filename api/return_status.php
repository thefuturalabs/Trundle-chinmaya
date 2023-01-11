<?php
include '../connection.php';

$book_id = $_POST['book_id'];





$sql = mysqli_query($con, "UPDATE vehicle_book SET return_status = '1' where book_id = '$book_id'");
$list = array();

if ($sql) {

    $myarray['result'] = "requested";
} else {
    $myarray['message'] = 'Failed';
}
echo json_encode($myarray);
