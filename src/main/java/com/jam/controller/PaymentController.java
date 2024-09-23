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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jam.dto.TossPaymentResponseDTO;
import com.jam.repository.model.AccountHistoryDTO;
import com.jam.repository.model.Funding;
import com.jam.repository.model.Payment;
import com.jam.repository.model.RefundRequest;
import com.jam.repository.model.User;
import com.jam.service.FundingService;
import com.jam.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/pay")
@RequiredArgsConstructor
public class PaymentController {

    private final HttpSession session;
    private final UserService userService;
    private final FundingService fundingService;

    private final String SECRET_KEY = "test_sk_DLJOpm5Qrl6KR7dZbeX03PNdxbWn"; // 테스트 시크릿 키

    /**
     * 결제창으로 이동
     * 
     * @return
     */
    @GetMapping("/toss")
    public String tosspay() {
        User principal = (User) session.getAttribute("principal"); // 유저 세션 가져옴
        System.out.println("payController /toss : " + principal);
        return "/payment/tossTest";
    }

    /**
     * pay2 값을 세션에 저장하는 엔드포인트
     * 이유 : 토스에서 전달할 수 있는 값이 결제가격, 토스 고유키, 주문번호만 requestparam 으로 받을 수 있어서
     * 이유 : 포인트 값을 받을 수 없기에 session으로 pay2에 포인트 값을 넣어 @GetMapping("/success") 사용
     * 
     * @param request
     * @return
     */
    @PostMapping("/storePay2")
    @ResponseBody
    public ResponseEntity<?> storePay2(@RequestBody Map<String, Integer> request) {
        Integer pay2 = request.get("pay2");
        session.setAttribute("pay2", pay2); // 세션에 pay2 저장
        return ResponseEntity.ok().build();
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

        // 세션에서 pay2 값 가져오기
        Integer pay2 = (Integer) session.getAttribute("pay2"); // 포인트

        System.out.println("pay2 : " + pay2); // 포인트
        System.out.println("orderId : " + orderId); // 주문번호
        System.out.println("amount : " + amount); // 결제금액
        System.out.println("paymentKey : " + paymentKey); // 결제 고유키

        RestTemplate restTemplate = new RestTemplate();

        // 헤더 구성
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON); // JSON 형식으로 변경
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
                    "https://api.tosspayments.com/v1/payments/confirm", HttpMethod.POST, requestEntity,
                    TossPaymentResponseDTO.class);

            // 토스 페이먼트DTO
            TossPaymentResponseDTO dto = response.getBody(); // method : 결제방식

            System.out.println("@@@@@ : " + response.getBody().toString());

            // model 패키지 안에 있는 Payment 사용
            Payment payment = Payment.builder()
<<<<<<< HEAD
            		.orderId(dto.getOrderId()) // 주문번호
            		.orderName(dto.getOrderName()) // 주문 이름
            		.totalAmount(dto.getTotalAmount()) // 결제 금액
            		.method(dto.getMethod()) // 간편결제
            		.paymentKey(dto.getPaymentKey()) // 토스 고유번호 주문
            		.build();
            
=======
                    .orderId(dto.getOrderId()) // 주문번호
                    .orderName(dto.getOrderName()) // 주문 이름
                    .totalAmount(dto.getTotalAmount()) // 결제 금액
                    .method(dto.getMethod()) // 간편결제
                    .paymentKey(dto.getPaymentKey()) // 토스 고유번호 주문
                    .build();

