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

     <link href="css/autoPlan.css" rel="stylesheet" type="text/css">
     <link href="css/userInfo.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" type="text/css" href="css/easy-responsive-tabs.css " />
    <link rel="stylesheet" type="text/css" href="css/flexslider.css " />
    <link rel="stylesheet" type="text/css" href="css/owl.carousel.css">
    <!--[if lt IE 8]><!-->

    <!--<![endif]-->
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        $(document).ready(function(){
            let quoteUserName;
            let quoteEmail;
            let quoteDriverId;
            let quoteVehicleId;
            let quotePlanId;
            let payAmount;
            let paymentStatus;

            <!-- ******** Account Info ********* -->
            quoteUserName = $("#userName").text();
            quoteEmail = $("#userEmail").text();
            $("#accountName").text(quoteUserName);
            $("#accountEmail").text(accountEmail);

            <!-- ****** Driver Info ******** -->
            $.ajax({
                type:'GET',
                dataType:'json',
                url: "/driverByUsername/" + quoteUserName ,
                success: function(data) {
                    quoteDriverId = data.id;
                    $("#firstName").text(data.firstname);
                    $("#lastName").text(data.lastname);
                    $("#gender").text(data.gender);
                    $("#dob").text(data.DOB);

                    let addressObj = data.address.street + " " + data.address.city + " " + data.address.state + " " + data.address.country + " " + data.address.zipCode;
                    $("#address").text(addressObj);
                    if(data == null){
                        alert("Can not find your information. Please check you Account info.");
                        return;
                    }
                },
                error: function(e) {
                   console.log(e.message);
                }
            }); <!-- Close Ajax -->

            <!-- ****** Vehicle Info ******** -->
            $.ajax({
                type:'GET',
                dataType:'json',
                url: "/vehicleByUsername/" + quoteUserName ,
                success: function(data) {
                    quoteVehicleId = data.id;
                    $("#brand").text(data.brand);
                    $("#year").text(data.year);
                    $("#mileage").text(data.mileage);vehicleValue
                    $("#incidentNo").text(data.accidentCount);
                    $("#vehicleValue").text(data.vehicleValue);
                    $("#purchaseDate").text(data.purchaseDate);

                    if(data == null){
                        alert("Can not find your information. Please check you Account info.");
                        return;
                    }
                },
                error: function(e) {
                   console.log(e.message);
                }
            }); <!-- Close Ajax -->

            <!-- ****** DesiredPlan Info ******** -->
            $.ajax({
                type:'GET',
                dataType:'json',
                url: "/desiredPlanByUsername/" + quoteUserName ,
                success: function(data) {
                    $("#purchasePeriod").text(data.purchasePeriod);
                    $("#desireStartDate").text(data.desireStartDate);

                    var planId = data.planId;

                    $.ajax({
                         type:'GET',
                         dataType:'json',
                         url: "/plan/" + planId ,
                         success: function(data) {
                             quotePlanId = data.planId;
                             var basePrice = parseInt(data.basePrice);

                             $("#planName").text(data.name+ " Plan");
                             $("#planType").text(data.planType);
                             $("#basePrice").text("$" + data.basePrice);

                             var planPolicies = data.policies.policies;

                             <!-- ******* Loop through policies ****** -->
                             $.each(planPolicies, function(index, val){
                                 $("#policies").append(
                                    "<li>* " + val.name + "</li>"
                                 )
                             });
                             $("#description").text(data.description);


                             <!-- ******  CAlCULATE PRICE ****** -->
                             var subTotal = (basePrice + 15);
                             var total = ((subTotal / 100) * 10) + subTotal;

                             $("#subTotal").text("$" + subTotal);
                             $("#total").text("$" + total);
                             $("#payAmount").text("$" + total);
                             payAmount = total;
                         }
                    });


                    if(data == null){
                        alert("Can not find your information. Please check you Account info.");
                        return;
                    }
                },
                error: function(e) {
                   console.log(e.message);
                }


            }); <!-- Close Ajax -->


            <!-- ******* Save yourQuote ****** -->
            $("#saveYourQuote").click(function(){
                let yourQuote = new Object();
                yourQuote.username = quoteUserName;
                yourQuote.quoteEmail = quoteEmail;
                yourQuote.driverId = quoteDriverId;
                yourQuote.vehicleId = quoteVehicleId;
                yourQuote.DesiredPlanId = quotePlanId;
                yourQuote.total = payAmount;
                yourQuote.paymentStatus = "PENDING";

                $.ajax({
                     url: "/saveYourQuote",
                     type:'POST',
                     dataType:'json',
                     contentType: "application/json; charset=utf-8",
                     data: JSON.stringify(yourQuote),
                     success: function (result) {

                     },
                     error: function (err) {
                         // check the err for error details
                    }
                });
            });

            <!-- **** Link to make a payment **** -->
            <!-- "http://localhost:9696/card?username=" + quoteUserName + "&email=" + quoteEmail + "&amount=" + payAmount -->
            $("#makePayment").click(function(){
                var baseUrl = 'http://localhost:9696/card?username=';

                window.location.href = baseUrl + quoteUserName + "&email=" + quoteEmail + "&amount="+ payAmount;
            });

        });
    </script>
