package gu.member;

import java.util.List;

import javax.ejb.DuplicateKeyException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import gu.common.ImageUtil;
import gu.common.ImageVO;
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
    	
        String[] imgno = request.getParameterValues("imgno");
        System.out.println("+++++++++++++++++++++++++++++이미지 저장유무");
        
        ImageUtil iu = new ImageUtil();
        List<ImageVO> imagelist = iu.saveAllFiles(memberInfo.getUploadfile(), memberInfo.getId() );
    	System.out.println("+++++++++++++++++++++++++++++서버에 이미지저장완료");
        
    	memberService.insertMember(memberInfo, imagelist, imgno);
    	
	} catch (Exception e) {

		}
        return "redirect:/home.do";
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

    /**
     * 회원 마이페이지
     */
    @RequestMapping(value = "/memberMypage.do")
    public String memberMypage(HttpServletRequest request, ModelMap modelMap) {
    	
    	return "member/memberJoinForm";
    
    }	
}
