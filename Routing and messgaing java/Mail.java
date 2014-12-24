package Route;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.sql.*;

public class Mail {
    
    public static void Mails(String email, String subject,String mailcontent)throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("Amay.Smit.Shail.Carpool@gmail.com", "carpooling");
                    }
                });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("Amay.Smit.Shail.Carpool@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(email));
            message.setSubject(subject);                        
            String bodyText = mailcontent;            
            MimeBodyPart mbp2 = new MimeBodyPart();            
            DataSource source = new FileDataSource("C:\\Documents and Settings\\sweet\\My Documents\\NetBeansProjects\\carpooling\\src\\java\\Route\\bg.jpg");
            mbp2.setDataHandler(new DataHandler(source));
            mbp2.setFileName("bg.jpg");
            mbp2.setHeader("Content-ID", "img1"); 
            MimeBodyPart mbp1 = new MimeBodyPart();
            mbp1.setContent(bodyText, "text/html");          
            Multipart mp = new MimeMultipart("related");
            mp.addBodyPart(mbp1);
            mp.addBodyPart(mbp2);            
            message.setContent(mp);
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    
    public static void QueryMail(String email, String username, String message)throws Exception{
        String subject="Contact US Quesry from user";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Contact from a Customer or a future customer<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Message  :"+message+"<BR><BR>"
                    + "Thank you for using our services "
                    +"</td></tr></table>"
                    + "</body></html>";
        Mails("Amay.Smit.Shail.Carpool@gmail.com" , subject , mailcontent);
    }
       
    public static void forgotPass(String email)throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from customer where email ='" + email + "' ;");
        String pass = "",username="",p="";
        if(rs.next()){pass = rs.getString("pwd");
        username = rs.getString("first") + rs.getString("last");
        p = rs.getString("mobile");
        }
        String subject="Forgot Password Mail For carpooling";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "These are your Login Details<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Password  :"+pass+"<BR><BR>"
                    + "Thank you for using our services "
                    +"</td></tr></table>"
                    + "</body></html>";        
        Mails(email , subject , mailcontent);
        Messaging.Message("Your Account details are Email :" + email + " Password :" + pass, p);                
    }
    
    public static void RegMail(String email, String username, String password, String address, String phone,String gender)throws Exception{        
        String subject="Registeration Mail For carpooling";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Thank You for Registering with our carpool services, Please Have a look at your credentials and verify them<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Password :"+password+"<BR><BR>"
                    + "Address  :"+address+"<BR><BR>"
                    + "phone    :"+phone+"<BR><BR><BR><BR>"
                    + "Thank you  "+(gender.equals("m")?"Sir":"Ma'am")+"</td></tr></table>"
                    + "</body></html>";
        Mails(email , subject , mailcontent);
        Messaging.Message("Hello " + username + " an  account has been registered for carpooling  Email :" + email + " Password :" + password, phone);                
    }
    
    public static void PostRideMail(String email, String username, String name, String stime,String etime)throws Exception {
        String subject="Posted a Ride for carpooling";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Thank You for Posting a New Carpool Ride and Group with our carpool services, Please Have a look at your details and verify them<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"
                    + "Start    :"+stime+"<BR><BR>"
                    + "End    :"+etime+"<BR><BR><BR><BR>"
                    + "Thank you, \n"+username +"</td></tr></table>"                   
                    + "</body></html>";
        Mails( email, subject , mailcontent);
    }
    public static void JoinRideMail(String email, String username, String name,String gid, String stime,String etime,String uphone) throws Exception{
        String subject="Joined a Ride for carpooling";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Thank You for Joining a New Carpool Ride and Group with our carpool services, Please Have a look at your details and verify them<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"
                    + "Start    :"+stime+"<BR><BR>" 
                    + "End    :"+etime+"<BR><BR><BR><BR>"                
                    + "Thank you, \n"+username+"</td></tr></table>"
                    + "</body></html>";
        Mails( email, subject , mailcontent);
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from groups where G_id =" + gid + " ;");
        String driver="",phone="";
        if(rs.next()){driver = rs.getString("C_id"); }
        rs = st.executeQuery("select * from customer where C_id =" + driver + " ;");
        if(rs.next()){driver = rs.getString("email");
        phone = rs.getString("mobile");
        }
        subject="Someone Joined a Ride in your carpool Group";
        mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Someone has joined your carpool Group with our carpool services, Please Have a look at their details <BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"
                    + "Phone    :"+uphone+"<BR><BR>"                             
                    + "Thank you,</td></tr></table>"
                    + "</body></html>";
        Mails( driver, subject , mailcontent);
        Messaging.Message(username + " Someone has just entered your ride email :" + email+", phone:"+uphone, phone);                
    }   
    public static void DeleteJoinRideMail(String email, String username, String name,String gid,String uphone)throws Exception{
        String subject="Deleted a Joined Ride for carpooling";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "You have just backed out of a joined carpool ride and group, Please Have a look at their details<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"
                    + "Thank you, \n"+username+"</td></tr></table>"
                    + "</body></html>";
        Mails( email, subject , mailcontent);
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from groups where G_id =" + gid + " ;");
        String driver="",phone="";
        if(rs.next()){driver = rs.getString("C_id"); }
        rs = st.executeQuery("select * from customer where C_id =" + driver + " ;");
        if(rs.next()){driver = rs.getString("email");
        phone = rs.getString("mobile");
        }
        subject="Someone has just gotten out of your carpool Group";
        mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Someone has backed out of your carpool Group with our carpool services, Please Have a look at their details <BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"
                    + "Phone    :"+uphone+"<BR><BR>"                             
                    + "Thank you,</td></tr></table>"
                    + "</body></html>";
        Mails( driver, subject , mailcontent); 
        Messaging.Message(username + " Someone has just left your ride email :" + email+", phone:"+uphone, phone);                
    }
    
    public static void DeletePostedRideMail(String email, String username,String name,String gid) throws Exception {
        String subject="Deleted a Posted Ride for carpooling";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "We are very sorry to hear that you have deleted this ride<BR>"
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"                    
                    + "Thank you, \n"+username+"</td></tr></table>"
                    + "</body></html>";
            Mails( email, subject , mailcontent);
            
            
            Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from cust_group where G_id =" + gid + " ;");
        String members[]=new String[9],m="",uphone="";int pos = 0;
        while(rs.next()){members[pos++] = rs.getString("C_id");}
        for(int i = 0 ; i < pos ; i++){
        rs = st.executeQuery("select * from customer where C_id =" + members[i] + " ;");
        if(rs.next()){
        uphone = rs.getString("mobile");
        m = rs.getString("email");
        }
        subject="Deletion of a carpool Group";
        mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "A carpool Group and ride has just been deleted , the details are as follows<BR>" 
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"
                    + "Ride     :"+name+"<BR><BR>"                                     
                    + "Thank you,</td></tr></table>"
                    + "</body></html>";
        Mails( m, subject , mailcontent);
        }                                    
    }    
    
    public static void AcccountDeletion(String email, String username) throws Exception {
        String subject="Deletion of Account at our Carpool Services Group";
        String mailcontent = "<html><body><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"20\" background=\"cid:img1\"><tr><td><h1>Hello "+username+" ,</h1><BR><BR>"
                    + "Your Account has just been deleted , the details are as follows<BR>" 
                    + "Name     :"+username+"<BR><BR>"
                    + "Email    :"+email+"<BR><BR>"                                                         
                    + "Thank you,</td></tr></table>"
                    + "</body></html>";
        Mails( email, subject , mailcontent);        
    }
}