</head>

<body>
    <header>
        <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 address">
                        <i class="ti-location-pin"></i> 2109 WS 09 Oxford Rd #127 ParkVilla Hills, MI 48334
                    </div>
                    <div class="col-sm-6 social">
                        <ul>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-facebook-square"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin-square"></i></a></li>
                            <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                            <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                            <li><a href="#"><i class="fa fa-youtube"></i></a></li>
                            <li id="loginUser">
                                <sec:authorize access="isAuthenticated()">
                                    <p class="userName">User: ${loggedInUserName}</p>

                                </sec:authorize>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                        <i class="fa fa-bars"></i>
                    </button>
                    <a class="navbar-brand" href="index.html">
                        <span>Aileen's</span>Insurance
                    </a>
                    <p>Call Us Now <b>+215 (362) 4579</b></p>
                </div>
                <div class="collapse navbar-collapse navbar-main-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="/home">Home</a>
                        </li>
                        <li>
                            <a href="/claimForm">Claim</a>
                        </li>
                        <li>
                            <a href="/chatGptForm">ChatGPT</a>
                        </li>
                        <li>
                            <a href="contact-us.html">Contact</a>
                        </li>

                        <li>
                            <security:authorize access="isAuthenticated()">
                                <a class="dropdown-item" href="/login?logout" >Logout</a>
                            </security:authorize>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>


    <div class="yourQuoteForm">
        <sec:authorize access="isAuthenticated()">
            <p style="display:none" id="userName">${loggedInUserName}</p>
            <p style="display:none" id="userEmail">${loggedInUserEmail}</p>
        </sec:authorize>
        <div class="container">
            <h1 id="yourQuote">Insurance Purchase Detail</h1>
            <div id="yourQuoteForm">
                <div id="accountInfo"><br>
                    <h4>ACCOUNT INFORMATION</h4>
                    <table>
                        <tr>
                            <td>Account Name:</td>
                            <td id="accountName"></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td id="accountEmail"></td>
                        </tr>

                        <tr>
                            <td>Pay Amount:</td>
                            <td id="payAmount"></td>
                        </tr>


                    </table>
                </div>

                <br>
                <div id="userInfo">
                <h4>DRIVERS INFORMATION</h4>
                    <table>
                        <tr>
                            <td>First Name:</td>
                            <td id="firstName"></td>
                        </tr>
                        <tr>
                            <td>Last Name:</td>
                            <td id="lastName"></td>
                        </tr>
                        <tr>
                            <td>Gender:</td>
                            <td id="gender"></td>
                        </tr>
                        <tr>
                            <td>Birth Date:</td>
                            <td id="dob"></td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td id="address"></td>
                        </tr>
                    </table>
                    <table id="member">

                    </table>
                </div>

                <hr>
                <br>
                <div id="vehicleInfo">
                <h5>VEHICLE INFORMATION</h5>
                    <table>
                        <tr>
                            <td>Brand:</td>
                            <td id="brand"></td>
                        </tr>

                        <tr>
                             <td>Year:</td>
                             <td id="year"></td>
                        </tr>
                        <tr>
                             <td>Mileage:</td>
                             <td id="mileage"></td>
                        </tr>
                        <tr>
                             <td>Incident Number:</td>
                             <td id="incidentNo"></td>
                        </tr>
                        <tr>
                             <td>Vehicle Value:</td>
                             <td id="vehicleValue"></td>
                        </tr>
                        <tr>
                             <td>Purchase Date:</td>
                             <td id="purchaseDate"></td>
                        </tr>
                    </table>
                </div>

                <hr>
                <br>
                <div id="planInfo">
                <h4>SELECTED PLAN AND POLICIES</h4>
                    <table>
                        <tr>
                             <td>Date to start:</td>
                             <td id="desireStartDate"></td>
                        </tr>
                        <tr>
                             <td>Purchase Duration:</td>
                             <td id="purchasePeriod"></td>
                        </tr>
                        <tr>
                             <td>Purchase Plan:</td>
                             <td id="planName"></td>
                        </tr>
                        <tr>
                             <td>Plan Type:</td>
                             <td id="planType"></td>
                        </tr>
                        <tr>
                             <td>Policies:</td>
                             <td >
                                <ul id="policies">
                                </ul>
                             </td>
                        </tr>
                        <tr>
                             <td>Description:</td>
                             <td id="description"></td>
                        </tr>
                    </table>
                </div>


                <hr>
                <br>
                <div id="payment">
                <h4>MONTHLY PAYMENT</h4>
                    <table>
                        <tr>
                            <td>Base Price:</td>
                            <td id="basePrice"></td>
                        </tr>
                        <tr>
                            <td>SubTotal:</td>
                            <td id="subTotal"></td>
                        </tr>
                        <tr>
                            <td>Sale Tax:</td>
                            <td id="tax">10%</td>
                        </tr>
                        <tr>
                            <td>Total:</td>
                            <td id="total"></td>
                        </tr>
                    </table>
                </div>

            </div>
            <button type="button" id="saveYourQuote" class="btn btn-primary">Save</button>
            <br>
            <br>
            <button type="button" id="makePayment" class="btn btn-primary">Purchase</button>
        </div>
    </div>



</body>
</html>