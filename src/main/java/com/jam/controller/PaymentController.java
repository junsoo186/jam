package com.jam.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jam.dto.TossPaymentResponseDTO;
import com.jam.repository.model.AccountHistoryDTO;
import com.jam.repository.model.Payment;
import com.jam.repository.model.User;
import com.jam.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/pay")
@RequiredArgsConstructor
public class PaymentController {
	
	private final HttpSession session;
	private final UserService userService;

    private final String SECRET_KEY = "test_sk_DLJOpm5Qrl6KR7dZbeX03PNdxbWn"; // 테스트 시크릿 키
    
    /**
     * 결제창으로 이동
     * @return
     */
    @GetMapping("/toss")
    public String tosspay() {
    	User principal = (User) session.getAttribute("principal"); // 유저 세션 가져옴
    	System.out.println("payController /toss : "  +principal);
        return "/payment/tossTest";
    }

    /**
     * 결제창에서 포인트 구매
     * 
     * @param model
     * @param orderId
     * @param amount
     * @param paymentKey
     * @return
     */
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
            		.orderId(dto.getOrderId()) // 주문번호
            		.orderName(dto.getOrderName()) // 주문 이름
            		.totalAmount(dto.getTotalAmount()) // 결제 금액
            		.paymentKey(dto.getPaymentKey()) // 토스 고유번호 주문
            		.build();
                 
            model.addAttribute("payment", payment);
          //  session.setAttribute("payment", payment);
            System.out.println("#@#@#@# : " + payment.toString());
            
            // 여기서 유저 서비스를 이용해서 결제 쿼리가 작동하도록 설정해야 한다.
            
            // 1. 유저 
            User principal = (User) session.getAttribute("principal"); // 유저 세션 가져옴
        	System.out.println("payController /success : " +principal);
        	
        	int userId = principal.getUserId();
        	
        	String payKey = paymentKey; // 페이먼트 키 확인
        	System.out.println("페이먼트 키 : " + payKey);
      
        	System.out.println(userId);
        	
        	long balance  = userService.searchPoint(userId); // 유저가 가지고 있는 포인트 잔액 조회
        	
        	long deposit = amount; // 입금 금액
        	long point  = amount; // 충전할 포인트
        	long afterBalance = balance  + amount; // 소지하고 있는 포인트 + 충전할 포인트 = afterBalance
        	
        	userService.insertPoint(userId, deposit, point, afterBalance, paymentKey); // 포인트 충전
        	
        	// 유저 상세 정보에 기존에 포인트에 충전한 포인트 입력
        	userService.insert (amount, balance , userId);
        //	session.setAttribute("TossPaymentResponseDTO", payment);
        	
        	// 유저의 업데이트된 정보를 가져온다.
            User updatedUser = userService.InformationUpdate(principal.getEmail()); // DB에서 갱신된 유저 정보 가져오기
        	
