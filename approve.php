<?php

include 'connection.php';
$id = $_GET['id'];
mysqli_query($con,"update company set status='1' where company_id = '$id' ");
header("location:company.php")
?>