>>>>>>> sub-dev
            model.addAttribute("payment", payment);
            // session.setAttribute("payment", payment);
            System.out.println("#@#@#@# : " + payment.toString());

            // 여기서 유저 서비스를 이용해서 결제 쿼리가 작동하도록 설정해야 한다.

            // 1. 유저
            User principal = (User) session.getAttribute("principal"); // 유저 세션 가져옴
            System.out.println("payController /success : " + principal);

            int userId = principal.getUserId(); // 세션에 있는 유저 아이디
            System.out.println(userId); // 세션에 있는 유저 아이디 확인

            String payKey = paymentKey; // 페이먼트 키 확인
            System.out.println("페이먼트 키 : " + payKey);

            long balance = userService.searchPoint(userId); // 유저가 가지고 있는 포인트 잔액 조회
            System.out.println("유저 기존 포인트 확인 : " + balance);

            long deposit = amount; // 입금 금액
            long point = pay2; // 충전할 포인트
            long afterBalance = balance + pay2; // 소지하고 있는 포인트 + 충전할 포인트 = afterBalance

            // 여기에 이벤트 여부를 넣어야 할거 같음 'Y', 'N'
            // isEventActive 가 true 이면 이벤트 발생, 아니라면 이벤트 없음
            if (isEventActive == true) {
                // 포인트 충전 INSERT INTO account_history_tb
                // 메서드 타입 만들어야 함 (결제 유형) 그리고 이벤트 여부 'y' 일때 환불 버튼 안없어짐 ;;
                userService.insertPoint(userId, deposit, point, afterBalance, paymentKey, 'Y', dto.getMethod());
            } else {
                userService.insertPoint(userId, deposit, point, afterBalance, paymentKey, 'N', dto.getMethod());
            }
            // 유저 상세 정보에 기존에 포인트에 충전한 포인트 입력
            userService.insert(pay2, balance, userId);
            // session.setAttribute("TossPaymentResponseDTO", payment);

            // payment_TB 테이블에도 기록을 남긴다. (이벤트 적용 여부 확인)
            // (세션 유저 아이디, 페이먼트키, 입금금액, 포인트, 'N' )

            // isEventActive 가 true 이면 이벤트 발생, 아니라면 이벤트 없음
            if (isEventActive == true) {
                userService.InsertPaymentTB(userId, paymentKey, deposit, point, 'Y');
            } else {
                userService.InsertPaymentTB(userId, paymentKey, deposit, point, 'N');
            }

            // 세션에서 pay2 값 삭제 (더 이상 필요 없으므로)
            session.removeAttribute("pay2");

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
     * 
     * @return
     */
    @GetMapping("/refund")
    public String handletossrefund() {
        System.out.println("결제 환불 창 이동");
        return "/payment/refund";
    }

    /**
     * 결제 내역 페이지로 이동
     * 
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
        List<Funding> fundingList = fundingService.findFundingByUserId(userId);

        System.out.println("/paylist : " + payList);
        System.out.println("/paylist : " + fundingList);

        // 모델에 결제 리스트를 추가
        model.addAttribute("payList", payList);
        model.addAttribute("fundingList", fundingList);

        return "/payment/paylist";
    }

    /**
     * 결제 내역 페이지에서
     * 사용자가 환불 버튼을 클릭한다.
     */
    @PostMapping("/manager")
    public String tossRefund12(Model model,
            @RequestParam("paymentKey") String paymentKey,
            @RequestParam("refundAmount") long refundAmount,
            @RequestParam("refundReason") String refundReason,
            @RequestParam("point") long point,
            @RequestParam("method") String method) {

        System.out.println("환불신청");

        System.out.println("point : " + point); // 포인트
        System.out.println("method : " + method); // 결제 방법
        System.out.println("paymentKey : " + paymentKey); // 환불 고유키
        System.out.println("refundAmount : " + refundAmount); // 환불 가겨
        System.out.println("refundReason : " + refundReason); // 환불 사유

        User user = (User) session.getAttribute("principal");

        RefundRequest refundRequest = RefundRequest.builder()
                .userId(user.getUserId())
                .paymentKey(paymentKey)
                .refundAmount(refundAmount)
                .refundReason(refundReason)
                .point(point)
                .method(method)
                .status("PENDING")
                .build();

        System.out.println("refundRequest : " + refundRequest.toString());

        int number = 0; // paymentKey 키로 account_history_tb 신청을 1번만 가능하도록 한다.
        number = userService.paymentCheck(paymentKey);

        if (number == 0) { // insert
            System.out.println("RefundRequest 확인 :" + refundRequest.toString());

            userService.saveRefundRequest(refundRequest); // 유저가 환불클릭하면 관리자가 요청?

            userService.pointAuditWait(paymentKey); // 심사중으로 변경

            return "redirect:/"; // 환불 성공 시 refund_request_tb 데이터

        } else {

            return "redirect:/";
        }
    }

    /**
     * 관리자가 환불버튼을 클릭하게 되면 환불을 할 수 있다.
     * 
     * @param paymentKey   : 주문번호
     * @param refundAmount : 결제 가격
     * @param refundReason : 환불 이유
     * @return
     */
    @PostMapping("/reques")
    public String tossRefund(Model model,
            @RequestParam("paymentKey") String paymentKey,
            @RequestParam("refundAmount") long refundAmount,
            @RequestParam("refundReason") String refundReason,
            @RequestParam("userId") int userId,
            @RequestParam("point") long point,
            @RequestParam("method") String method) {

        System.out.println("환불");

        System.out.println("point : " + point); // 환불 받을 포인트
        System.out.println("method : " + method); // 결제방식
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
            ResponseEntity<TossPaymentResponseDTO> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity,
                    TossPaymentResponseDTO.class);

            // 환불 응답 처리
            System.out.println("환불 응답: " + response.getBody());

            String payKey = paymentKey; // 페이먼트 키 확인
            System.out.println("페이먼트 키 : " + payKey);

            System.out.println(userId);

            long balance = userService.searchPoint(userId); // 유저가 가지고 있는 포인트 잔액 조회

            long deposit = refundAmount; // 입금 금액
            long point2 = refundAmount; // 충전할 포인트
            long afterBalance = balance - point; // 소지하고 있는 포인트 - 충전할 포인트 = point

            // 환불 승인 버튼을 눌렀지만 소지포인트 - 환불 포인트가 < 0 일 때 환불 거절로 변경된다.
            if (afterBalance >= 0) { // 포인트가 0 보다 크면 환불을 진행한다.

                userService.updatePoint(userId, deposit, point, afterBalance, refundReason, paymentKey); // 포인트 충전내역
                                                                                                         // 업데이트
                                                                                                         // @#!@#@!#@!#!@#
                // userService.insertPoint(userId, deposit, point, afterBalance, paymentKey); //
                // 포인트 충전내역

                // 유저 상세 정보에 기존 포인트에 포인트 제거
                userService.delete(point, balance, userId);

                // 유저의 업데이트된 정보를 가져온다.
                User updateUser = userService.InformationId(userId);

                System.out.println("유저정보 확인 : " + updateUser);

                User user = (User) session.getAttribute("principal");
                RefundRequest refundRequest = RefundRequest.builder()
                        .userId(user.getUserId())
                        .paymentKey(paymentKey)
                        .refundAmount(refundAmount)
                        .refundReason(refundReason)
                        // .status()
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
                        .refundReason("포인트 부족으로 환불 불가")
                        .build();

                userService.updateStatus2(paymentKey); // 거절로 변경
                userService.refundreject(refundRequest);
                System.out.println("환불 승인을 시도했으나 포인트 부족으로 환불 불가");
                return "redirect:/pay/payment-page";
            }

        } catch (Exception e) {
            e.printStackTrace();
            // return "redirect:/refund/error"; // 에러 발생 시
            // System.out.println("환불실패");
            // return "redirect:/pay/fail"; // 환불 실패
        }
        return "redirect:/pay/payment-page"; // 환불 성공 시
    }

    /**
     * 관리자가 거절 버튼을 클릭하게 되면 환불을 받을 수 없다.
     */
    @PostMapping("/requesrefusal")
    public String tossrefund2(Model model,
            @RequestParam("paymentKey") String paymentKey,
            @RequestParam("refundAmount") long refundAmount,
            @RequestParam("refundReason") String refundReason,
            @RequestParam("userId") int userId) {

        System.out.println("paymentKey @#!#@!#@!#@! : " + paymentKey);
        System.out.println("refundAmount @#!#@!#@!#@! : " + refundAmount);
        System.out.println("refundReason @#!#@!#@!#@! : " + refundReason);
        System.out.println("userId @#!#@!#@!#@! : " + userId);

        User user = (User) session.getAttribute("principal");
        RefundRequest refundRequest = RefundRequest.builder()
                .userId(userId) // 유저 아이디
                .staffId(user.getUserId()) // 관리자 아이디
                .paymentKey(paymentKey) // 결제 코드
                .refundAmount(refundAmount) // 결제 가격
                .refundReason(refundReason)
                // .status("거절")
                .build();

        userService.checkRequesrefusal(refundReason, paymentKey); // ddd

        AccountHistoryDTO dto = AccountHistoryDTO.builder()
                .status("거절")
                .build();
        System.out.println("@@#@ : " + dto.toString());

        System.out.println("@#@#@ : " + refundRequest.toString());
        userService.refundreject(refundRequest); // 거절로 업데이트

        userService.updateStatus2(paymentKey); // pedding --> 거절로 변경

        return "redirect:/pay/payment-page";
    }

    /**
     * 환불 리스트 페이지에서 환불 누를 때 약관 확인해라는 창
     * 
     * @return
     */
    @GetMapping("/termsAndConditions")
    public String termsAndConditions() {
        return "/payment/termsAndConditions";
    }

