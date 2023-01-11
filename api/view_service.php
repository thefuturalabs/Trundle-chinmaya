<?php

include '../connection.php';

$id = $_POST['service_id'];

$sql = mysqli_query($con, "SELECT * FROM service WHERE service_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['name'] = $row['name'];
    $myarray['mobile'] = $row['mobile'];
    $myarray['place'] = $row['place'];
    $myarray['company_id'] = $row['company_id'];
    $myarray['type'] = $row['type'];


    array_push($list, $myarray);
   
  }
} else {

  $myarray['value'] = 0;
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
