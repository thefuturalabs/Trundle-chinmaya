<?php

include '../connection.php';

$customer_id=$_POST['customer_id'];
$sql = mysqli_query($con, "SELECT * FROM service_book join service on service.service_id where customer_id = '$customer_id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['book_id'] = $row['book_id'];
    $myarray['name'] = $row['name'];
    $myarray['status'] = $row['status'];
    $myarray['service_id'] = $row['service_id'];
    



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);