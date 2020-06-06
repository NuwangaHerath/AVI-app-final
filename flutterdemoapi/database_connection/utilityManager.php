<?php
     require_once('DBController.php');
?>

<?php
	class utility{
		private $controller;

		public function __construct(){
			$this->controller= new DBController();
		}

    ///////////////////////////////////////////////////////
    public function BlackList_Vehicle($out,$latitude,$longitude,$username,$dateTime,$branch){
        $query="SELECT saveVehicleNumber('$out','$latitude','$longitude','$username','$dateTime','$branch') AS 'out'";
        $res=$this->controller->runQuery($query);
        if ($res[0]['out']==2){
          return ("saved");
        }else if ($res[0]['out']==0){
          return("isBlacklisted");
        }else{
          return("updated");
        }
    }

    public function Check_Vehicle($out,$latitude,$longitude,$username,$dateTime,$branch){
      $query="SELECT checkVehicle('$out','$latitude','$longitude','$username','$dateTime','$branch') AS 'res'";
        $res=$this->controller->runQuery($query);
        if ($res[0]['res']==1){
          return (true);
        }else{
          return(false);
        }
    }
	
	public function Login($username,$password1){
		$query="SELECT userID,branchID,isReset,branchName FROM users natural join branch WHERE username='$username' AND password='$password1'";
		$res=$this->controller->logincheck($query);
		if ($res!=null){
          return ($res);
        }else{
          return("failed");
        }
	}
	public function Resetpass($userid,$password1,$password){
		$query="UPDATE users SET password='$password1',isReset=1 WHERE userID='$userid' AND password='$password'";
		$res=$this->controller->resetpass($query);
		if ($res!=null){
          return ("successfull");
        }else{
          return("failed");
        }
	}
	public function Newresetpass($username,$password1,$password){
		$query="UPDATE users SET password='$password1' WHERE username='$username' AND password='$password'";
		$res=$this->controller->resetpass($query);
		if ($res!=null){
          return ("successfull");
        }else{
          return("failed");
        }
	}
  }



