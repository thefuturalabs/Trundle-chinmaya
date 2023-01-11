<?php

include '../connection.php';


$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['mobile'];
$place = $_POST['place'];


$username = $_POST['username'];
$password = $_POST['password'];
$pic = $_FILES['f1']['name'];

    if ($pic != "") {
        $filearray = pathinfo($_FILES['f1']['name']);

        $file1 = rand();
        $file_ext = $filearray["extension"];




        $filenew = $file1 . "." . $file_ext;
        move_uploaded_file($_FILES['f1']['tmp_name'], "../img/" . $filenew);
        // var_dump($filenew);exit();
    } 
    else {
        echo "<script>alert('Please try again...!')</script>";
    }


  


$query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','company')");
$last_login_id = mysqli_insert_id($con);
// var_dump($last_login_id);exit();
$query1 = mysqli_query($con, "INSERT INTO `company`(`login_id`,`name`,`email`,`phn_no`,`place`,`file`) VALUES ('$last_login_id','$name','$email','$phn_no','$place','$filenew')");
$sql = mysqli_query($con, "select * from company where login_id = '$last_login_id;' ");
if ($sql) {

	$row = mysqli_fetch_assoc($sql);

		$myarray['message'] = 'registration successfull';
		$myarray['company_id'] = $row['login_id'];
	}
 else {


	$myarray['message'] = 'Failed to View';
}
echo json_encode($myarray);
