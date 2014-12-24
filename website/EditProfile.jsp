<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>    
    <head>
        <title>Edit Profile | CarPool</title>
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootswatch/3.0.0/flatly/bootstrap.min.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <link rel="stylesheet" href="CSS/social.css">
        <link rel="stylesheet" href="CSS/htmlBody.css">
        <link rel="stylesheet" href="CSS/sidebar.css">
        <link rel="stylesheet" href="CSS/table.css">
        <link rel="stylesheet" href="CSS/RadioCheckBox.css">
        <link rel="stylesheet" href="CSS/jquery-ui-1.10.0.custom.min.css">

        <script>
            $(function() {
                var date = new Date();
                var currentMonth = date.getMonth();
                var currentDate = date.getDate();
                var currentYear = date.getFullYear();
                $("#datepicker").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    maxDate: new Date(currentYear, currentMonth, currentDate)
                });
            });

        </script>
        
        <script type="text/javascript">             
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
                load('GetMessages.jsp',function(response){});
                initialize();
            };                                    
        </script>
                  
        
        
        <script type="text/javascript">
            var marker;
            var geocoder;
            function initialize() {
                var mapOptions = {
                    center: new google.maps.LatLng(19.089373, 72.835061),
                    zoom: 10
                };
                var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);  
                
                var xy = document.getElementById('ll').value;                                
                var x = parseFloat(xy.substring(0,xy.indexOf(",")));
                var y = parseFloat(xy.substring(xy.indexOf(",")+1));
                var latlngs = new google.maps.LatLng(x, y);
                
                input = /** @type {HTMLInputElement} */(document.getElementById('pac-input'));
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

                marker = new google.maps.Marker({
                    map: map,
                    draggable: true,
                    icon: 'http://entryworks.com/map_markers_poi/home.png',
                    title: 'home'                    
                });              
                geocoder = new google.maps.Geocoder();
                marker.setPosition(latlngs);                
                setUpAutoComplete(map, document.getElementById('pac-input'), marker);
                trackMarkerMovement(document.getElementById('pac-input'), marker);

                google.maps.event.addListener(map, 'click', function(event) {
                    placeMarker(event.latLng, document.getElementById('pac-input'), marker, map);
                });                                                
            }

            function setUpAutoComplete(map, element, marker) {

                var autocomplete = new google.maps.places.Autocomplete(element);
                autocomplete.bindTo('bounds', map);

                google.maps.event.addListener(autocomplete, 'place_changed', function() {
                    var place = autocomplete.getPlace();


                    if (place.geometry.viewport) {
                        map.fitBounds(place.geometry.viewport);
                    } else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(16);  // Why 17? Because it looks good.
                    }
                    marker.setPosition(place.geometry.location);

                    var address = '';
                    if (place.address_components) {
                        address = [(place.address_components[0] &&
                                    place.address_components[0].short_name || ''),
                            (place.address_components[1] &&
                                    place.address_components[1].short_name || ''),
                            (place.address_components[2] &&
                                    place.address_components[2].short_name || '')
                        ].join(' ');
                    }
                });
            }
            function trackMarkerMovement(element, marker) {
                google.maps.event.addListener(marker, 'drag', function() {
                    geocoder.geocode({'latLng': marker.getPosition()}, function(results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results[0]) {
                                element.value = (results[0].formatted_address);
                            }
                        }
                    });
                });
            }
            function placeMarker(location, element, marker, map) {
                if (location) {
                    marker.setPosition(location);
                    marker.setMap(map);
                    getLocationName(element, marker);
                    trackMarkerMovement(element, marker);
                }
            }
            function getLocationName(element, marker) {
                geocoder.geocode({'latLng': marker.getPosition()}, function(results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        if (results[0]) {
                            element.value = (results[0].formatted_address);
                        }
                    }
                });
            }
            function getVal() {                                
                document.getElementById('homelat').value = ''+marker.position.lat();
                document.getElementById('homelng').value = ''+marker.position.lng();                            
            }
            function checkPass()
            {

                var pass1 = document.getElementById('pass1');
                var pass2 = document.getElementById('pass2');
                var message = document.getElementById('confirmMessage');

                var goodColor = "#66cc66";
                var badColor = "#ff6666";

                if (pass1.value == pass2.value) {

                    pass2.style.backgroundColor = goodColor;
                    message.style.color = goodColor;
                    message.innerHTML = "Passwords Match!"
                } else {
                    document.getElementById('pass2').value = "";
                    pass2.style.backgroundColor = badColor;
                    message.style.color = badColor;
                    message.innerHTML = "Passwords Do Not Match!"
                }
            }

            function disableEnterKey(e) {
                var key;
                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox
                if (key === 13)
                    return false;
                else
                    return true;
            }

            function backspaceAlpha(e) {
                var key;
                if (window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox
                if (key >= 48 && key <= 57)
                    return true;
                else
                    return false;
            }           
            function backspaceAll(e) {
                return false;
            }           
        </script>
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
    </head>

    <body>
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
        </div><br>
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
            <div class="col-md-8 col-md-push-1">
                <div class="container">
                    <p>Hi, <%=" " + session.getAttribute("userName")%></p>
                    <h3>Edit Profile</h3>
                    <form onsubmit ="getVal()" method="post" action="edit.jsp">
                        <BR>
                        
                        
                        
                        <input type="hidden" id="ll" value="<%="" + session.getAttribute("userHomeLatLng")%>">                        
                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-0">
                                <input name="first" type="text" placeholder="Name" disabled value="<%="" + session.getAttribute("userName")%>" class="form-control" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-0">
                                <input id ="emailcheck" name="email" type="email" placeholder="Email"  disabled value="<%="" + session.getAttribute("userEmail")%>" onblur="verify()" class="form-control" required>
                                <span id="EmailExists" class="EmailExists"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-0">
                                <input name="pass1" id="pass1" type="password" placeholder="Password" value="<%="" + session.getAttribute("userpwd")%>" class="form-control" onchange="checkPass();" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-0">
                                <input type="password" name="pass2" id="pass2" placeholder="Confirm Password" value="<%="" + session.getAttribute("userpwd")%>" class="form-control" required onchange="checkPass();">
                                <span id="confirmMessage" class="confirmMessage"></span>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-0">
                                <input name="HouseNo" type="text" value="<%="" + session.getAttribute("userHouseNo")%>" placeholder="House No. & Building Name" class="form-control" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-0">
                                <div id="map-canvas" style="width:530px;height:420px;"></div>
                                <input required name="pac-input" id="pac-input" class="form-control controls" type="text" value="<%="" + session.getAttribute("userHomeAddr")%>" onkeypress="return disableEnterKey(event)" placeholder="Enter a location" title="Enter your location here or select on map below"  autocomplete="off"/>
                                <input type="hidden" name="homelat" id="homelat" value=""/>
                                <input type="hidden" name="homelng" id="homelng" value=""/> 
                            </div>
                        </div>
                        

                        <div class="row">
                            <div class="col-md-8 col-md-push-0 form-group">      
                                <select name ="country" class="form-control"><option value="AF">Afghanistan (+93)</option><option value="AL">Albania (+355)</option><option value="DZ">Algeria  ( +213)</option><option value="AD">Andorra  ( +376)</option><option value="AO">Angola  ( +244)</option><option value="AQ">Antarctica  ( +672)</option><option value="AG">Antigua and Barbuda  ( +1)</option><option value="AR">Argentina  ( +54)</option><option value="AM">Armenia  ( +374)</option><option value="AW">Aruba  ( +297)</option><option value="AC">Ascension Island  ( +247)</option><option value="AU">Australia  ( +61)</option><option value="AT">Austria  ( +43)</option><option value="AZ">Azerbaijan  ( +994)</option><option value="BS">Bahamas  ( +1)</option><option value="BH">Bahrain  ( +973)</option><option value="BD">Bangladesh  ( +880)</option><option value="BB">Barbados  ( +1)</option><option value="BY">Belarus  ( +375)</option><option value="BE">Belgium  ( +32)</option><option value="BZ">Belize  ( +501)</option><option value="BJ">Benin  ( +229)</option><option value="BM">Bermuda  ( +1)</option><option value="BT">Bhutan  ( +975)</option><option value="BO">Bolivia  ( +591)</option><option value="BA">Bosnia and Herzegovina  ( +387)</option><option value="BW">Botswana  ( +267)</option><option value="BV">Bouvet Island  ( +47)</option><option value="BR">Brazil  ( +55)</option><option value="IO">British Indian Ocean Territory  ( +44)</option><option value="BN">Brunei  ( +673)</option><option value="BG">Bulgaria  ( +359)</option><option value="BF">Burkina Faso  ( +226)</option><option value="BI">Burundi  ( +257)</option><option value="KH">Cambodia  ( +855)</option><option value="CM">Cameroon  ( +237)</option><option value="CA">Canada  ( +1)</option><option value="CV">Cape Verde  ( +238)</option><option value="KY">Cayman Islands  ( +1)</option><option value="CF">Central African Republic  ( +236)</option><option value="TD">Chad  ( +235)</option><option value="CL">Chile  ( +56)</option><option value="CN">China  ( +86)</option><option value="CX">Christmas Island  ( +61)</option><option value="CC">Cocos (Keeling) Islands  ( +61)</option><option value="CO">Colombia  ( +57)</option><option value="KM">Comoros  ( +269)</option><option value="CG">Congo  ( +242)</option><option value="CD">Congo (DRC)  ( +243)</option><option value="CK">Cook Islands  ( +682)</option><option value="CR">Costa Rica  ( +506)</option><option value="HR">Croatia  ( +385)</option><option value="CU">Cuba  ( +53)</option><option value="CY">Cyprus  ( +357)</option><option value="CZ">Czech Republic  ( +420)</option><option value="DK">Denmark  ( +45)</option><option value="DJ">Djibouti  ( +253)</option><option value="DM">Dominica  ( +1)</option><option value="DO">Dominican Republic  ( +1)</option><option value="EC">Ecuador  ( +593)</option><option value="EG">Egypt  ( +20)</option><option value="SV">El Salvador  ( +503)</option><option value="GQ">Equatorial Guinea  ( +240)</option><option value="ER">Eritrea  ( +291)</option><option value="EE">Estonia  ( +372)</option><option value="ET">Ethiopia  ( +251)</option><option value="FK">Falkland Islands (Islas Malvinas)  ( +500)</option><option value="FO">Faroe Islands  ( +298)</option><option value="FJ">Fiji Islands  ( +679)</option><option value="FI">Finland  ( +358)</option><option value="FR">France  ( +33)</option><option value="GF">French Guiana  ( +594)</option><option value="PF">French Polynesia  ( +689)</option><option value="GA">Gabon  ( +241)</option><option value="GM">Gambia, The  ( +220)</option><option value="GE">Georgia  ( +995)</option><option value="DE">Germany  ( +49)</option><option value="GH">Ghana  ( +233)</option><option value="GI">Gibraltar  ( +350)</option><option value="GR">Greece  ( +30)</option><option value="GL">Greenland  ( +299)</option><option value="GD">Grenada  ( +1)</option><option value="GP">Guadeloupe  ( +590)</option><option value="GU">Guam  ( +1)</option><option value="GT">Guatemala  ( +502)</option><option value="GG">Guernsey  ( +44)</option><option value="GN">Guinea  ( +224)</option><option value="GW">Guinea-Bissau  ( +245)</option><option value="GY">Guyana  ( +592)</option><option value="HT">Haiti  ( +509)</option><option value="HN">Honduras  ( +504)</option><option value="HK">Hong Kong SAR  ( +852)</option><option value="HU">Hungary  ( +36)</option><option value="IS">Iceland  ( +354)</option><option value="IN">India  ( +91)</option><option value="ID">Indonesia  ( +62)</option><option value="IR">Iran  ( +98)</option><option value="IQ">Iraq  ( +964)</option><option value="IE">Ireland  ( +353)</option><option value="IM">Isle of Man  ( +44)</option><option value="IL">Israel  ( +972)</option><option value="IT">Italy  ( +39)</option><option value="JM">Jamaica  ( +1)</option><option value="SJ">Jan Mayen  ( +47)</option><option value="JP">Japan  ( +81)</option><option value="JE">Jersey  ( +44)</option><option value="JO">Jordan  ( +962)</option><option value="KZ">Kazakhstan  ( +7)</option><option value="KE">Kenya  ( +254)</option><option value="KI">Kiribati  ( +686)</option><option value="KR">Korea  ( +82)</option><option value="KW">Kuwait  ( +965)</option><option value="KG">Kyrgyzstan  ( +996)</option><option value="LA">Laos  ( +856)</option><option value="LV">Latvia  ( +371)</option><option value="LB">Lebanon  ( +961)</option><option value="LS">Lesotho  ( +266)</option><option value="LR">Liberia  ( +231)</option><option value="LY">Libya  ( +218)</option><option value="LI">Liechtenstein  ( +423)</option><option value="LT">Lithuania  ( +370)</option><option value="LU">Luxembourg  ( +352)</option><option value="MO">Macao SAR  ( +853)</option><option value="MK">Macedonia, Former Yugoslav Republic of  ( +389)</option><option value="MG">Madagascar  ( +261)</option><option value="MW">Malawi  ( +265)</option><option value="MY">Malaysia  ( +60)</option><option value="MV">Maldives  ( +960)</option><option value="ML">Mali  ( +223)</option><option value="MT">Malta  ( +356)</option><option value="MH">Marshall Islands  ( +692)</option><option value="MQ">Martinique  ( +596)</option><option value="MR">Mauritania  ( +222)</option><option value="MU">Mauritius  ( +230)</option><option value="YT">Mayotte  ( +262)</option><option value="MX">Mexico  ( +52)</option><option value="FM">Micronesia  ( +691)</option><option value="MD">Moldova  ( +373)</option><option value="MC">Monaco  ( +377)</option><option value="MN">Mongolia  ( +976)</option><option value="ME">Montenegro  ( +382)</option><option value="MS">Montserrat  ( +1)</option><option value="MA">Morocco  ( +212)</option><option value="MZ">Mozambique  ( +258)</option><option value="MM">Myanmar  ( +95)</option><option value="NA">Namibia  ( +264)</option><option value="NR">Nauru  ( +674)</option><option value="NP">Nepal  ( +977)</option><option value="NL">Netherlands  ( +31)</option><option value="AN">Netherlands Antilles (Former)  ( +599)</option><option value="NC">New Caledonia  ( +687)</option><option value="NZ">New Zealand  ( +64)</option><option value="NI">Nicaragua  ( +505)</option><option value="NE">Niger  ( +227)</option><option value="NG">Nigeria  ( +234)</option><option value="NU">Niue  ( +683)</option><option value="KP">North Korea  ( +850)</option><option value="MP">Northern Mariana Islands  ( +1)</option><option value="NO">Norway  ( +47)</option><option value="OM">Oman  ( +968)</option><option value="PK">Pakistan  ( +92)</option><option value="PW">Palau  ( +680)</option><option value="PS">Palestinian Authority  ( +972)</option><option value="PA">Panama  ( +507)</option><option value="PG">Papua New Guinea  ( +675)</option><option value="PY">Paraguay  ( +595)</option><option value="PE">Peru  ( +51)</option><option value="PH">Philippines  ( +63)</option><option value="PL">Poland  ( +48)</option><option value="PT">Portugal  ( +351)</option><option value="QA">Qatar  ( +974)</option><option value="CI">Republic of Côte d'Ivoire  ( +225)</option><option value="RE">Reunion  ( +262)</option><option value="RO">Romania  ( +40)</option><option value="RU">Russia  ( +7)</option><option value="RW">Rwanda  ( +250)</option><option value="WS">Samoa  ( +685)</option><option value="SM">San Marino  ( +378)</option><option value="ST">São Tomé and Príncipe  ( +239)</option><option value="SA">Saudi Arabia  ( +966)</option><option value="SN">Senegal  ( +221)</option><option value="RS">Serbia  ( +381)</option><option value="SC">Seychelles  ( +248)</option><option value="SL">Sierra Leone  ( +232)</option><option value="SG">Singapore  ( +65)</option><option value="SK">Slovakia  ( +421)</option><option value="SI">Slovenia  ( +386)</option><option value="SB">Solomon Islands  ( +677)</option><option value="SO">Somalia  ( +252)</option><option value="ZA">South Africa  ( +27)</option><option value="ES">Spain  ( +34)</option><option value="LK">Sri Lanka  ( +94)</option><option value="SH">St. Helena  ( +290)</option><option value="KN">St. Kitts and Nevis  ( +1)</option><option value="LC">St. Lucia  ( +1)</option><option value="PM">St. Pierre and Miquelon  ( +508)</option><option value="VC">St. Vincent and the Grenadines  ( +1)</option><option value="SD">Sudan  ( +249)</option><option value="SR">Suriname  ( +597)</option><option value="SZ">Swaziland  ( +268)</option><option value="SE">Sweden  ( +46)</option><option value="CH">Switzerland  ( +41)</option><option value="SY">Syria  ( +963)</option><option value="TW">Taiwan  ( +886)</option><option value="TJ">Tajikistan  ( +992)</option><option value="TZ">Tanzania  ( +255)</option><option value="TH">Thailand  ( +66)</option><option value="TL">Timor-Leste  ( +670)</option><option value="TG">Togo  ( +228)</option><option value="TK">Tokelau  ( +690)</option><option value="TO">Tonga  ( +676)</option><option value="TT">Trinidad and Tobago  ( +1)</option><option value="TA">Tristan da Cunha  ( +290)</option><option value="TN">Tunisia  ( +216)</option><option value="TR">Turkey  ( +90)</option><option value="TM">Turkmenistan  ( +993)</option><option value="TC">Turks and Caicos Islands  ( +1)</option><option value="TV">Tuvalu  ( +688)</option><option value="UG">Uganda  ( +256)</option><option value="UA">Ukraine  ( +380)</option><option value="AE">United Arab Emirates  ( +971)</option><option value="UK">United Kingdom  ( +44)</option><option selected="" value="US">United States  ( +1)</option><option value="UM">United States Minor Outlying Islands  ( +1)</option><option value="UY">Uruguay  ( +598)</option><option value="UZ">Uzbekistan  ( +998)</option><option value="VU">Vanuatu  ( +678)</option><option value="VA">Vatican City  ( +379)</option><option value="VE">Venezuela  ( +58)</option><option value="VN">Vietnam  ( +84)</option><option value="VG">Virgin Islands, British  ( +1)</option><option value="VI">Virgin Islands, U.S.  ( +1)</option><option value="WF">Wallis and Futuna  ( +681)</option><option value="YE">Yemen  ( +967)</option><option value="ZM">Zambia  ( +260)</option><option value="ZW">Zimbabwe  ( +263)</option></select>

                            </div>
                        </div>


                        <div class="row">                        
                            <div class="form-group col-md-8 col-md-push-0">
                                <input required name="mobile" type="tel" value="<%="" + session.getAttribute("userMobile")%>" onkeypress="return backspaceAlpha(event)" placeholder="Your Mobile No." class="form-control" maxlength="10">
                            </div>
                        </div>                                   

                        <div class="row">
                            <div class="form-group col-md-8 col-md-push-1">
                                <button class="btn col-md-10  btn-lg btn-success" type="submit"><i class="glyphicon glyphicon-check"></i> &nbsp;&nbsp;&nbsp;Save Changes</button>
                        </div>  
                        </div>  

                    </form>
                        <div class="row">   
                            <div class="col-md-8 col-md-push-2">
                                <a href="#" data-toggle="modal" data-target="#DeleteModal"><button class="btn  btn-lg btn-warning"><i class="glyphicon glyphicon-remove"></i> &nbsp;&nbsp;&nbsp;Delete Profile</button></a> 
                                </div>
                        </div>  
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
        <div class="modal fade" id="DeleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></button>
                        <h4 class="modal-title" id="myModalLabel">Delete Your Profile !</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are You sure You want delete this Profile !!!</p>
                        <a href="deleteProfile.jsp"><button type="button" class="btn btn-warning btn-lg">OK</button></a>
                        <button type="button" class="btn btn-success btn-lg" data-dismiss="modal">Cancel</button>
                    </div>      
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