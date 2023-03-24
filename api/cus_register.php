<?php

include '../connection.php';


$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];
$dob = $_POST['dob'];
$place = $_POST['place'];


$username = $_POST['username'];
$password = $_POST['password'];
$pic = $_FILES['license']['name'];

    if ($pic != "") {
        $filearray = pathinfo($_FILES['license']['name']);

        $file1 = rand();
        $file_ext = $filearray["extension"];




        $filenew = $file1 . "." . $file_ext;
        move_uploaded_file($_FILES['license']['tmp_name'], "../img/" . $filenew);
        // var_dump($filenew);exit();
    } 
    else {
        echo "<script>alert('Please try again...!')</script>";
    }
  


$query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','customer')");
$last_login_id = mysqli_insert_id($con);
// var_dump($last_login_id);exit();
$query1 = mysqli_query($con, "INSERT INTO `customer`(`login_id`,`name`,`email`,`mobile`,`dob`,`place`,`license`) VALUES ('$last_login_id','$name','$email','$phn_no','$dob','$place','$filenew')");
$sql = mysqli_query($con, "select * from customer where login_id = '$last_login_id;' ");
if ($sql) {

	$row = mysqli_fetch_assoc($sql);

		$myarray['message'] = 'registration successfull';
		$myarray['user_id'] = $row['login_id'];
	}
 else {


	$myarray['message'] = 'Failed to View';
}
echo json_encode($myarray);
