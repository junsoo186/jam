package com.jam.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jam.dto.CardDTO;
import com.jam.dto.TossPaymentResponseDTO;
import com.jam.repository.model.Payment;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/pay")
@RequiredArgsConstructor
public class PaymentController {

    private final String SECRET_KEY = "test_sk_DLJOpm5Qrl6KR7dZbeX03PNdxbWn"; // 테스트 시크릿 키
    
    @GetMapping("/toss")
    public String tosspay(Model model) {
        return "/payment/tossTest";
    }

    @GetMapping("/success")
    public String tossSuccess(Model model,
    		@RequestParam(value = "orderId") String orderId,
    		@RequestParam(value = "amount") Integer amount,
    		@RequestParam(value = "paymentKey") String paymentKey) {
    	
    	
      System.out.println("orderId : " +  orderId);
      System.out.println("amount : " + amount);
      System.out.println("paymentKey : " + paymentKey);

        RestTemplate restTemplate = new RestTemplate();

        // 헤더 구성
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);  // JSON 형식으로 변경
        headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));

        // 바디 구성
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", orderId);
        params.put("amount", amount);
        params.put("paymentKey", paymentKey);

        try {
            // JSON 데이터를 String으로 변환
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonBody = objectMapper.writeValueAsString(params);
            
            // 헤더 + 바디 결합
            HttpEntity<String> requestEntity = new HttpEntity<>(jsonBody, headers);
            
            // API 호출
            ResponseEntity<TossPaymentResponseDTO> response = restTemplate.exchange(
                    "https://api.tosspayments.com/v1/payments/confirm", HttpMethod.POST, requestEntity, TossPaymentResponseDTO.class);
            
            // 토스 페이먼트DTO 
            TossPaymentResponseDTO dto = response.getBody();
            
            System.out.println("@@@@@ : "+response.getBody().toString());
            
            // model 패키지 안에 있는 Payment 사용
            Payment payment = Payment.builder()
            		.orderName(dto.getOrderName())
            		.totalAmount(dto.getTotalAmount())
            		.build();
            
            model.addAttribute("payment", payment);
            System.out.println("#@#@#@# : " + payment.toString());
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/";
        }
        
        
        return "/payment/success";
    }
    
    @GetMapping("/fail")
    public String tossFail() {
        return "/payment/fail";
    }
}
