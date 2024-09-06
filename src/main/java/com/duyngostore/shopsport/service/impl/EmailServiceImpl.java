package com.duyngostore.shopsport.service.impl;

import java.nio.charset.StandardCharsets;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.duyngostore.shopsport.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailServiceImpl implements EmailService {

    private final MailSender mailSender;
    private final JavaMailSender javaMailSender;

    public EmailServiceImpl(MailSender mailSender, JavaMailSender javaMailSender) {
        this.mailSender = mailSender;
        this.javaMailSender = javaMailSender;
    }

    @Override

    public void sendSimpleEmail() {
        SimpleMailMessage msg = new SimpleMailMessage();
        // mail nguoi nhan
        msg.setTo("ngoduy07142003@gmail.com");
        // noi dung tieu de
        msg.setSubject("Testing from Spring Boot");
        // noi dung
        msg.setText("Hello World from Spring Boot Email");

        this.mailSender.send(msg);
    }

    @Override
    @Async
    public void sendEmailSync(String to, String subject, String content, boolean isMultipart,
            boolean isHtml) {
        // Prepare message using a Spring helper
        // isMultipart : quy định có gửi kèm hình ảnh,file ko
        // isHtml : quy định đang gửi dạng text bình thường hay html+css
        MimeMessage mimeMessage = this.javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper message = new MimeMessageHelper(mimeMessage,
                    isMultipart, StandardCharsets.UTF_8.name());
            message.setTo(to);
            message.setSubject(subject);
            message.setText(content, isHtml);
            this.javaMailSender.send(mimeMessage);
        } catch (MailException | MessagingException e) {
            System.out.println("ERROR SEND EMAIL: " + e);
        }
    }

}
