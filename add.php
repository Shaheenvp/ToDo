<?php
include'connection.php';
$task=$_POST['action'];
$discription=$_POST['time'];
$sql=mysqli_query($con,"INSERT INTO usertb (action,time) VALUES ('$task','$discription')");
if($sql){
    $myArray['result']='success';

}
else{
    $myArray['result']='fail';
}
echo json_encode($myArray);
?>