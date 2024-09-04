package com.jam.service;


import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class MailService {

    private final JavaMailSender eMailSender;

    public void sendEmail(String toEmail, String title, String text) {
        SimpleMailMessage emailForm = createEmailForm(toEmail, title, text);
        try {
            eMailSender.send(emailForm);
            log.info("이메일이 성공적으로 전송되었습니다. 대상: {}", toEmail);
        } catch (Exception e) {
            log.error("MailService.sendEmail exception occurred. toEmail: {}, title: {}, text: {}", toEmail, title, text, e);
            throw new RuntimeException("이메일 전송 중 오류가 발생했습니다.");
        }
    }

    private SimpleMailMessage createEmailForm(String toEmail, String title, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject(title);
        message.setText(text);
        return message;
    }
}
