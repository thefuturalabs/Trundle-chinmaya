<?php

include '../connection.php';


$sql = mysqli_query($con, "SELECT * FROM service");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['company_id'] = $row['company_id'];
    $myarray['service_id'] = $row['service_id'];
    $myarray['name'] = $row['name'];
    $myarray['mobile'] = $row['mobile'];
    $myarray['place'] = $row['place'];



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
