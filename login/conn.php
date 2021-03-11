<?php
$connect = new mysqli("localhost", "root", "", "login");
if($connect){
}
else{
    echo "Connection Failed";
    exit();
}
?>

