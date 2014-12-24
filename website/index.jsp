<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>

    <head>
        <title>CarPool</title>
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootswatch/3.0.0/flatly/bootstrap.min.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script type="text/javascript" src="jquery.ui.timepicker.js?v=0.3.3"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
        <link rel="stylesheet" href="CSS/social.css">
        <link rel="stylesheet" href="CSS/htmlBody.css">
        <link rel="stylesheet" href="CSS/sidebar.css">
        <link rel="stylesheet" href="CSS/table.css">
        <link rel="stylesheet" href="CSS/RadioCheckBox.css">
        <link rel="stylesheet" href="CSS/jquery-ui-1.10.0.custom.min.css">                        
        <script type="text/javascript">
            <% if (session.getAttribute("userID") != null) {%>
            function load(url,callback) {
                var xmlhttp;
                if (window.XMLHttpRequest) xmlhttp = new XMLHttpRequest();
                else xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

                xmlhttp.onreadystatechange = function () {
                  if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                    callback(xmlhttp.responseText);
                  }
                };
                xmlhttp.open('GET', url);
                xmlhttp.send();
              }
              window.onload = function () {
                load('GetMessages.jsp',function(response){                  
                });
              };                        
            <%}%>
            
            
            function validateForm() {
                return true;
            }

            function fuelTypeProcess() {
                if (document.calculator.fuelTypeCost[0].checked) {
                    document.calculator.fuelCost.value = 72.50;
                }
                else {
                    document.calculator.fuelCost.value = 38.5;
                }
                calculateMaintenanceCost();
            }

            function calculateMaintenanceCost() {
                if (document.calculator.fuelTypeCost[0].checked) {
                    document.calculator.maintenanceCost.value = isCar() ? 0.625 : 0.2;
                }
                else
                {
                    document.calculator.maintenanceCost.value = isCar() ? 0.72 : 0.2;
                }
            }
            function calculateExpense() {
                var f = document.calculator;
                var maintenanceCost = f.maintenanceCost.value;
                var fuelCost = f.fuelCost.value;
                var mileage = f.mileage.value;
                var noOfDays = f.noOfDays.value;
                var kmsDay = f.kmsDay.value;
                var parkingCost = f.parkingCost.value;

                var costPerDay = (kmsDay / mileage * fuelCost) + maintenanceCost * kmsDay + parkingCost * 1;
                var result = costPerDay * noOfDays;

                //         result += parkingCost * noOfDays;
                result = Math.round(result);
                document.getElementById("costM").innerHTML = result;
                document.getElementById("costY").innerHTML = result * 12;

                document.getElementById("savingsY").innerHTML = "<br><br>1 Person : Rs." + (result * 12 * 0.5);
                if (isCar()) {
                    document.getElementById("savingsY").innerHTML = document.getElementById("savingsY").innerHTML + ("<br> 2 People: Rs." + (result * 12 * 2 / 3))

                }
            }

            function isCar() {
                return document.calculator.vehichleType[0].checked;
            }

        </script>
    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">                       
                    </button><a class="navbar-brand" href="homepage.jsp">CarPool</a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="index.jsp">Home</a>
                        </li>
                        <li>
                            <a href="works.jsp">How it works ?</a>
                        </li>
                        <% if (session.getAttribute("userID") == null) {%>
                        <li>
                            <a href="register.jsp">Register</a>
                        </li>
                        <%}%>
                        <li>
                            <a href="faqs.jsp">FAQ's</a>
                        </li>
                        <li>
                            <a href="contact.jsp">Contact</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tools<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#" data-toggle="modal" data-target="#CostCalc">Cost Calculator</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <% if (session.getAttribute("userID") != null) {%>
                    <p class="navbar-right">                                             
                    <div class="dropdown navbar-right" >
                        <button type="button" class="btn dropdown-toggle navbar-right" id="dropdownMenu1" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;<%="  " + session.getAttribute("userEmail")%>   
                        </button>  
                        <ul class="dropdown-menu navbar-right" role="menu" aria-labelledby="dropdownMenu1">
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="EditProfile.jsp"><i class="glyphicon glyphicon-user"></i>&nbsp;&nbsp;Edit Profile</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="help.jsp"><i class="glyphicon glyphicon-question-sign"></i>&nbsp;&nbsp;Help</a></li>
                            <li role="presentation"><a role="menuitem" tabindex="-1" href="logout.jsp"><i class="glyphicon glyphicon-off"></i>&nbsp;&nbsp;Logout</a></li>
                        </ul>
                    </div>
                    </p>
                    <%} else {%>
                    <form method="post" class="navbar-form " action="login.jsp">
                        <div class="form-group">
                            <input name="emailsign" type="email" placeholder="Email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <input name="pass" type="password" placeholder="Password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-success">Sign In</button>
                        <a href="forgotpass.jsp"><font style="padding-left:397px" color="white">Forgot Password?</font></a>
                    </form>                    
                    <%}%>
                </div>
            </div>
        </div>
        <% if (session.getAttribute("userID") != null) {%><br><%}%>
        <div class="row">
            <% if (session.getAttribute("userID") != null) {%>
            <div class="col-md-0">
                
                    <ul id="css3menu1" class="topmenu">
                        <nav>
                            <li class="topfirst"><a href="welcome.jsp" style="width:200px;height:50px;line-height:20px;"><i class="glyphicon glyphicon-dashboard"></i>&nbsp;&nbsp;&nbsp;&nbsp;DASHBOARD</a></li>
                            <li class="topmenu"><a  href="searchride.jsp" style="width:200px;height:50px;line-height:20px;"><i class="glyphicon glyphicon-search"></i>&nbsp;&nbsp;&nbsp;&nbsp;SEARCH RIDE</a></li>
                            <li class="topmenu"><a  href="postride.jsp" style="width:200px;height:50px;line-height:20px;"><i class="glyphicon glyphicon-map-marker"></i>&nbsp;&nbsp;&nbsp;&nbsp;POST RIDE</a></li>
                            <li class="topmenu"><a  href="viewAllRides.jsp" style="width:200px;height:50px;line-height:20px;"><i class="glyphicon glyphicon-road"></i>&nbsp;&nbsp;&nbsp;&nbsp;VIEW ALL RIDES</a></li>
                            <li class="topmenu"><a  href="messages.jsp" style="width:200px;height:50px;line-height:20px;"><i class="glyphicon glyphicon-envelope"></i>&nbsp;&nbsp;&nbsp;&nbsp;MESSAGES<span class="badge red"><%=session.getAttribute("NumMessages")%></span></a></li>
                        </nav>
                    </ul>
                
            </div>
            <%}%>
            <div class="col-md-<% if (session.getAttribute("userID") != null) {%>10<%} else {%>13<%}%>">
                <div class="jumbotron">
                    <div class="container">
                        <h1>What is CarPooling ?</h1>
                        <p>Many corporate employees working in software companies like Infosys, wipro, etc are daily travelling by their own cars. Instead of traveling alone, they can travel with some commuters or passengers by sharing the fuel expenses.</p>
                    </div>
                </div>
                <div class="container">
                    <!-- Example row of columns -->
                    <div class="row">
                        <div class="col-md-4">
                            <h2>Why carpooling ?</h2>
                            <p>We take the complete responsibility of providing carpoolers to you. If you are a car-owner we provide commuters and vice versa. We also manage your daily transactions so that you do not have the headache of "who travelled when".</p>
                        </div>
                        <div class="col-md-4">
                            <h2>What is the benefit going with CarPool ?</h2>
                            <p>As a carowner, you can travel at your comfort and receive 100% travel charges online without any effort.</p>
                            <p></p>As a commuter, you can travel at affordable price. It's 100% safe for females as all the people are authenticated by us.</p>
                        </div>                        
                        <div class="col-md-4">
                            <h2>How to join us ?</h2>
                            <ul>
                                <li>
                                    <a href="register.jsp">Register</a> and update your travel details.
                                </li>
                                <li>Start carpooling within a week.
                                    (Subjected to availability)</li>
                                <li>Do not pay cash after the journey.</li>
                                <li>Works like a pre-paid account.</li>
                            </ul>
                        </div>        
                    </div><hr><footer><center>
            <p>All rights reserved &copy; CarPool 2014</p>
            <p>Contact Us &nbsp:&nbsp;&nbsp;Amay.Smit.Shail.Carpool@gmail.com 
                <a href="https://twitter.com/amaysmitshail#" class="social-button social-button-tw" target="_blank">Follow</a>
                <a href="https://www.facebook.com/pages/CAR-Pooling/1432292633675525" class="social-button social-button-fb" target="_blank">Like</a>    
            </p></center>
        </footer>
                </div><!-- /container -->
            </div>
        </div>
        <div class="modal fade" id="CostCalc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Cost Calculator !</h4>
                    </div>
                    <div class="modal-body">

                        <form action="" name="calculator" onsubmit="return validateForm()">
                            <table>
                                <tr>
                                    <td>Kms/day<b>(round trip)</b>:</td>
                                    <td><input value="20" type="text" name="kmsDay" class="form-control"></td>
                                </tr>

                                <tr>
                                    <td>No of working Days/ month:</td>
                                    <td><input value="22" type="text" name="noOfDays" class="form-control"></td>
                                </tr>
                                <tr>
                                    <td>Kms/litre <b>(mileage)</b>:</td>
                                    <td><input value="12" type="text" name="mileage" class="form-control"></td>
                                </tr>
                                <tr>
                                    <td>Fuel Type:</td>
                                    <td><input name="fuelTypeCost" type="radio" id="fuelType1" value="petrol" checked onclick="fuelTypeProcess()" class="radio-inline"><label for="fuelType1">Petrol</label></input>                                                                                
                                        <input name="fuelTypeCost" type="radio" id="fuelType2" value="diesel" onclick="fuelTypeProcess()" class="radio-inline"><label for="fuelType2">Diesel</label></input>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Cost of fuel/litre: <b>(in Rs)</b></td>
                                    <td><input type="text" name="fuelCost" value="72.5" class="form-control"/></td>
                                </tr>

                                <tr>
                                    <td>Maintenance cost/km : <b>(in Rs)</b>)*</td>
                                    <td><input type="text" name="maintenanceCost" value="0.625" readonly="true" class="form-control"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Daily parking cost:<b>(if any) (in Rs)</b>)</td>
                                    <td><input value="10" type="text" name="parkingCost" class="form-control"/></td>
                                </tr>

                                <input type="hidden" name="calculate">
                                <tr>

                                    <td><br><button type="button" onclick="calculateExpense()" value="Calculate Cost" class="btn btn-default">Calculate Cost</button></td>

                                </tr>
                            </table>
                        </form>
                        <br>
                        <div style="color:green;"><center>* Maintenance Cost is calculated considering costs of service,spares,tyres etc.<br>
                                The result is at the bottom of the page</center>
                        </div>
                        <br>

                        <div style="display:inline;">
                            <b style="color:green;">Total Cost Incurred</b><br><br>

                            <b>Monthly: Rs. <span id="costM">0.0</span></b> <br>
                            <b>Yearly : Rs. <span id="costY">0.0</span> </b>
                        </div>

                        <div style="position:relative;bottom:64px;left:250px">
                            <b style="color:green;">Annual Savings pooling with</b>
                            <b><span id="savingsY"></span></b>
                        </div>  
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>