<?php
require_once('./database_connection/utilityManager.php');

if(isset($_POST["username"])) {
   $username=$_POST['username'];
   $password=$_POST['password'];
   $password1= sha1($password);
   $utility=new utility();

   $result=$utility->Login($username,$password1);
   if($result==="failed"){
   	echo json_encode(['error' => "Invalid User name or Password"]);
   	
    }else{
		echo json_encode(['response' => "Login Successfully",'username'=>$username,'userID'=>$result['userID'],'branchID'=>$result['branchID'],'isReset'=>$result['isReset']]);
        
    }
	}
?>