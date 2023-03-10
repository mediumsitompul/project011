<?php
  $return["error"] = false;
  $return["msg"] = "";
  $return["data"] = array();
  $db = "db_country";
  $host = "192.168.100.100:6607";
  $db_user = 'pqr';
  $db_password = 'Pensi2021';
  $link = mysqli_connect($host, $db_user, $db_password, $db);

  if(isset($_REQUEST["auth"]))
  //if(isset($_REQUEST["rundut"]))


  {
    $authkey = $_REQUEST["auth"];
    //$authkey = $_REQUEST["rundut"];


    //$negara1 = $_REQUEST["negara"]; // jika  script di flutter ada, remark baru dibuka

      if($authkey == "kjgdkhdfldfguttedfgr")
 


    { //*********************** */
      $json["data"] = array();
		//$sql = "SELECT name, capital, pic_, datetime_ FROM t_data";
    //$sql = "SELECT name, capital, pic_, datetime_ FROM t_data where name='$negara1' "; // jika  script di flutter ada, remark baru dibuka
	$sql = "SELECT name, capital, flag, datetime_ FROM t_data_flag";
	
	

        $res = mysqli_query($link, $sql);
        $numrows = mysqli_num_rows($res);
        while($array = mysqli_fetch_assoc($res))
        {
          array_push($return["data"], $array);
        }
        mysqli_close($link);
        header('Content-Type: application/json');
    }
      //*********************** */
        else
        {
        $return["error"] = true;
        $return["msg"] = "Authentication error.";}
    }
    else{
        $return["error"]  = true;
        $return["msg"] = "Send auth key.";}
		
	//*****************************************  // Tell PHP, so this is JSON, WILL IMPACT TO FLUTTER
    header('Content-Type: application/json');
	//*****************************************
    echo json_encode($return);
    ?>