<<<<<<< HEAD
=======
    // /**
    // * 관리자 페이지 이동 (관리자)
    // *
    // * @return
    // */
    // @GetMapping("/managerTest")
    // public String managerTest(Model model) {
    // System.out.println("@@@@@@@@@@@@@@@@@@@@");
    // List<RefundRequest> payList = userService.selectRefundRequest(offset,
    // pageSize);
    // model.addAttribute("payList", payList);
    // System.out.println("관리자 페이지 이동 payList : "+payList.toString());
    // return "/payment/managerTest";
    // }

>>>>>>> sub-dev
    @GetMapping("/payment-management")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getPaymentManagement(
            @RequestParam(value = "page", defaultValue = "1") int page, // 기본값을 1로 설정
            @RequestParam(value = "pageSize", defaultValue = "5") int pageSize) {

        // 페이지 번호가 1 이상이어야 함
        if (page < 1) {
            page = 1;
        }

        // DB 조회 시 페이지는 0부터 시작하는 인덱스를 사용하므로 page - 1로 조정
        int offset = (page - 1) * pageSize;

        // 페이징 처리된 결제 정보와 기타 필요한 데이터 로직
        List<RefundRequest> payList = userService.selectRefundRequest(offset, pageSize);
        int totalPayCount = userService.getTotalRefundRequestCount();
        int totalPages = (int) Math.ceil((double) totalPayCount / pageSize);

        // 응답할 데이터를 Map 형태로 담음
        Map<String, Object> response = new HashMap<>();
        response.put("payList", payList);
        response.put("currentPage", page); // 클라이언트에게 표시할 현재 페이지
        response.put("totalPages", totalPages);

        // JSON으로 응답
        return ResponseEntity.ok(response);
    }

    @GetMapping("/payment-page")
    public String getPaymentPage() {
        return "staff/pay/payment-management";
    }

    @GetMapping("/payDetail")
