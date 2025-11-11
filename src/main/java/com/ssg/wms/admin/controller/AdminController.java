package com.ssg.wms.admin.controller;

import com.ssg.wms.admin.domain.Member;
import com.ssg.wms.admin.dto.MemberCriteria;
import com.ssg.wms.admin.dto.MemberPageDTO;
import com.ssg.wms.admin.dto.StaffDTO;
import com.ssg.wms.admin.service.AdminService;
import com.ssg.wms.common.AccountStatus;
import com.ssg.wms.common.Role;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Log4j2
public class AdminController {

    private final AdminService adminService;

    @GetMapping("")
    public String getAdminMain() {
        // 메인 화면
        return "admin/connect";
    }

    @GetMapping("/login")
    public String getAdminLogin() {
        // 로그인 화면
        return "admin/login";
    }

    @PostMapping("")
    public String postAdminLogin(@RequestParam("loginId") String id,
                                 HttpSession session,
                                 Model model) {
        // 세션에 저장
        session.setAttribute("loginId", id);
        session.setAttribute("role", Role.ADMIN);

        // 모델에 담아서 뷰로 전달
        model.addAttribute("loginId", id);

        return "admin/connect";
    }

    @Transactional
    @GetMapping("/mypage")
    public String getUserInfo(HttpSession session, Model model) {
        // 마이페이지 조회
        String id = (String) session.getAttribute("loginId");
        if (id == null) {
            return "redirect:/login"; // 세션 없으면 로그인 페이지로
        }

        // 로그인 ID -> 고유 ID 구하고 직원 정보 얻음
        long staffId = adminService.findStaffIdByStaffLoginId(id);
        StaffDTO staffDTO = adminService.getStaffDetails(staffId);

        model.addAttribute("staff", staffDTO);
        return "admin/mypage";
    }

    @GetMapping("/members")
    public String getMembers(@ModelAttribute MemberCriteria criteria,
                             Model model) {
        List<Member> members = adminService.getMembersByCriteria(criteria);
        int total = adminService.getMemberTotalCount(criteria);

        MemberPageDTO pageDTO = new MemberPageDTO(criteria.getPageNum(),
                criteria.getAmount(), total);

        model.addAttribute("members", members);
        model.addAttribute("pageDTO", pageDTO);
        model.addAttribute("totalCount", total);
        model.addAttribute("criteria", criteria);

        // 고객 목록 조회
        return "admin/members";
    }

    @GetMapping("/members/{memberId}")
    @ResponseBody
    public Member getMembersDetail(@PathVariable long memberId) {
        // 고객 상세 조회
        return adminService.getMemberDetails(memberId);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/login"; // 로그인 페이지로 리다이렉트
    }

    @PostMapping("/members/{memberId}/approve")
    @ResponseBody
    public void approveMember(@PathVariable long memberId){
        adminService.changeMemberStatus(memberId, AccountStatus.ACTIVE);
    }

    @PostMapping("/members/{memberId}/reject")
    @ResponseBody
    public void rejectMember(@PathVariable long memberId){
        adminService.changeMemberStatus(memberId, AccountStatus.REJECTED);
    }

}
