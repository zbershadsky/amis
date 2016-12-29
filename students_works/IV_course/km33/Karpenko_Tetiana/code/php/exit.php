<?php
session_start();
echo "Buy,".$_SESSION['user_name'];
session_destroy();
exit;
?>