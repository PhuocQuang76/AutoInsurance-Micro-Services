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
    var claimDetailList = [];

    <!-- ******** Append claimList into the table ******** -->
    $(".addDescription").click(function(event){
        event.preventDefault()
        let name = $("#descriptionName").val();
        let cost = $("#cost").val();
        let description = $("#description").val();

        if(name != "" || cost != ""){

            var newRow = $("<tr>");
            newRow.append("<td><input id='ap_descriptionName' type='text' value='"+ name  +"'></td>");
            newRow.append("<td><input id='ap_cost' type='text' value='"+ cost  +"'/></td>");
            newRow.append("<td><input id='ap_description' type='text' value='"+ description  +"'/></td>");
            newRow.append("<td><a class='remove' href='#'>Remove</a></td>")
            $("#tbl-claimList tbody").append(newRow)

            var claimList = new Object();
            claimList.name = name;
            claimList.cost = cost;
            claimList.description = description;

            claimDetailList.push(claimList);

            $("#descriptionName").val("");
            $("#cost").val("");
            $("#description").val("");
        }
    });

    $("#tbl-claimList").on('click','.remove',function() {
        $(this).parent().parent().remove();
        return false;
    });

    <!-- ******* Save Claim ****** -->
    $("#saveClaim").click(function(){
        let c_username = userName;
        let c_claimTitle = $("#claimTitle").val();
        let c_accidentDate = $("#claimDate").val();
        let c_status = "PENDING";
        let c_comment = $("#claimComment").val();

        var formData = new FormData();
            formData.append('files', $('#files')[0]);
            formData.append('username', c_username);
            formData.append('status', c_status);
            formData.append('comment', c_comment);
            formData.append('claimTitle', c_claimTitle);
            formData.append('accidentDate', c_accidentDate);
            formData.append('claimDetails', claimDetailList);


            $.ajax({
                url: '/claim/save',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log('File uploaded successfully');
                },
                error: function(xhr, status, error) {
                    console.error('Failed to upload file');
                }
            });

    });




    <!-- ******** Update Document by documnet ******** -->



    <!-- ******* Save Document ******** -->

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
                            <a href="blog.html">Blog</a>
                        </li>
                        <li>
                            <a href="blog-details.html">Blog Details</a>
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

<div class="claimInfo">
    <div>
        <h1>Claim Form<h1>
        <sec:authorize access="isAuthenticated()">
            <p style="display:none" id="userName">${loggedInUserName}</p>
            <p style="display:none" id="userEmail">${loggedInUserEmail}</p>
            <h5>Hello ${loggedInUserName}</h5>
        </sec:authorize>

        <div id="claimDescriptionInner">
            <form id="uploadForm" method="POST" enctype="multipart/form-data">

                <h4>Claim Title</h4>
                <input type="text" id="claimTitle" />

                <h4>Accident Date</h4>
                <input type="date" id="claimDate" />


                <h4>Add Description</h4>
                <div>
                    <h5>Detail Item:</h5>
                    <input class="form-control" type="text" id="descriptionName"/>
                </div>

                <div>
                    <h5>Cost:</h5>
                    <input class="form-control" type="text" id="cost"/>
                </div>

                <div>
                    <h5>Description:</h5>
                    <input class="form-control" type="text" id="description"/>
                </div>

                <button class='addDescription btn btn-primary'>Add</button>

                <table border="1" id="tbl-claimList">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Cost</th>
                            <th>Description
                        </tr>
                    </thead>
                    <tbody />
                </table>

                <h4>Upload Files</h4>
                <input type="file" name="files" id="files" multiple>

                <h4>Comment</h4>
                <input type="text" name="comment" id="claimComment">


                <input id="saveClaim" type="button" class="btb btn-primary" value="Save">
            </form>
        </div>
        <br>
        <hr>
        <div id="claimList">
            <h1>Claim List</h1>
            <table border="1" id="tbl_claimList">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Comment</th>
                        <th>Claim Detail</th>
                        <th>File Name</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>