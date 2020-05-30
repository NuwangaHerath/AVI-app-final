<?php
require_once('./database_connection/utilityManager.php');

if(isset($_POST["username"])) {
   $username=$_POST["username"];
   $password1=$_POST['password1'];
   $password11= sha1($password1);
   $password2=$_POST['password2'];
   $password22= sha1($password2);
   $password=$_POST["password"];
   $password33= sha1($password);
   $utility=new utility();
   if($password===$password1){
   echo json_encode(['error' => "New password is identical to the Current password!"]);
   	
   }
   else{
   if($password1===$password2){

   $result=$utility->Newresetpass($username,$password11,$password33);
   if($result==="failed"){
   	echo json_encode(['error' => "Invalid Username or Password!"]);
   	
    }else{
		echo json_encode(['response' => "Reset Successfully"]);
        
    }
	}
	else{
		echo json_encode(['error' => "Re-entered password doesn't matched"]);
	}
	}
	}
?>