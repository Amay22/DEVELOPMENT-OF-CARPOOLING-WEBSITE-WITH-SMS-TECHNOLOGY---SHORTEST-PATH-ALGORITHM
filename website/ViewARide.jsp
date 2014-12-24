<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>

    <head>
        <title>Join Ride From All | CarPool</title>
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootswatch/3.0.0/flatly/bootstrap.min.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script type="text/javascript" src="jquery.ui.timepicker.js?v=0.3.3"></script>
        <link rel="stylesheet" href="CSS/social.css">
        <link rel="stylesheet" href="CSS/htmlBody.css">
        <link rel="stylesheet" href="CSS/sidebar.css">        
        <link rel="stylesheet" href="CSS/RadioCheckBox.css">
        <link rel="stylesheet" href="CSS/jquery-ui-1.10.0.custom.min.css">  
        <script type="text/javascript">
            
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
                    document.getElementById("savingsY").innerHTML = document.getElementById("savingsY").innerHTML + ("<br> 2 People: Rs." + (result * 12 * 2 / 3));

                }
            }

            function isCar() {
                return document.calculator.vehichleType[0].checked;
            }

        </script>     
        <script type="text/javascript">
            var distance = 0;
            var time = 0;
            var stops = [{"Geometry": {"Latitude": <%=request.getParameter("sourceLat")%>, "Longitude": <%=request.getParameter("sourceLng")%>}}];
            function initialize() {
                
                <% for(int k = 1; k < Integer.parseInt(""+request.getParameter("points")) ; k++){ %>                                              
                stops.push({"Geometry": {"Latitude": <%=request.getParameter("p"+k+"lat")%> , "Longitude":  <%=request.getParameter("p"+k+"lng")%>}});                         
                 <%
                }
                %> 
                               
                stops.push({"Geometry": {"Latitude": <%=request.getParameter("destLat")%> , "Longitude":  <%=request.getParameter("destLng")%>}});
                var mapOptions = {
                    zoom: 13,
                    center: new window.google.maps.LatLng(28.583810000000003, 77.30295333333333),
                    mapTypeId: window.google.maps.MapTypeId.ROADMAP
                };
                
                var days = ''+ <%="" + request.getParameter("days")%>;
                if(days.indexOf("1")>=0){                    
                    document.getElementById('days').innerHTML += "Monday ";                    
                }
                if(days.indexOf("2")>=0){                    
                    document.getElementById('days').innerHTML += "Tuesday ";                    
                }
                if(days.indexOf("3")>=0){                    
                    document.getElementById('days').innerHTML += "Wednesday ";                    
                }
                if(days.indexOf("4")>=0){                    
                    document.getElementById('days').innerHTML += "Thursday ";                    
                }
                if(days.indexOf("5")>=0){                    
                    document.getElementById('days').innerHTML += "Friday ";                    
                }
                if(days.indexOf("6")>=0){                    
                    document.getElementById('days').innerHTML += "Saturday ";                    
                }
                if(days.indexOf("7")>=0){                    
                    document.getElementById('days').innerHTML += "Sunday ";                    
                }

                
                var map = new window.google.maps.Map(document.getElementById("map-canvas"), mapOptions);

                // new up complex objects before passing them around
                var directionsDisplay = new window.google.maps.DirectionsRenderer();
                var directionsService = new window.google.maps.DirectionsService();

                directionsDisplay.setMap(map);
                directionsDisplay.setPanel(document.getElementById('directionsPanel'));

                calcRoute(directionsService, directionsDisplay);

            }

            function calcRoute(directionsService, directionsDisplay) {
                var batches = [];
                var itemsPerBatch = 10; // google API max = 10 - 1 start, 1 stop, and 8 waypoints
                var itemsCounter = 0;
                var wayptsExist = stops.length > 0;

                while (wayptsExist) {
                    var subBatch = [];
                    var subitemsCounter = 0;

                    for (var j = itemsCounter; j < stops.length; j++) {
                        subitemsCounter++;
                        subBatch.push({
                            location: new window.google.maps.LatLng(stops[j].Geometry.Latitude, stops[j].Geometry.Longitude),
                            stopover: true
                        });
                        if (subitemsCounter == itemsPerBatch)
                            break;
                    }

                    itemsCounter += subitemsCounter;
                    batches.push(subBatch);
                    wayptsExist = itemsCounter < stops.length;
                    // If it runs again there are still points. Minus 1 before continuing to 
                    // start up with end of previous tour leg
                    itemsCounter--;
                }

                // now we should have a 2 dimensional array with a list of a list of waypoints
                var combinedResults;
                var unsortedResults = [{}]; // to hold the counter and the results themselves as they come back, to later sort
                var directionsResultsReturned = 0;

                for (var k = 0; k < batches.length; k++) {
                    var lastIndex = batches[k].length - 1;
                    var start = batches[k][0].location;
                    var end = batches[k][lastIndex].location;

                    // trim first and last entry from array
                    var waypts = [];
                    waypts = batches[k];
                    waypts.splice(0, 1);
                    waypts.splice(waypts.length - 1, 1);

                    var request = {
                        origin: start,
                        destination: end,
                        waypoints: waypts,
                        travelMode: window.google.maps.TravelMode.DRIVING,
                        optimizeWaypoints: true,
                        unitSystem: google.maps.DirectionsUnitSystem.METRIC
                    };
                    (function(kk) {
                        directionsService.route(request, function(result, status) {
                            if (status == window.google.maps.DirectionsStatus.OK) {

                                var unsortedResult = {order: kk, result: result};
                                unsortedResults.push(unsortedResult);

                                directionsResultsReturned++;

                                if (directionsResultsReturned == batches.length) // we've received all the results. put to map
                                {
                                    // sort the returned values into their correct order
                                    unsortedResults.sort(function(a, b) {
                                        return parseFloat(a.order) - parseFloat(b.order);
                                    });
                                    var count = 0;
                                    for (var key in unsortedResults) {
                                        if (unsortedResults[key].result != null) {
                                            if (unsortedResults.hasOwnProperty(key)) {
                                                if (count == 0) // first results. new up the combinedResults object
                                                    combinedResults = unsortedResults[key].result;
                                                else {
                                                    // only building up legs, overview_path, and bounds in my consolidated object. This is not a complete 
                                                    // directionResults object, but enough to draw a path on the map, which is all I need											
                                                    combinedResults.routes[0].legs = combinedResults.routes[0].legs.concat(unsortedResults[key].result.routes[0].legs);
                                                    combinedResults.routes[0].overview_path = combinedResults.routes[0].overview_path.concat(unsortedResults[key].result.routes[0].overview_path);
                                                    combinedResults.routes[0].bounds = combinedResults.routes[0].bounds.extend(unsortedResults[key].result.routes[0].bounds.getNorthEast());
                                                    combinedResults.routes[0].bounds = combinedResults.routes[0].bounds.extend(unsortedResults[key].result.routes[0].bounds.getSouthWest());
                                                }
                                                count++;
                                            }
                                        }
                                    }
                                    calcDist(combinedResults);
                                    directionsDisplay.setDirections(combinedResults);
                                }
                            }
                        });
                    })(k);
                }
            }
            function calcDist(response) {
                var routes = response.routes;

                // Loop through all routes and append
                for (var rte in routes) {
                    var legs = routes[rte].legs;
                    for (var leg in legs) {
                        distance += legs[leg].distance.value;
                        time += legs[leg].duration.value;
                    }
                }
                document.getElementById('p').innerHTML = 'The Total Distance  = ' + distance;
                document.getElementById('p').innerHTML += '<BR>The Total Time      =  ' + time;
                
            }

        </script>
    </head>

    <body onload="initialize()">
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                    </button><a class="navbar-brand" href="homepage.jsp">CarPool</a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li>
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
                </div><!--/.navbar-collapse -->
            </div>
        </div>        <br>
        <div class="row">
            <div class="col-md-1">
                
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
            <div class="col-md-7 col-md-push-1">
                <div class="container">
                    <p>Hi, <%=" " + session.getAttribute("userName")%></p>

                    <br>                    
                        <table>
                            <tr>
                                <td> 
                                    <div id="map-canvas" style="width:540px;height:520px;"></div>
                                </td>
                                <td>
                                    <div id="directionsPanel" style="width:300px;max-height:520px;overflow-y:scroll"></div>

                                </td>
                            </tr>
                        </table>           
                        <div id="p"></div>
                        <BR>
                        <p id="name">       Name         : <%="" + request.getParameter("name")%></p>                        
                        <p id="driver">     Driver       : <%="" + request.getParameter("driver")%></p>
                        <p id="driverEmail">Email        : <%="" + request.getParameter("email")%></p>
                        <p id="driverPhone">Phone        : <%="" + request.getParameter("phone")%></p>
                        <p id="car">        Car          : <%="" + request.getParameter("car")%></p>
                        <p id="stime">      Start time   : <%="" + request.getParameter("stime")%></p>
                        <p id="etime">      End time     : <%="" + request.getParameter("etime")%></p>
                        <p id="fuel">       Fuel         : <%="" + request.getParameter("fuel")%></p>                                                                        
                        <p id="days">       Days         : </p>                        
                        <button type="button" class="btn btn-lg btn-success" onclick="window.location.href='welcome.jsp'">
                            Go Back
                        </button> 
                           <hr><footer><center>
            <p>All rights reserved &copy; CarPool 2014</p>
            <p>Contact Us &nbsp:&nbsp;&nbsp;Amay.Smit.Shail.Carpool@gmail.com 
                <a href="https://twitter.com/amaysmitshail#" class="social-button social-button-tw" target="_blank">Follow</a>
                <a href="https://www.facebook.com/pages/CAR-Pooling/1432292633675525" class="social-button social-button-fb" target="_blank">Like</a>    
            </p></center>
        </footer>
                </div>
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

