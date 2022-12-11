<?php
    $myConnection = mysqli_connect('localhost','root','','photostudio');


    if(mysqli_connect_errno()){
        echo "Произошла ошибка подключения " . mysqli_connect_error();
        exit;
    }
    $queryPlace = mysqli_query($myConnection,"SELECT * FROM place");
    $queryPlaceFetch = mysqli_fetch_all($queryPlace);

    $queryPhotographer = mysqli_query($myConnection, "SELECT * FROM photographer");
    $queryPhotographerFetch = mysqli_fetch_all($queryPhotographer);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>ФотоСтудия №1</title>
</head>
<body>
    <header class="header">
        <div class="header__inner">
            <div class="header__right container">
                <nav class="header__nav">
                    <a href="#places" class="header__link">Залы</a>
                    <a href="#photographers" class="header__link">Фотографы</a>
                    <a href="#request" class="header__link">Оформить заявку</a>
                </nav>
            </div>
        </div>
        <div class="header__description container">
            <div class="header__name-wrapper">
                <h1 class="header__name">Фотостудия №1</h1>
            </div>
        </div>
    </header>
    <main class="main">
        <section class="places" id="places">
            <div class="places__inner container">
                <h1 class="places__title">Залы</h1>
                <?php
                    foreach($queryPlaceFetch as $value){
                ?>
                <div class="places__item">
                    <div class="places__img-container">
                        <img src = "<?=$value[4]?>" alt="place <?=$value[0]?>" class="places__img">
                    </div>
                    <div class="places__text-cover">
                        <div class="places__name-container">
                            <span class="places__name"><?=$value[1]?></span>
                        </div>
                        <div class="places__description-container">
                            <p class="places__description"><?=$value[3]?></p>
                        </div>
                        <div class="places__price-container">
                            <span class="places__price"><?=$value[2]?> руб.</span>
                        </div>
                    </div>
                </div>
                <?php
                    }
                ?>
            </div>
        </section>
        <section class="photographers" id="photographers">
            <h1 class="photographers__title">Фотографы</h1>
            <div class="photographers__inner container">
                    <?php
                        foreach($queryPhotographerFetch as $value){
                    ?>
                    <div class="photographers__item">
                        <div class="photographers__img-container">
                            <img src="<?=$value[4]?>" alt="place <?=$value[0]?>" class="photographers__img">
                        </div>
                        <div class="photographers__name-container">
                            <span class="photographers__name"><?=$value[1]?></span>
                        </div>
                    </div>
                    <?php
                        }
                    ?>
            </div>
        </section>
        <section class="request" id="request">
            <div class="request__inner container">
                <div class="request__title-container">
                    <h1 class="request__title">Оформить заявку</h1>
                </div>
                <div class="request__form-container">
                <form action="process.php" method = "POST" class="request__form">
                    <label class="request__label" for="client__name">Ваше ФИО</label>
                    <input type="text" name ="clientName" autocomplete = "off" class="request__input" id="client__name" required>
                    <label class="request__label" for="client__phone">Ваш телефон</label>
                    <input type ="tel" name = "clientPhone" autocomplete = "off" class="request__input" id="client__phone" required>
                    <label class="request__label">Выберите дату</label>
                    <input type="datetime-local" name = "clientDateTimeEnter" class="request__input" required>
                    <input type="datetime-local" name = "clientDateTimeExit" class="request__input" required>
                    <label class="request__label">Выберите зал</label>
                    <select name = "selectPlace" class="request__select" required>
                        <?php
                            foreach ($queryPlaceFetch as $value){
                                ?>
                                <option value ="<?=$value[0]?>" name = "clientPlace"><?= $value[1] ?></option>
                        <?php
                            }
                        ?>
                    </select>
                    <label class="request__label">Выберите фотографа</label>
                    <select name = "selectPhotographer" class="request__select">
                        <option value = "no" name="clientPhotographer">Нет</option>
                        <?php
                            foreach($queryPhotographerFetch as $value){
                                ?>
                                <option value = "<?=$value[0]?>" name = "clientPhotographer"><?= $value[1]?></option>
                        <?php
                            }
                        ?>
                    </select>
                    <input name ="sumbit" type = "submit" class="request__btn">
                </form>
                </div>
            </div>
        </section>
    </main>
</body>
</html>