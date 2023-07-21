<?php
include 'connection.php';

$sql=mysqli_query($con," SELECT * from usertb ");
$list=array();
if($sql->num_rows>0){
 while($rows=mysqli_fetch_assoc($sql)){
    $myArray['result']='success';
    $myArray['action']=$rows['action'];
    $myArray['time']=$rows['time'];
    $myArray['id']=$rows['id'];
    
    array_push($list,$myArray);
 }
}
else{
    $myArray['result']='Failed';
    array_push($list,$myArray);
}
 echo json_encode($list);
?>