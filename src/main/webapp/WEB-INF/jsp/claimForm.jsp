<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

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
    let userName = $('#userName').text();

    <!-- ************************* -->
    <!-- ******* Find All Claims ****** -->
    $.ajax({
        type:'GET',
        dataType:'json',
        url: "/claims" ,
        success: function(data) {
            if(data == null){
                return;
            }else{
                $.each(data.item,function(index,val){
                    $("#tbl_claims").append(
                        "<tr>"+
                           "<td>"+val.claimId+"</td>"+
                           "<td>"+userName+"</td>"+
                           "<td>" +val.claimTitle+"</td>"+
                           "<td>"+val.accidentDate+"</td>"+
                           "<td>" +val.itemDetailName+"</td>"+
                           "<td>" +val.itemCost+"</td>"+
                           "<td>" +val.fileName+"</td>"+
                           "<td>" +val.status+"</td>"+

                           "<td><a style='color:#00008B' class='tbl_approve' href='#'>Approve</a></td>"+
                           "<td><a style='color:#00008B' class='tbl_decline' href='#'>Decline</a></td>"+

                        "</tr>"
                    )

                });
            }
        },
        error: function(e) {
           console.log(e.message);
        }
    }); <!-- Close Ajax -->


    <!-- ******* Save Claim ****** -->
    $("#saveClaim").click(function(){
        let c_username = userName;
        if(c_username == ""){
            alert("You need to login!");
        }

        let c_accidentDate = $("#claimDate").val();
        var currentDateTime = new Date(c_accidentDate);
        var c_dateTimeString = currentDateTime.toISOString(); // Convert the Date object to a string in ISO 8601 format

        // alert("dateTimeString:" + c_dateTimeString);

        let c_claimTitle = $("#claimTitle").val();
        let c_status = "PENDING";
        let c_itemDetailName = $("#itemDetailName").val();
        let c_itemCost = $("#itemCost").val();


        var formData = new FormData();
        formData.append('file', $('#file')[0].files[0]);
        formData.append('username', c_username);
        formData.append('claimTitle',c_claimTitle);
        formData.append('status', c_status);
        formData.append('accidentDate', c_dateTimeString);
        formData.append('itemDetailName', c_itemDetailName);
        formData.append('itemCost', c_itemCost);


        $.ajax({
            url: '/claim/save',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log('File uploaded successfully');
                alert("Claim added");
                $("#itemDetailName").val("");
                $("#itemCost").val("");
            },
            error: function(xhr, status, error) {
                console.error('Failed to upload file');
            }
        });
    });


    <!-- ******** Update Claim by ClaimId ******** -->
    <!-- **** click on tr to display detail and set APPROVE ***** -->
    $("#tbl_claims").on("click", ".tbl_approve",function(){
        let claimId =  $(this).parent().parent().children("td").eq(0).text();

        let updateClaim = new Object();
        updateClaim.claimId = claimId;
        updateClaim.status = "APPROVED";
        updateClaim.username = userName;

        $.ajax({
            url: "/updateClaim",
            type: "PUT",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(updateClaim),
            success: function (result) {
                console.log('File uploaded successfully');
                window.location.href = "http://localhost:9696/claimForm";
            },
            error: function(xhr, status, error) {
                console.error('Failed to upload file');
            }
        });
    });



    <!-- ******** Update Claim by ClaimId ******** -->
    <!-- **** click on tr to display detail and set DECLINED ***** -->
    $("#tbl_claims").on("click", ".tbl_decline",function(){
        let claimId =  $(this).parent().parent().children("td").eq(0).text();

        let updateClaim = new Object();
        updateClaim.claimId = claimId;
        updateClaim.status = "DECLINED";
        updateClaim.username = userName;

        $.ajax({
            url: "/updateClaim",
            type: "PUT",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(updateClaim),
            success: function (result) {
                console.log('File uploaded successfully');
                window.location.href = "http://localhost:9696/claimForm";
            },
            error: function(xhr, status, error) {
                console.error('Failed to upload file');
            }
        });
    });



    <!-- ******* Download file ******** -->

    <!-- **** click on tr to download the file ***** -->
    $("#tbl_claims").on("click", ".tbl_download",function(){
        let fileName =  $(this).parent().parent().children("td").eq(6).text();

        $.ajax({
            url: "/download_file/"+ fileName,
            type: "GET",

            success: function (result) {
                console.log('File uploaded successfully');

            },
            error: function(xhr, status, error) {
                console.error('Failed to upload file');
            }
        });
    });
});
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
                            <a href="/documentForm">Document</a>
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

<div class="claimInfo">
    <div>
        <h1>Claim Form<h1>
        <sec:authorize access="isAuthenticated()">
            <p style="display:none" id="userName">${loggedInUserName}</p>
            <p style="display:none" id="userEmail">${loggedInUserEmail}</p>
            <h5>Hello ${loggedInUserName}</h5>
        </sec:authorize>

        <div id="claimDescriptionInner">
            <sec:authorize access="hasAuthority('User')">
            <form id="uploadForm" method="POST" enctype="multipart/form-data">

                <h4>Claim Title</h4>
                <input type="text" id="claimTitle" />

                <h4>Accident Date</h4>
                <input type="date" id="claimDate" />

                <hr>
                <h4>Add Claim Detail</h4>
                <div>
                    <h5>Item Detail:</h5>
                    <input class="form-control" type="text" id="itemDetailName"/>
                </div>

                <div>
                    <h5>Cost:</h5>
                    <input class="form-control" type="text" id="itemCost"/>
                </div>

                <h4>Upload Files</h4>
                <input type="file" name="file" id="file">

                <br>
                <input id="saveClaim" type="button" class="btb btn-primary" value="Add Claim">
            </form>
            </sec:authorize>
        </div>
        <br>
        <hr>
        <div id="claimList">
            <sec:authorize access="hasAuthority('Admin')">
            <h1>Claim List</h1>
            <table border="1" id="tbl_claims">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Item Detail</th>
                        <th>Item Cost</th>
                        <th>File Name</th>
                        <th>Status</th>
                        <th colspan="2"> Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            </sec:authorize>
        </div>
    </div>
</body>
</html>