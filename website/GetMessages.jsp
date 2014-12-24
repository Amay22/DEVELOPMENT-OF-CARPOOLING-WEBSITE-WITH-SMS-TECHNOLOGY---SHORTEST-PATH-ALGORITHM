<%@ page import ="java.sql.*" %>
<%@ page import ="Route.*" %>
<%
    String id = "" + session.getAttribute("userID");                
    session.setAttribute("NumMessages", MessageParser.unread(Integer.parseInt(id)));
    MessageParser.fetchMessages(Integer.parseInt(id));
    String messages = MessageParser.messages;
    int i = 0 ;String t[] =new String[100];String make="";String m[]=new String[100];String fr[] = new String[100];
    boolean ur [] = new boolean[100];
    while(messages.indexOf("yuoiea")>0){
        fr[i] = messages.substring(0,messages.indexOf("aeiouy"));
        messages = messages.substring(messages.indexOf("aeiouy")+6);
        t[i] = messages.substring(0,messages.indexOf("aeiouy"));
        messages = messages.substring(messages.indexOf("aeiouy")+6);
        m[i]=messages.substring(0,messages.indexOf("aeiouy"));
        messages = messages.substring(messages.indexOf("aeiouy")+5);
        String tmp=messages.substring(0,messages.indexOf("yuoiea")+1);
        if(tmp.contains(","+id+",") || tmp.contains("y"+id+",") || tmp.contains(","+id+"y") || tmp.contains("y"+id+"y")){
            ur[i] = true;
        }
        messages = messages.substring(messages.indexOf("yuoiea")+6); 
        i++;
    }
    i--;
    for(int j = i ; j >=0 ; j--){        
        if(!ur[j]){
            make += "<div class=\"row-fluid summary\"> <div class=\"span"+j
                +"\"><table> <tr> <td><button type=\"button\" id=\"collapsible"+j
                +"\" class=\"btn btn-success\" data-toggle=\"collapse\" data-target=\"#intro"+j
                +"\" value=\""+fr[j]+"aeiouy"+t[j]+"\">+</button>";
        }        
        else{
            make += "<h3><div class=\"row-fluid summary\"> <div class=\"span"+j
                +"\"><table> <tr> <td><button type=\"button\" id=\"collapsible"+j
                +"\" class=\"btn btn-info\" data-toggle=\"collapse\" data-target=\"#intro"+j
                +"\" value=\""+fr[j]+"aeiouy"+t[j]+"\">+</button><span class=\"badge\">Unread</span>";
        }
        make+= "</td><td><h4>&nbsp;&nbsp;&nbsp;&nbsp;"+fr[j]+"&nbsp;&nbsp;&nbsp;&nbsp;</h4></td>";                                
        if(m[j].length()>10){
            make+= "<td><h4>&nbsp;&nbsp;&nbsp;&nbsp;"+m[j].substring(0,10)+"....&nbsp;&nbsp;&nbsp;&nbsp;</h4></td>";
        }else{
            make+= "<td><h4>&nbsp;&nbsp;&nbsp;&nbsp;"+m[j]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4></td>";
        }        
        make+= "<td><h4>"+t[j].substring(0,16)+"&nbsp;&nbsp;&nbsp;&nbsp;</h4></td>";                       
        make +=" </tr> </table> </div> </div> <div class=\"row-fluid summary\"> <div id=\"intro"+j+"\" class=\"collapse\">";
        make +="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+m[j];        
        make+= "</div></div><br>";  
        if(ur[j]){ make+= "</h3>"; }
    }
%>
<br><br>
<%=make%>
<input type="hidden" id="colla" name="colla" value ="<%=i%>" />