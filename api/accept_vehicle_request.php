<?php
include '../connection.php';

$book_id = $_POST['book_id'];


$sql = mysqli_query($con, "UPDATE vehicle_book SET status='1' where book_id = '$book_id'");


if ($sql) {

    $myarray['result'] = "accepted";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);
