<?php
include 'connection.php';

$task=$_POST['action'];
$des=$_POST['time'];
$id=$_POST['id'];

 $sql=mysqli_query($con,"UPDATE usertb set action='$task',time='$des' where id='$id'");

 if($sql){
    $myArray['result']='Success';
 }
 else{
    $myArray['result']='Failed';
 }

 echo json_encode($myArray);


?>