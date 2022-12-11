<?php
$myConnection = mysqli_connect('localhost','root','','photostudio');


if(mysqli_connect_errno()){
    echo "Произошла ошибка подключения " . mysqli_connect_error();
    exit;
}
        $sum = 0;
        $pricePlace = 0;
        $pricePhotographer = 0;
        if (isset($_POST['clientDateTimeEnter'])){$dateTimeEnter = str_replace("T"," ",$_POST['clientDateTimeEnter']); $dateTimeEnter .=":00";}
        //echo "<br>";
        if (isset($_POST['clientDateTimeExit'])){$dateTimeExit = str_replace("T"," ",$_POST['clientDateTimeExit']); $dateTimeExit .=":00";}
        //echo "<br>";

        $clientName = "";
        if (isset($_POST["clientName"])){$clientName = $_POST["clientName"];}
        //echo $clientName;
        //echo "<br>";

        $clientPhone = "";
        if (isset($_POST["clientPhone"])){$clientPhone = $_POST["clientPhone"];}
        //echo $clientPhone;
        //echo "<br>";

        $clientPlace = "";
        if(isset($_POST['selectPlace'])){$clientPlace = $_POST['selectPlace'];}
        //echo $clientPlace;
        //echo "<br>";

        $clientPhotographer = "";
        if(isset($_POST['selectPhotographer'])){$clientPhotographer = $_POST['selectPhotographer'];}
        if($clientPhotographer == "no"){$clientPhotographer = null;}
        //echo $clientPhotographer;
        //echo "<br>";

        $pricePlace = mysqli_query($myConnection, "SELECT rent FROM place WHERE id_place = '$clientPlace'");
        $pricePlace = mysqli_fetch_assoc($pricePlace);
        $pricePlace = $pricePlace['rent'];
        //echo $pricePlace;
        //echo "<br>";

        if($_POST['selectPhotographer'] != "no"){
            $pricePhotographer = mysqli_query($myConnection, "SELECT rent FROM photographer WHERE id_photographer = '$clientPhotographer'");
            $pricePhotographer = mysqli_fetch_assoc($pricePhotographer);
            $pricePhotographer = $pricePhotographer['rent'];
            //echo $pricePhotographer;
            //echo "<br>";
        }

        $date1 = date_create($dateTimeEnter);
        $date2 = date_create($dateTimeExit);
        $diff = date_diff($date1,$date2);
        $hour = $diff->h;
        //echo $hour;
        //echo "<br>";
        $sum = $pricePlace * $hour + $pricePhotographer * $hour;
        //echo $sum;


        if ($clientPhone != null && $clientName != null){
            $query_connect = mysqli_query($myConnection, "INSERT INTO client (full_name, phone) VALUES ('$clientName','$clientPhone')");

            $query_getID = mysqli_query($myConnection, "SELECT id_client FROM client WHERE full_name = '$clientName'");
            $getID = mysqli_fetch_all($query_getID);
            $getID = $getID[0][0];

            $date = date('y-m-d');
            if ($clientPhotographer != null){
                $query_connect = mysqli_query($myConnection, "INSERT INTO request (number,client_id, date_create, datetime_pp, datetime_py,place_id,photographer_id) VALUES ('10','$getID','$date','$dateTimeEnter','$dateTimeExit','$clientPlace','$clientPhotographer')");

                $query_getIDRequest = mysqli_query($myConnection, "SELECT id_request FROM request WHERE client_id = '$getID'");
                $getIDRequest = mysqli_fetch_all($query_getIDRequest);
                $getIDRequest = $getIDRequest[0][0];

                $query_connect = mysqli_query($myConnection, "INSERT INTO bill (number,date,sum,status,request_id) VALUES ('10','$date','$sum','Не оплачено','$getIDRequest')");

                $query_portfolio = mysqli_query($myConnection, "INSERT INTO portfolio (link,client_id) VALUES ('какая-то ссылка','$getID')");
            }
            if ($clientPhotographer == null){
                $query_connect = mysqli_query($myConnection, "INSERT INTO request (number,client_id, date_create, datetime_pp, datetime_py,place_id,photographer_id) VALUES ('10','$getID','$date','$dateTimeEnter','$dateTimeExit','$clientPlace',NULL)");

                $query_getIDRequest = mysqli_query($myConnection, "SELECT id_request FROM request WHERE client_id = '$getID'");
                $getIDRequest = mysqli_fetch_all($query_getIDRequest);
                $getIDRequest = $getIDRequest[0][0];

                $query_connect = mysqli_query($myConnection, "INSERT INTO bill (number,date,sum,status,request_id) VALUES ('10','$date','$sum','Не оплачено','$getIDRequest')");
            }

            header('Location: index.php');
        }