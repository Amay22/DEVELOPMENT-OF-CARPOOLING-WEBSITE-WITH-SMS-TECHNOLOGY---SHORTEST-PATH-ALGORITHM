<!DOCTYPE html>
<html>
    <head>

        <title>Thank You | CarPool</title>
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootswatch/3.0.0/flatly/bootstrap.min.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <style type="text/css">
            html{
                min-height:100%;
            }
            body {
                background-image:-o-linear-gradient(top, #fff, #dcdcdc);
                background-image:-moz-linear-gradient(top, #fff, #dcdcdc);
                background-image:-webkit-linear-gradient(top, #fff, #dcdcdc);
                background-image:linear-gradient(top, #fff, #dcdcdc);
                padding-top: 50px;
                padding-bottom: 20px;
            }
        </style>

        <style> 
            div
            {
                margin-top: 3%;
                margin-left: 23%;
                border:2px solid #20B2AA;
                padding:10px 10px; 
                background:#F0FFFF;
                width:700px;
                height:500px;
                border-radius:20px;
            }
        </style>
    </head>
    <body>

        <div class="modal-body" >
            <center><b><font size="15">Thank You fro Registering with our Car Pool service an Email has been sent to you at:</font></b></center>
            <br>
            <center><font size="25" color="green" ><strong><%="" + request.getParameter("e")%></strong></font><BR></center>
            <br><br>
            <center>
                    <a href="homepage.jsp"><button class="btn btn-primary btn-lg btn-success">CLICK &nbsp; &nbsp; TO &nbsp; &nbsp;CONTINUE</button></a>
            </center>
        </div>

    </body>
</html>