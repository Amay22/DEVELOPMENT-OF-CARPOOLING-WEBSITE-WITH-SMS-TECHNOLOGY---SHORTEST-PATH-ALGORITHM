<%
session.setAttribute("userID", null);
session.setAttribute("userEmail", null);
session.setAttribute("userpwd", null);
session.setAttribute("userName", null);
session.setAttribute("userHomeAddr", null);
session.setAttribute("userHomeLatLng", null);
session.setAttribute("userMobile", null);
session.setAttribute("userGender", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>