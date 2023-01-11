<?php
include '../connection.php';

$company_id = $_POST['company_id'];
$name = $_POST['name'];
$reg_no = $_POST['reg_no'];
$type = $_POST['type'];
$fuel_type = $_POST['fuel_type'];
$price = $_POST['price'];
$color = $_POST['color'];

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


  







$sql = mysqli_query($con, "INSERT INTO vehicle (company_id,name,reg_no,type,fuel_type,price,color,image) VALUES('$company_id','$name','$reg_no','$type','$fuel_type','$price','$color','$filenew')");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);
