<?php
include 'conn.php';
$userid = $_POST['userid'];
$password = $_POST['password'];
$queryResult=$connect->query("SELECT * FROM login WHERE userid='$userid' and password='$password'");
$result=array();
if(!empty($queryResult) && $queryResult->num_rows >0) {
    while ($fetchData = $queryResult->fetch_assoc()) {
        $result[] = $fetchData;
    }
}
echo json_encode($result);
?>

