  <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
  <%@ page isELIgnored="false" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
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
    $(document).ready(function() {
        let userName = $('#userName').text();
        alert("username: " + userName);
        let driver;
        var vehicle;
        var address;


    <!-- ********* Driver  ******** -->

    <!-- *** Click submit to send driverInfo *** -->
    $(".driverInfoSave").click(function(){
        driver = new Object();
        address = new Object();
        address.street = $("#street").val();
        address.city = $("#city").val();
        address.state = $("#state").val();
        address.country = $("#country").val();
        address.zipCode = $("#zipCode").val();

        driver.id = $("#driverName").val();
        driver.gender = $("#driverForm input[type='radio']:checked").val();
        driver.DOB = $("#DOB").val();
        driver.email = $("#email").val();
        driver.address = address;
        driver.vehicleValue = $("#vehicleValue").val();
        driver.driverLicenseNo =  $("#driverLicenseNo").val();

        <!-- *** Data check *** -->
        if($("#driverName").val()==""){
            alert("please fill out your information.");
            return;
        }

        <!-- ***** save drive into database **** -->
        alert(driver.driverName);
        $("#vehicleModal").toggle();

        let brandList = {
            "HONDA":1,"TOYOTA":2,"MERCEDES_BENZ":3,"TESLA":4,"BMW":5,"FORD":6,"HYUNDAI":7,"AUDI":8,"INFINITY":9
         };
        $.each(brandList,function(index, val){
            $("#brand").append(
                $('<option>', {
                    value: val,
                    text: index
                }));
        });

        $("#driver").val(driver.driverName);
    });

    <!-- ****************************-->
    <!-- ****** Close momdal ******* -->
    $(function () {
        $('.closeVehicleModal').on('click', function () {
            $('#vehicleModal').hide();
        })
    })

})
</script>
<body data-spy="scroll" data-target=".navbar-fixed-top">

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
                            <a href="blog.html">Blog</a>
                        </li>
                        <li>
                            <a href="blog-details.html">Blog Details</a>
                        </li>
                        <li>
                            <a href="contact-us.html">Contact</a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>
    </header>


    <div class="driverInfo">

        <h1>Driver Form</h1>
        <sec:authorize access="isAuthenticated()">
            <p id="userName"><security:authentication property="principal.username"/></p>
        </sec:authorize>
            <form id="driverForm">
            <table>

                <tr>
                    <td class="tdHead">Street</td>
                    <td class="tdBody" ><input type="text"  id="street" class="form-control" /></td>
                </tr>

                <tr>
                    <td class="tdHead">City</td>
                    <td class="tdBody"><input type="text" id="city" class="form-control" /></td>
                </tr>

                <tr>
                    <td class="tdHead">State</td>
                    <td class="tdBody"> <input type="text" id="state" class="form-control" /></td>
                </tr>

                <tr>
                    <td class="tdHead">Country</td>
                    <td class="tdBody"> <input type="text" id="country" class="form-control" /></td>
                </tr>

                <tr>
                    <td class="tdHead">ZipCode</td>
                    <td class="tdBody"><input type="text" id="zipCode" class="form-control" /></td>
                </tr>

                <tr>
                    <td class="tdHead">Driver License No.</td>
                    <td class="tdBody"><input type="text" id="driverLicenseNo" class="form-control" /></td>
                </tr>

            </table>
            <input type="button" value="Vehicle Information" class="driverInfoSave btn btn-primary"  style="height:1cm;width:4cm;"/>
            </form>
        </div>
    </div>

<div class="modal" id="vehicleModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
            <h4 class="modal-title">Vehicle Form</h4>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div class="col">
                    <form id="vehicleForm">
                        <table>
                        <tr>
                            <td class="tdHead">Brand</td>
                            <td>
                                <select class="form-control" id="brand"></select>
                            </td>
                        </tr>

                        <tr>
                            <td class="tdHead">Year</td>
                            <td class="tdBody"><input type="text" id="year" class="form-control" /></td>
                        </tr>

                        <tr>
                            <td class="tdHead">Driver</td>
                            <td class="tdBody"><input type="text"  id="driver"  class="form-control" /></td>
                        </tr>

                        <tr>
                            <td class="tdHead">Mileage</td>
                            <td class="tdBody"><input type="text"  id="mileage" class="form-control" /></td>
                        </tr>

                        <tr>
                            <td class="tdHead">Incident Count</td>
                            <td class="tdBody"><input type="text"  id="accident" class="form-control" /></td>
                        </tr>

                        <tr>
                            <td class="tdHead">Select plan</td>
                            <td id="autoPlan">
                                <label><input type="radio" name="autoPlan" value = "Premium Plan" />Premium</label>
                                <label><input type="radio" name="autoPlan" value="Silver Plan" />Silver</label>
                                <label><input type="radio" name="autoPlan" value="Basic Plan" />Basic</label>
                            </td>
                        </tr>

                        <tr>
                            <td class="tdHead">Purchase Date</td>
                            <td class="tdBody"> <input type="date" id="purchaseDate" class="form-control" /></td>
                        </tr>

                        </table>
                    </form>
                    <input style="margin-top:25px" class="btn btn-searchHotelRooms form-control btn-primary" type="button" id="" value="GET COVERAGE"/>
                </div>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="closeVehicleModal btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>