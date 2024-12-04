<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Insurance - Press</title>

    <link rel="shortcut icon" href="images/favicon.png" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" rel="stylesheet" type="text/css">


    <link href="css/icons.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/easy-responsive-tabs.css " />
    <link rel="stylesheet" type="text/css" href="css/flexslider.css " />
    <link rel="stylesheet" type="text/css" href="css/owl.carousel.css">
    <!--[if lt IE 8]><!-->

    <!--<![endif]-->
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <link href="css/userInfo.css" rel="stylesheet" type="text/css">
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link  href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function() {
alert(${stripePublicKey});
alert(${amount});

})
</script>
<body>
    <div>

        <form action="/charge" method="POST" id="checkout-form">
                    <input type = 'hidden' value='{$amount}' name='amount' />
                   <label>Price:<span text='${amount/100}' /></label>


                    <script
                        src='https://checkout.stripe.com/checkout.js'
                        class='stripe-button'
                        attr='data-key="pk_test_51OmLEpKDb0qvGgbUI4vjYAFhN3VkmwkWdueVk1rUcxumiLvC48VkvmH38ZC1oD0QkqZ5FKOXXyKcTuXmKdIXOTFU00COlsNE9S",data-amount=${currency},data-currency=${currency}',
                        data-name='Aileen'
                        data-description='Aileen checkout'
                        data-image='https://www.baeldung.com/wp-content/themes/baeldung/favicon/android-chrome-192x192.png'
                        data-locale='auto'
                        data-zip-code='false'>
                    </script>

                </form>    '
    </div>
</body>
</html>