        	session.setAttribute("principal", updatedUser);
            System.out.println("세션 유저 정보가 갱신되었습니다: " + updatedUser);
        	
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("PaymentController 에서 오류발생");
            return "redirect:/";
        }
     
        return "/payment/success";
    }
    
    @GetMapping("/fail")
    public String tossFail() {
    	System.out.println("결제 실패");
        return "/payment/fail";
    }
    
    /**
     * 안쓸수도 있음 테스트용
     * @return
     */
    @GetMapping("/refund")
    public String handletossrefund() {
    	System.out.println("결제 환불 창 이동");
        return "/payment/refund";
    }
    
   /**
    * 결제 내역 페이지로 이동 
    * @param model
    * @return
    */
    @GetMapping("/paylist")
    public String handlePayList(Model model) {
    	System.out.println("결제 목록 창으로 이동");
    	
    	// 유저 세션에서 유저 정보 가져오기
        User principal = (User) session.getAttribute("principal"); 
        int userId = principal.getUserId();
        
     // 유저의 결제 리스트 가져오기
     List<AccountHistoryDTO> payList = userService.findPayList(userId);
     System.out.println("결제 리스트 추가 : " + payList);
    	
     // 모델에 결제 리스트를 추가
     model.addAttribute("payList", payList);
    	
    	return "/payment/paylist";
    }
    
    /**
     * 환불 준비
     * @param paymentKey : 주문번호
     * @param refundAmount : 결제 가격
     * @param refundReason : 환불 이유 
     * @return
     */
    @PostMapping("/refunding")
    public String tossRefund( Model model,
    						 @RequestParam("paymentKey")String paymentKey,
    						 @RequestParam("refundAmount")long refundAmount,
    						 @RequestParam("refundReason") String refundReason) {
    	System.out.println("환불");
    	
    	System.out.println("paymentKey : " + paymentKey); // 환불 고유키
    	System.out.println("refundAmount : " + refundAmount); // 환불 가겨
    	System.out.println("refundReason : " + refundReason); // 환불 사유
    	
    	 RestTemplate restTemplate = new RestTemplate();

         // 헤더 구성
         HttpHeaders headers = new HttpHeaders();
         headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes()));
         headers.add("Content-type", "application/json");

         // 바디 구성 (환불 요청에 필요한 데이터)
         Map<String, Object> params = new HashMap<>();
         params.put("cancelReason", refundReason); // 환불 사유
         params.put("cancelAmount", refundAmount); // 환불할 금액

         try {
             // JSON 데이터를 String으로 변환
             ObjectMapper objectMapper = new ObjectMapper();
             String jsonBody = objectMapper.writeValueAsString(params);

             // 헤더 + 바디 결합
             HttpEntity<String> requestEntity = new HttpEntity<>(jsonBody, headers);

             // 환불 요청 API 호출
             String url = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";
             ResponseEntity<TossPaymentResponseDTO> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, TossPaymentResponseDTO.class);
             
             // 환불 응답 처리
             System.out.println("환불 응답: " + response.getBody());
             
             
             // 여기서 유저 서비스를 이용해서 결제 쿼리가 작동하도록 설정해야 한다.
             
             // 1. 유저 
             User principal = (User) session.getAttribute("principal"); // 유저 세션 가져옴
         	System.out.println("payController /success : " +principal);
         	
         	int userId = principal.getUserId();
         	
         	String payKey = paymentKey; // 페이먼트 키 확인
         	System.out.println("페이먼트 키 : " + payKey);
       
         	System.out.println(userId);
         	
         	long balance  = userService.searchPoint(userId); // 유저가 가지고 있는 포인트 잔액 조회
         	
         	long deposit = refundAmount; // 입금 금액
         	long point  = refundAmount; // 충전할 포인트
         	long afterBalance = balance  - refundAmount; // 소지하고 있는 포인트 - 충전할 포인트 = afterBalance
         	
         	userService.insertPoint(userId, deposit, point, afterBalance, paymentKey); // 포인트 충전내역 
         	
         	// 유저 상세 정보에 기존 포인트에  포인트 제거
         	userService.delete(refundAmount, balance, userId);
         	
         // 유저의 업데이트된 정보를 가져온다.
            User updatedUser = userService.InformationUpdate(principal.getEmail()); // DB에서 갱신된 유저 정보 가져오기
        	
        	session.setAttribute("principal", updatedUser);
            System.out.println("세션 유저 정보가 갱신되었습니다: " + updatedUser);
        
         } catch (Exception e) {
             e.printStackTrace();
           //  return "redirect:/refund/error";  // 에러 발생 시
             System.out.println("환불실패");
             return "redirect:/pay/fail"; // 환불 실패
         }
         
         System.out.println("환불성공");
         return "redirect:/"; // 환불 성공 시
     }
    
    /**
     * 환불 리스트 페이지에서 환불 누를 때 약관 확인해라는 창
     * @return
     */
    @GetMapping("/termsAndConditions")
    public String termsAndConditions() {
    	return "/payment/termsAndConditions";
    }
  
}
