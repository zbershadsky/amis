<?php

session_start();

if (!isset($_SESSION['user_name'])){
	echo 0;
}
else {
	echo 1;
}

?>