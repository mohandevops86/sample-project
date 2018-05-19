package com.ssss.ttr.util;


import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class Email
{

	private static final Logger logger = LogManager
			.getLogger("com.ssss.ttr.util.Email");
   public static void send(String toAddress, String fromAddress, String subject, 
				   String smtpHost, String msgBody)
   {    
	   logger.info("Print Values passed toAddress"+toAddress+"fromAddress :"+fromAddress+"subject :"+subject+"smtpHost"+smtpHost+"msgBody :"+msgBody);
	   
      // Recipient's email ID needs to be mentioned.
      String to = toAddress;

      // Sender's email ID needs to be mentioned
      String from = fromAddress;

      // Assuming you are sending email from localhost
      String host = smtpHost;

      // Get system properties
      Properties properties = System.getProperties();

      // Setup mail server
      properties.setProperty("mail.smtp.host", host);

      // Get the default Session object.
      Session session = Session.getDefaultInstance(properties);

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));

         // Set To: header field of the header.
         //message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
         
         message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

         // Set Subject: header field
         message.setSubject(subject);

         // Create the message part
         BodyPart messageBodyPart = new MimeBodyPart();

         // Now set the actual message
         messageBodyPart.setText(msgBody);         
         
         // Create a multipar message
         Multipart multipart = new MimeMultipart();
         
         // Set text message part
         multipart.addBodyPart(messageBodyPart);
         message.setContent(multipart);
         // Part two is attachment
         /*if (outFileFullName.equals("SuccessMessage")){
        	 message.setContent(multipart);
         } else{
	         messageBodyPart = new MimeBodyPart();
	         String filename = outFileFullName;
	         DataSource source = new FileDataSource(filename);         
	         messageBodyPart.setDataHandler(new DataHandler(source));
	         messageBodyPart.setFileName(outFileNameWODir);         
	         multipart.addBodyPart(messageBodyPart);	         
	         // Send the complete message parts
	         message.setContent(multipart);
         }*/

         // Send message
         Transport.send(message);
         logger.info("Sent message successfully....");
      }catch (MessagingException mex) {
         mex.printStackTrace();
      }
   }
}