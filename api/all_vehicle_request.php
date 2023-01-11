<?php

include '../connection.php';

$company_id=$_POST['company_id'];
$sql = mysqli_query($con, "SELECT vehicle_book.book_id,vehicle_book.status,vehicle_book.vehicle_id,vehicle.name FROM vehicle_book join vehicle on vehicle.vehicle_id=vehicle_book.vehicle_id where company_id = '$company_id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['book_id'] = $row['book_id'];
    $myarray['name'] = $row['name'];
    $myarray['status'] = $row['status'];
    $myarray['vehicle_id'] = $row['vehicle_id'];
    



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
