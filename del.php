<?php
include'connection.php';
$id=$_POST['id'];
$sql=mysqli_query($con,"DELETE FROM usertb WHERE id='$id'");
if($sql){
    $myArray['result']='success';

}
else{
    $myArray['result']='fail';
}
echo json_encode($myArray);
?>