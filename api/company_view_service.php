<?php

include '../connection.php';

$id = $_POST['company_id'];

$sql = mysqli_query($con, "SELECT * FROM service WHERE company_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['name'] = $row['name'];
    $myarray['place'] = $row['place'];
    $myarray['service_id'] = $row['service_id'];
    $myarray['type'] = $row['type'];
    $myarray['mobile'] = $row['mobile'];
    


    array_push($list, $myarray);
   
  }
} else {

  $myarray['value'] = 0;
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
