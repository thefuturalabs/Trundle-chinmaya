<?php

include '../connection.php';

$id = $_POST['company_id'];

$sql = mysqli_query($con, "SELECT * FROM vehicle WHERE company_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['name'] = $row['name'];
    $myarray['vehicle_id'] = $row['vehicle_id'];
    $myarray['reg_no'] = $row['reg_no'];
    $myarray['type'] = $row['type'];
    $myarray['color'] = $row['color'];
    $myarray['price'] = $row['price'];
    $myarray['image'] = $row['image'];


    array_push($list, $myarray);
   
  }
} else {

  $myarray['value'] = 0;
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
