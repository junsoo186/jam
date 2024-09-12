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
import com.jam.dto.RefundRequest;
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
          //  	session.setAttribute("payment", payment);
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
     * 결제 내역 페이지에서 
     * 사용자가 환불 버튼을 클릭한다.
     */
    @PostMapping("/manager")
    public String tossRefund12( Model model,
			 @RequestParam("paymentKey")String paymentKey,
			 @RequestParam("refundAmount")long refundAmount,
			 @RequestParam("refundReason") String refundReason) {
    	
    		System.out.println("환불신청");
    	
    	System.out.println("paymentKey : " + paymentKey); // 환불 고유키
    	System.out.println("refundAmount : " + refundAmount); // 환불 가겨
    	System.out.println("refundReason : " + refundReason); // 환불 사유
    	
    	  User user = (User) session.getAttribute("principal");
    	    RefundRequest refundRequest = RefundRequest.builder()
    	            .userId(user.getUserId())
    	            .paymentKey(paymentKey)
    	            .refundAmount(refundAmount)
    	            .refundReason(refundReason)
    	            .status("PENDING")
    	            .build();
    	    
    	    int number = 0; // paymentKey 키로 account_history_tb 신청을 1번만 가능하도록 한다.
    	    number = userService.paymentCheck(paymentKey);
    	    
    	    if(number == 0) { // insert
    	    	System.out.println("RefundRequest 확인 :" + refundRequest.toString());
    	    	
        	    userService.saveRefundRequest(refundRequest); // 유저가 환불클릭하면 관리자가 요청?
        	    
        	    userService.pointAuditWait(paymentKey); //

        	
        	    return "redirect:/"; // 환불 성공 시  refund_request_tb 데이터 
    	    	
    	    } else {
    	    	
    	    	return "redirect:/";
    	    }    
    }
    
    /**
     * 관리자가 환불버튼을 클릭하게 되면 환불을 할 수 있다.
     * @param paymentKey : 주문번호
     * @param refundAmount : 결제 가격
     * @param refundReason : 환불 이유 
     * @return
     */
    @PostMapping("/reques")
    public String tossRefund( Model model,
    						 @RequestParam("paymentKey")String paymentKey,
    						 @RequestParam("refundAmount")long refundAmount,
    						 @RequestParam("refundReason") String refundReason,
    						 @RequestParam("userId") int userId ) {
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
        	
        	String payKey = paymentKey; // 페이먼트 키 확인
        	System.out.println("페이먼트 키 : " + payKey);
      
        	System.out.println(userId);
        	
        	long balance  = userService.searchPoint(userId); // 유저가 가지고 있는 포인트 잔액 조회
        	
        	long deposit = refundAmount; // 입금 금액
        	long point  = refundAmount; // 충전할 포인트
        	long afterBalance = balance  - refundAmount; // 소지하고 있는 포인트 - 충전할 포인트 = afterBalance
        	
        	// 환불 승인 버튼을 눌렀지만 소지포인트 - 환불 포인트가 < 0 일 때 환불 거절로 변경된다. 
        	if(afterBalance >= 0) { // 포인트가 0 보다 크면 환불을 진행한다.
        		
        		userService.updatePoint(userId, deposit, point, afterBalance, paymentKey); // 포인트 충전내역 업데이트
            //	userService.insertPoint(userId, deposit, point, afterBalance, paymentKey); // 포인트 충전내역 
            	
            	// 유저 상세 정보에 기존 포인트에  포인트 제거
            	userService.delete(refundAmount, balance, userId);
            	
            	// 유저의 업데이트된 정보를 가져온다.
            	User updateUser = userService.InformationId(userId);
           	
               System.out.println("유저정보 확인 : " + updateUser);
               
               User user = (User) session.getAttribute("principal");
               RefundRequest refundRequest = RefundRequest.builder()
       	            .userId(user.getUserId())
       	            .paymentKey(paymentKey)
       	            .refundAmount(refundAmount)
       	         //   .refundReason("승인")
       	          //  .status()
       	            .build();
       	    
               userService.updateStatus1(paymentKey); // pedding --> 승인으로 변경 
       	    
       	    	System.out.println("리펀 dto 확인 :" + refundRequest.toString());
       	    
       	    	userService.refundRequest(refundRequest);
        	} else {
        		// 소지 포인트가 환불 포인트 보다 작을 때 (소지포인트 < 환불포인트)
        		 User user = (User) session.getAttribute("principal");
        		 RefundRequest refundRequest = RefundRequest.builder()
         	            .userId(userId) // 유저 아이디
         	            .staffId(user.getUserId()) // 관리자 아이디
         	            .paymentKey(paymentKey) // 결제 코드
         	            .refundAmount(refundAmount) // 결제 가격
         	            .refundReason("거절") 
         	            .build();
        		 
        		 userService.updateStatus2(paymentKey); // 거절로 변경
        		 userService.refundreject(refundRequest);
        		 System.out.println("환불 승인을 시도했으나 포인트 부족으로 환불 불가");
        		 return "redirect:/";
        	}
        
        } catch (Exception e) {
            e.printStackTrace();
          //  return "redirect:/refund/error";  // 에러 발생 시
           // System.out.println("환불실패");
            // return "redirect:/pay/fail"; // 환불 실패
        }
         return "redirect:/"; // 환불 성공 시
     }
    
    /**
     * 관리자가 거절 버튼을 클릭하게 되면 환불을 받을 수 없다.
     */
    @PostMapping("/requesrefusal")
    public String tossrefund2( Model model,
			 @RequestParam("paymentKey")String paymentKey,
			 @RequestParam("refundAmount")long refundAmount,
			 @RequestParam("refundReason") String refundReason,
			 @RequestParam("userId") int userId ) {
    	
    	System.out.println("userId @#!#@!#@!#@! : " +userId);
    	
    	 User user = (User) session.getAttribute("principal");
    	    RefundRequest refundRequest = RefundRequest.builder()
    	            .userId(userId) // 유저 아이디
    	            .staffId(user.getUserId()) // 관리자 아이디
    	            .paymentKey(paymentKey) // 결제 코드
    	            .refundAmount(refundAmount) // 결제 가격
    	            .refundReason("거절") 
    	    //        .status("거절")
    	            .build();
    	    
    	    AccountHistoryDTO dto = AccountHistoryDTO.builder()
    	    		.status("거절")
    	    		.build();
    	    System.out.println("@@#@ : " +dto.toString());
    	    
    	 System.out.println("@#@#@ : "+refundRequest.toString());
    	 userService.refundreject(refundRequest); // 거절로 업데이트
    	 
    	 userService.updateStatus2(paymentKey); // pedding --> 승인으로 변경 
    	
    	return "redirect:/";
    }
    
    /**
     * 환불 리스트 페이지에서 환불 누를 때 약관 확인해라는 창
     * @return
     */
    @GetMapping("/termsAndConditions")
    public String termsAndConditions() {
    	return "/payment/termsAndConditions";
    }
    
    /**
     * 관리자 페이지 이동 (관리자)
     * @return
     */
    @GetMapping("/managerTest")
    public String managerTest(Model model) {
    	System.out.println("@@@@@@@@@@@@@@@@@@@@");
    	List<RefundRequest> payList = userService.selectRefundRequest();
    	model.addAttribute("payList", payList);
    	return "/payment/managerTest";
    }
    
    /**
     * 관리자가 환불요청이 들어온것을확인할 수 있다.
     * @return
     */
    @PostMapping("/managerapprove")
    public String managerTest2(Model model) {
    	   
    	List<RefundRequest> payList = userService.selectRefundRequest();
    	
    
        System.out.println("관리자가 환불 요청 온거 확인? : " + payList);
       	
        // 모델에 결제 리스트를 추가
        model.addAttribute("payList", payList);
    	
    	return "redirect:/pay/managerTest";
    }
  
}
