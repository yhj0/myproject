package gu.member;

import java.awt.List;

import javax.ejb.DuplicateKeyException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import gu.member.MemberVO;

@Controller 
public class MemberController {

    @Autowired
    private MemberService memberService;	
	
    /**
     * 회원가입폼.
     */
    @RequestMapping(value = "/memberJoinForm.do")
    public String memberjoinForm(HttpServletRequest request, ModelMap modelMap) {
    	return "member/memberJoinForm";
    
    }	
	
	
	/**
	* 회원 저장
	*/
    @RequestMapping(value = "/memberSave.do")
    public String memberJoin(HttpServletRequest request, MemberVO memberInfo)  {
	
    try {	
    	memberService.insertMember(memberInfo);
	} catch (Exception e) {
		if(e instanceof DuplicateKeyException){
			String msg = "fail";
			return msg;
		}
	}
        return "board/home";
    }
    
	/**
	* ID중복확인
	*/   
    @ResponseBody
    @RequestMapping(value = "/checkID.do", method = RequestMethod.POST)
    public String checkSignup(HttpServletRequest request) {
        String id = request.getParameter("id");
        String rowcount = memberService.checkSignup(id);
        return String.valueOf(rowcount);
    }

	
}