<<<<<<< HEAD
    public String getMethodName(Model model, @RequestParam("refundId") Integer refundId) {
    /**
     * 관리자 페이지 이동 (관리자)
     * 
     * @return
     */
    @GetMapping("/managerTest")
    public String managerTest(Model model) {
        System.out.println("@@@@@@@@@@@@@@@@@@@@");
        List<RefundRequest> payList = userService.selectRefundRequest();
        model.addAttribute("payList", payList);
        System.out.println("관리자 페이지 이동 payList : "+payList.toString());
        return "/payment/managerTest";
    }

    /**
     * 관리자가 환불요청이 들어온것을확인할 수 있다.
     * @return
     */
    @PostMapping("/managerapprove")
    public String managerTest2(Model model) {
=======
	public String getMethodName(Model model, @RequestParam("refundId") Integer refundId) {

		RefundRequest refund = userService.findPayDetailByRefundId(refundId);
		model.addAttribute("refund", refund);
		return "staff/pay/payDetail";
	}
>>>>>>> sub-dev

    private boolean isEventActive = false; // 이벤트 상태를 저장하는 변수 (기본값은 비활성화)

    // 이벤트 상태를 토글하는 API (POST 요청)
    @PostMapping("/toggleEvent")
    @ResponseBody
    public String toggleEvent() {
        isEventActive = !isEventActive; // 현재 이벤트 상태를 반전 (true면 false로, false면 true로)
        System.out.println("이벤트 상태: " + (isEventActive ? "활성화" : "비활성화")); // 이벤트 상태를 콘솔에 출력
        return "이벤트 상태가 " + (isEventActive ? "활성화" : "비활성화") + "되었습니다."; // 상태 메시지를 반환
    }

    // 현재 이벤트 상태를 반환하는 API (GET 요청)
    @GetMapping("/eventStatus")
    @ResponseBody
    public boolean getEventStatus() {
        return isEventActive; // true 또는 false 반환 (JSON 형식)
    }

}