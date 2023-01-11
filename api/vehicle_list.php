<?php

include '../connection.php';


$sql = mysqli_query($con, "SELECT * FROM vehicle");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['company_id'] = $row['company_id'];
    $myarray['vehicle_id'] = $row['vehicle_id'];
    $myarray['name'] = $row['name'];
    $myarray['type'] = $row['type'];
    $myarray['photo'] = $row['image'];
    $myarray['status'] = $row['status'];



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
