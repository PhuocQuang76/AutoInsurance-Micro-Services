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
            <!-- **** display a list of Plan ***** -->
            $.ajax({
                url: "/plans",
                type: 'GET',
                dataType: 'json', // added data type
                success: function(data) {
                    $.each(data, function(index,item) {
                        $.each(item,function(index,val){
                            $("#autoPlanList").append(
                                '<tr>'+
                                    '<td>'+ val.planId +'</td>'+
                                    '<td>'+
                                        '<td><i class="ti-car"></i>'+ "  " +  val.name+'</td>'+
                                    '</td>'+
                                '</tr>'

                             );
                        })
                    });
                },
                error: function(e) {
                    console.log(e.message);
                }
        }); <!-- Close Ajax -->

        <!-- **** click on tr to display detail ***** -->
        $("#autoPlanList").on("click", "td",function(){
            let planList;
            let id =  $(this).parent().children("td").eq(0).text();

            $.ajax({
                type:'GET',
                dataType:'json',
                url: "/plan/" + id ,
                success: function(data) {
                    $("#autoPlans").empty();
                    $("#autoPlans").append(
                        '<h3>'+ data.name +'</h3>'+
                        '<p>'+  data.planType +'</p>'+
                        '<p>$'+ data.basePrice+'</p>'+
                        '<p>'+ data.description+'</p>'

                    );
                    $.each(data.policies,function(index,item){
                        $.each(item,function(index,val){
                            $("#autoPlans").append(
                                '<p>*' + val.name + '</p>'
                            )
                        });
                    });
                    $("#autoPlans").append(
                        '<p>'+
                            '<a class="btn-default" href="/driverForm">Get Free Quote</a>'+
                        '</p>'
                     )

                }


            }); <!-- close ajax -->
        });

        });
    </script>
</head>

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
                            <li id="loginUser">
                                <sec:authorize access="isAuthenticated()">
                                    <p id="userName">User: ${loggedInUserName}</p>
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


    <section class="auto-plan">
        <h2 id="autoCare">Welcome to Auto Care</h2>
        <div class="container">

                <div id="autoInsurancePage">
                    <h4>Customized Commercial</h4>
                    <h4>Auto & Truck Insurance</h4>
                    <h4>To protect your business vehicles</h4>
                </div>

        </div>
    </section>


    <div class="wrapper">
            <!-- Sidebar  -->
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h2>Auto plans</h2>
                </div>
                <table id="autoPlanList"  class="components">
                </table>
            </nav>

            <!-- Page Content  -->
            <div class="content">
                <div id="autoPlans">
                </div>
                <div id="itemList">
                </div>
            </div>
        </div>


    <footer>
            <div class="container">
                <div class="row contact-sec">
                    <div class="col-md-5 col-lg-5">
                        <h2>Insurance<span></span></h2>
                        <div class="row">
                            <div class="col-sm-6">
                                <p>E104 Dharti -2 , Nr Silverstar Mall Chandlodia - Ahmedabad
                                    <br/>Zip - 382481</p>
                            </div>
                            <div class="col-sm-6">
                                <ul>
                                    <li><a href="#"><i class="fa fa-phone"></i> +91 123 456 7890</a></li>
                                    <li><a href="#"><i class="ti-email"></i> info@bootstrapmart.com</a></li>
                                </ul>
                            </div>
                        </div>
                        <a href="#" class="btn-default">Contact Us</a>
                    </div>
                    <div class="col-md-5 col-lg-5 col-md-offset-2 col-lg-offset-2">
                        <h2>Agent<span>Detail</span></h2>
                        <div class="row">
                            <div class="col-sm-6">
                                <p>E104 Dharti -2 , Nr Silverstar Mall Chandlodia - Ahmedabad
                                    <br/>Zip - 382481</p>
                            </div>
                            <div class="col-sm-6">
                                <ul>
                                    <li><a href="#"><i class="fa fa-phone"></i> +91 123 456 7890</a></li>
                                    <li><a href="#"><i class="ti-email"></i> info@bootstrapmart.com</a></li>
                                </ul>
                            </div>
                        </div>
                        <a href="#" class="btn-default">Contact Agent</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <ul class="footer-nav">
                            <li><a href="index.html">Home</a></li>
                            <li><a href="#">About Us</a></li>
                            <li><a href="blog.html">Blog</a></li>
                            <li><a href="#">Compnies represented</a></li>
                            <li><a href="contact-us.html">Contact us</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="#">Products</a></li>
                            <li id="loginUser">
                                <sec:authorize access="isAuthenticated()">
                                    <a class="dropdown-item" href="/login?logout" >Logout</a>
                                </sec:authorize>
                            </li>

                        </ul>
                    </div>
                    <div class="col-md-2 col-lg-2 col-md-offset-2 col-lg-offset-2">
                        <ul class="footer-social">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-pinterest"></i></a></li>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="copyright">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            Copyright &copy; 2018 distributed by <a href="https://themewagon.com/">ThemeWagon</a>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-6 text-right">
                            <a href="#">Terms & Conditions</a>
                            <a href="#">Policy</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-hover-dropdown/2.2.1/bootstrap-hover-dropdown.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
        <script src="js/jquery.flexslider-min.js"></script>
        <script src="js/easyResponsiveTabs.js"></script>
        <script src="js/owl.carousel.js"></script>
        <script src="js/custom.js"></script>
        <script src="js/autoPlan.js"></script>
    </body>

    </html>