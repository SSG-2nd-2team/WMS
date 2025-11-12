package com.ssg.wms.member.controller;

import com.ssg.wms.common.Role;
import com.ssg.wms.member.domain.Member;
import com.ssg.wms.member.dto.MemberDTO;
import com.ssg.wms.member.dto.MemberUpdateDTO;
import com.ssg.wms.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Map;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@Log4j2
public class MemberController {

    private final MemberService memberService;

    @GetMapping("")
    public String getMemberMain() {
        // 메인 화면
        return "member/connect";
    }

    @GetMapping("/login")
    public String getMemberLogin() {
        // 로그인 화면
        return "member/login";
    }

    @PostMapping("")
    public String postMemberLogin(@RequestParam("loginId") String id,
                                  HttpSession session,
                                  Model model) {
        // 세션에 저장
        session.setAttribute("loginId", id);
        session.setAttribute("role", Role.MEMBER);

        // 모델에 담아서 뷰로 전달
        model.addAttribute("loginId", id);

        return "member/connect";
    }

    @GetMapping("/register")
    public String getMemberRegister() {
        // 로그인 화면
        return "member/register";
    }

    @PostMapping("/register")
    public String registerMember(@Valid @ModelAttribute MemberDTO memberDTO,
                                 BindingResult bindingResult
                                 ) {
        log.info("memberDTO: " + memberDTO);

        if (bindingResult.hasErrors()) {
            log.info("Member Registration Error");
            return "member/register";
        }

        memberService.insertMember(memberDTO);
        log.info("Member Registration Success");

        return "member/success";
    }

    @Transactional
    @GetMapping("/mypage")
    public String getUserInfo(HttpSession session, Model model) {
        // 마이페이지 조회
        String id = (String) session.getAttribute("loginId");
        if (id == null) {
            return "redirect:/login"; // 세션 없으면 로그인 페이지로
        }

        // 로그인 ID -> 고유 ID 구하고 고객 정보 얻음
        long memberId = memberService.findMemberIdByMemberLoginId(id);
        MemberDTO memberDTO = memberService.getMemberDetails(memberId);
        log.info("memberDTO: " + memberDTO);

        // 세션에 저장하고 모델로 넘김
        session.setAttribute("loginMember", memberDTO);
        model.addAttribute("loginMember", memberDTO);
        return "member/mypage";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/login"; // 로그인 페이지로 리다이렉트
    }

    @PostMapping("/update")
    @ResponseBody  // JSON 응답을 위해 추가
    public ResponseEntity<?> updateMember(@RequestBody MemberUpdateDTO memberUpdateDTO,
                                          HttpSession session) {
        try {
            // 세션에서 현재 로그인한 회원 정보 가져오기
            MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

            if (loginMember == null) {
                log.info("Member Login Error: UNAUTHORIZED");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("message", "로그인이 필요합니다."));
            }
            log.info("Member Login: " + loginMember);
            // 회원 정보 업데이트
            memberService.updateMember(loginMember.getMemberId(), memberUpdateDTO);

            // 세션 정보도 업데이트
            MemberDTO updatedMember = memberService.getMemberDetails(loginMember.getMemberId());
            session.setAttribute("loginMember", updatedMember);

            return ResponseEntity.ok()
                    .body(Map.of("message", "회원 정보가 수정되었습니다."));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "정보 수정 중 오류가 발생했습니다."));
        }
    }

}
