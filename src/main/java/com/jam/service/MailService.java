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
		} catch (Exception e) {
			log.debug("MailService.sendEmail exception occur toEmail: {}, " +
                    "title: {}, text: {}", toEmail, title, text);
		}
	}

	public SimpleMailMessage createEmailForm(String toEmail, String title, String text) {
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(toEmail);
		message.setSubject(title);
		message.setText(text);
		
		return message;
	}
}
