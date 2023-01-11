<?php

include '../connection.php';

$id = $_POST['vehicle_id'];

$sql = mysqli_query($con, "SELECT * FROM vehicle WHERE vehicle_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['name'] = $row['name'];
    $myarray['Reg_no'] = $row['reg_no'];
    $myarray['photo'] = $row['image'];
    $myarray['color'] = $row['color'];
    $myarray['type'] = $row['type'];
    $myarray['fuel_type'] = $row['fuel_type'];
    $myarray['price'] = $row['price'];
    $myarray['status'] = $row['status'];


    array_push($list, $myarray);
   
  }
} else {

  $myarray['value'] = 0;
  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
