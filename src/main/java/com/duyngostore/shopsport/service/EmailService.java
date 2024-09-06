package com.duyngostore.shopsport.service;

public interface EmailService {
    public void sendSimpleEmail();

    public void sendEmailSync(String to, String subject, String content, boolean isMultipart,
            boolean isHtml);

}
