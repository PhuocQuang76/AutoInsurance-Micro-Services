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
    var memberList = [];

    <!--  *****  Add member to Driver Tab ******* -->
    $('#addMember').click(function(){
        $("#tbl_memberList").append(
            "<tr>"+
               "<td><input id='ap_firstname' type='text'/></td>"+
               "<td><input id='ap_lastname' type='text'/></td>"+
               "<td><input id='ap_dob' type='date'/></td>"+
               "<td><input id='ap_licenseNo' type='text'/></td>"+
               "<td><a class='remove' href='#'>Remove</a></td>"+
            "</tr>"
        )
        $("#tbl_memberList").on('click','.remove',function() {
            $(this).parent().parent().remove();
            return false;
        });
    });


    <!-- **** Display a list of brands For Vehicle Tab ****** -->
    let brandList = {"HONDA":1,"TOYOTA":2,"MERCEDES_BENZ":3,"TESLA":4,"BMW":5};
    $.each(brandList,function(index, val){
        $("#brand").append(
            $('<option>', {
                value: val.name,
                text: index
            })
        );
    });

    <!-- **** Display a list of plans For Plans Tab ****** -->
    <!-- **** display a list of Plan ***** -->
    let planCount = 1;
    while(planCount <5){
        $.ajax({
            type:'GET',
            dataType:'json',
            url: "/plan/" + planCount ,

            success: function(data) {
                let plan_name = data.name;
                let id = data.planId;
                $("#plan_list").append(
                    "<table>"+
                        "<tr><td style='display:none'>"+data.planId+"</td></tr>"+
                        "<tr><td><h4><i class='ti-car'></i>"+ "  "+data.name+" Plan<h4></td></tr>"+
                        "<tr><td><i class='ti-car'></i>"+ "  $" +data.basePrice+"</td></tr>"+
                        "<tr><td><i class='ti-car'></i>"+ "  " +data.planType+"</td></tr>"+
                        "<tr><td><i class='ti-car'></i>"+ "  " +data.description+"</td></tr>"+
                    "</table><br>"
                )

                $.each(data.policies,function(index,item){
                    $.each(item,function(index,val){
                        $("#plan_list").append(
                           "<table>"+
                               "<tr><td><p>*"+val.name+"<p></td></tr>"+
                           "</table>"
                        )
                    });
                });

                $("#plan_list").append(
                    "<label>"+
                        "<input type='radio' name='radioName' value='"+ id + "' />" + ' Select' +
                    "</label><br>"+
                    "<hr>"
                )
            },
            error: function(e) {
               console.log(e.message);
            }
        }); <!-- Close Ajax -->
        planCount++;
    }

    <!-- *********************************** -->
    <!-- ****** Click to save Plan and get A ******* -->
    $("#getAQuote").click(function(){
        let purchasePeriod;
        let desireStartDate;
        let selectedPlanId;
        let desiredPlanUserName;
        purchasePeriod = $('#selectedTerm option:selected').val()
        desireStartDate = $("#desireStartDate").val();
        selectedPlanId = $("#plan_list input[type='radio']:checked").val();

        desiredPlanUserName = $("#userName").text();

        let desiredPlan = new Object();
        desiredPlan.purchasePeriod = purchasePeriod;
        desiredPlan.desireStartDate = desireStartDate;
        desiredPlan.planId = selectedPlanId;

        desiredPlan.username = desiredPlanUserName;

        $.ajax({
             url: "/saveDesiredPlan",
             type:'POST',
             dataType:'json',
             contentType: "application/json; charset=utf-8",
             data: JSON.stringify(desiredPlan),
             success: function (result) {
                 alert("Complete Information...");
             },
             error: function (err) {
                 // check the err for error details
            }

        });


        <!-- ****** Save desiredPlan into DB ***** -->
    });




    <!-- ******* Select Tabs ******* -->
    $('#tabs').tabs(); // first tab selected
    $("#tabs>div a[href^='#']").click(function() {
        var index = $($(this).attr("href")).index() - 1
        $("#tabs").tabs("option", "active", index);
        return false
    })

    <!-- ********* Driver tab ******** -->
    $(".driverInfoSave").click(function(){

        <!-- Get and save member list added -->
        $("#tbl_memberList > tbody > tr").not(":first").each(function() {
            var member = new Object;
            member.firstname = $(this).find("input#ap_firstname").val();
            member.lastname = $(this).find("input#ap_lastname").val();
            member.DOB = $(this).find("input#ap_dob").val();
            member.licenseNo = $(this).find("input#ap_licenseNo").val();
            memberList.push(member);
        })

        <!-- ***** save drive into database **** -->

            let userName = $("#userName").text();
            var address = new Object();
            address.street = $("#street").val();
            address.city = $("#city").val();
            address.state = $("#state").val();
            address.country = $("#country").val();
            address.zipCode = $("#zipcode").val();
            let dob = $("#dob").val();
            let licenseNo = $("#licenseNo").val();

            var driver = new Object();
            driver.username = userName;
            driver.firstname = $("#firstname").val();
            driver.lastname = $("#lastname").val();
            driver.gender = $("#driverForm input[type='radio']:checked").val();
            driver.DOB = dob;
            driver.address = address;
            driver.driverLicenseNo = licenseNo;


            driver.members = new Array();
            for(let item of memberList) {
                alert("Memnber " + item.firstname + " " + item.lastname + " was added.");
                driver.members.push(item);
            }

            if(driver.username == ""){
                alert("Please log in to continue ...");
                window.location.href = '/login';
                return false;
            }

            if((driver.username=="") || (driver.DOB =="") && (address.street=='') || (address.city=='') && (address.city=='')
                && (address.state=='') || (address.country=='') || (address.zipCode=='') || (driver.driverLicenseNo=='')){
                alert("please fill in the form...");
                return;
            }else{

                $.ajax({
                    url: "/saveDriver",
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(driver),
                    success: function (result) {
                        alert("driver Information saved.");
                       // when call is sucessfull
                       if(result == null){

                       }else{

                           $("#firstname").val("");
                           $("#lastname").val("");
                           $("dob").val(new Date());
                           $('input[type=date]').val('');
                           $("#street").val("");
                           $("#city").val("");
                           $("#state").val("");
                           $("#country").val("");
                           $("#zipcode").val("");
                           $("#licenseNo").val("");
                            $("#tbl_memberList > tbody").empty();
                       }

                    },
                    error: function (err) {
                        // check the err for error details
                        alert("Driver information may existed.");
                        $("#firstname").val("");
                       $("#lastname").val("");
                       $("dob").val(new Date());
                       $('input[type=date]').val('');
                       $("#street").val("");
                       $("#city").val("");
                       $("#state").val("");
                       $("#country").val("");
                       $("#zipcode").val("");
                       $("#licenseNo").val("");
                       $("#tbl_memberList > tbody").empty();

                       return;
                    }
                }); // ajax call closing
            }

    });

    <!-- ********  Vehicle Information ********-->
    $(".vehicleInfoSave").click(function(){
        <!-- **** Opend confirm modal **** -->
        $("#modal_vehicleName").val($('#userName').text());
        $("#modal_brand").val($("#brand option:selected").val());
        $("#modal_year").val($("#year").val());
        $("#modal_mileage").val($("#mileage").val());
        $("#modal_accidentCount").val($("#accidentCount").val());
        $("#modal_value").val($("#vehicleValue").val());
        $("#modal_purchaseDate").val($("#purchaseDate").val());

        $("#vehicleConfirmModal").toggle();

        <!-- ***** save drive into database **** -->
        $(".btn-vehicleSave").click(function(){
            vehicle = new Object();

            let userName = $('#userName').text();
            let brand = $('#brand').find(":selected").val();
            let modalYear = $("#modal_year").val();
            let mileage = parseInt($("#modal_mileage").val());
            let accidentCount = $("#modal_accidentCount").val();
            let vehicleValue = $("#modal_value").val();
            let purchaseDate = $("#modal_purchaseDate").val();


            vehicle.username = userName;
            vehicle.brand = brand;
            vehicle.year = modalYear;
            vehicle.mileage = mileage;
            vehicle.accidentCount = accidentCount;
            vehicle.value = vehicleValue;
            vehicle.purchaseDate = purchaseDate;



            <!-- ***** save drive into database **** -->
            if(vehicle.username == ""){
                alert("Please log in to continue ...");
                window.location.href = '/login';
                return false;
            }
            if((vehicle.brand=='') && (vehicle.year=='') && (vehicle.mileage=='')
                && (vehicle.accidentCount=='') && (vehicle.value=='') && (vehicle.purchaseDate =='')){
                alert("please fill in the form...");
                return;
            }else{
                $.ajax({
                    url: "/saveVehicle",
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(vehicle),
                    success: function (result) {
                       // when call is sucessfull

                       $("#brand").val("");
                       $("#year").val("");
                       $("#mileage").val("");
                       $("#accidentCount").val("");
                       $("#vehicleValue").val("");
                       $("#purchaseDate").val("");


                    },
                    error: function (err) {
                        // check the err for error details
                    }

                }); // ajax call closing
                 $('#vehicleConfirmModal').hide();
            }
        });
    });


    <!-- *** Click submit to send driverInfo *** -->
    <!-- ****** Close modal ******* -->
    $(function () {
        $('.closeDriverConfirmModal').on('click', function () {
            $('#driverConfirmModal').hide();
        })
    })

    $(function () {
        $('.closeVehicleConfirmModal').on('click', function () {
            $('#vehicleConfirmModal').hide();
        })
    })


})
</script>
<body data-spy="scroll" data-target=".navbar-fixed-top">
<%
session.setAttribute("test","Hello");
%>
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
                                    <p id="userName">${loggedInUserName}</p>
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
                            <a href="/documentForm">Doc</a>
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



    <div id="tabs" class="driverInfo">
        <ul>
            <li><a href="#driverTab">Driver Info</a></li>
            <li><a href="#vehicleTab">Vehicle Info</a></li>
            <li><a href="#planTab">Select plan</a></li>
        </ul>

        <div id="driverTab" class="myTabs">
            <h1>Driver Form</h1>
            <sec:authorize access="isAuthenticated()">
                <p style="display:none" id="userName">${loggedInUserName}</p>
                <p style="display:none" id="userEmail">${loggedInUserEmail}</p>
            </sec:authorize>
                <form id="driverForm">
                <table>
                    <tr>
                        <td class="tdHead">First Name</td>
                        <td class="tdBody" ><input type="text"  id="firstname" class="form-control" /></td>
                    </tr>
                    <tr>
                       <td class="tdHead">Last Name</td>
                       <td class="tdBody" ><input type="text"  id="lastname" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td class="tdHead">DOB</td>
                        <td class="tdBody" ><input type="date"  id="dob" class="form-control" /></td>
                    </tr>

                    <tr>
                        <td class="tdHead">Gender</td>
                        <td id="gender">
                            <label><input type="radio" name="gender" value = "MALE" />Male</label>
                            <label><input type="radio" name="gender" value="FEMALE" />Female</label>
                        </td>
                    </tr>

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
                        <td class="tdBody"><input type="text" id="zipcode" class="form-control" /></td>
                    </tr>

                    <tr>
                        <td class="tdHead">Driver License No.</td>
                        <td class="tdBody"><input type="text" id="licenseNo" class="form-control" /></td>
                    </tr>

                </table>

                </form>
                <input type="button" value="Add more drivers" id="addMember" class="btn btn-primary"  style="height:1cm;width:4cm;"/>
                <br>
                <table border="1" id="tbl_memberList">
                    <tr>
                        <th>FirstName</th>
                        <th>LastName</th>
                        <th>DOB</th>
                        <th>License No</th>
                    </tr>
                </table>
                <br>
                <input type="button" value="save" class="driverInfoSave btn btn-primary"  style="height:1cm;width:4cm;"/>

                <br><br>
                <p style="height:1cm;width:4cm;"><a  class="nextButton btn btn-primary" href="#vehicleTab" >Next</a></p>
        </div>







        <div id="vehicleTab" class="myTabs">
            <h1>Vehicle Form</h1>
                <form id="vehicleForm">
                <table>
                    <tr>
                        <td class="tdHead">Brand</td>
                        <td class="tdBody">
                           <select class="form-control" id="brand"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdHead">Year Modal</td>
                        <td class="tdBody"><input type="text" id="year" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td class="tdHead">Mileage</td>
                        <td class="tdBody"><input type="text"  id="mileage"  class="form-control" /></td>
                    </tr >
                    <tr id="AcciCount">
                        <td class="tdHead">Incident Number</td>
                        <td class="tdBody"><input type="text"  id="accidentCount" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td class="tdHead">Vehicle Value</td>
                        <td class="tdBody"><input type="text"  id="vehicleValue" class="form-control" /></td>
                    </tr>
                    <tr>
                        <td class="tdHead">Purchase Date</td>
                        <td class="tdBody"><input type="date"  id="purchaseDate" class="form-control" /></td>
                    </tr>

                </table>
                <br>
                <input type="button" value="save" class="vehicleInfoSave btn btn-primary"  style="height:1cm;width:4cm;"/>
                </form>
                <br>
                <p style="height:1cm;width:4cm;"><a class="nextButton btn btn-primary" href="#tabs-3" >Next</a></p>
        </div>






        <div id="planTab" class="myTabs">
            <h1>Choose your plan</h1>
            <form id="planForm">
                <table>
                    <tr>
                        <td class="tdQues" ><h5>* Date want to start the insurance</h5></td>
                    </tr>
                    <tr>
                        <td class="tdAns" ><input type="date" id="desireStartDate" /></td>
                    </tr>
                    <tr>
                        <td class="tdQues" ><h5>* Which term do you want to use the insurance</h5></td>
                    </tr>

                    <tr><td>
                        <select class="form-control" id="selectedTerm">
                            <option name="term" value="Long term">Long Term</option>
                            <option name="term" value="Short term">Short Term</option>
                        </select>

                    </td></tr>
                </table>

                <h5>* Please select your plan</h5>
                <div id="plan_list">

                </div>
                <button type="button" id="getAQuote" class="btn btn-primary">Save</button>

                <br>

                <br>
                <a class="btn btn-primary btn-getYourQuote" href="/yourQuoteForm">Get Your Quote</a>
                <hr>
            </form>

        </div>








        <div class="modal" id="vehicleConfirmModal">
            <div class="modal-dialog modal-sx modal-dialog-scrollable">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h3 class="modal-title">Vehicle information Confirmation</h3>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <div class="col">
                            Driver Name:<input class=".vehicleAttr form-control" type="text" id="modal_vehicleName"/>
                            Brand:<input class=".vehicleAttr form-control" type="text" id="modal_brand"/>
                            Year:<input class=".vehicleAttr form-control" type="text" id="modal_year"/>
                            Mileage:<input class=".vehicleAttr form-control" type="text" id="modal_mileage"/>
                            Accident Count:<input class=".vehicleAttr form-control" type="text" id="modal_accidentCount"/>
                            Value:<input class=".vehicleAttr form-control" type="text" id="modal_value"/>
                            Purchase Date:<input class=".vehicleAttr form-control" type="text" id="modal_purchaseDate"/>

                            <input style="margin-top:25px" class=".vehicleAttr btn btn-vehicleSave form-control btn-primary" type="button" id="" value="Confirm"/>
                        </div>

                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                    <button type="button" class="closeVehicleConfirmModal btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
          </div>
        </div>

    </div>
</body>
</html>
"{"id":"54","username":"bob","firstname":"Bob","lastname":"Quang","gender":"FEMALE","address":{"street":"111","city":"granada hills","state":"Ca","country":"United States","zipCode":"91344"},"driverLicenseNo":"","members":{"members":[{"id":"","firstname":"b","lastname":"Quen","driverLicenseNo":"","drivers":"","dob":""},{"id":"","firstname":"a","lastname":"Quen","driverLicenseNo":"","drivers":"","dob":""}]},"dob":""}"