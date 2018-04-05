package gu.member;

import java.util.List;

import javax.ejb.DuplicateKeyException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import gu.common.ImageUtil;
import gu.common.ImageVO;
import gu.login.LoginVO;
import gu.member.MemberVO;


@Controller 
public class MemberController {

    @Autowired
    MemberService memberService;	
    SqlSession sqlSession; //top 이미지 갱신
    
    /**
     * 회원가입폼.
     */
    @RequestMapping(value = "/memberJoinForm.do")
    public String memberjoinForm(HttpServletRequest request, ModelMap modelMap) {
    	return "member/memberJoinForm";
    
    }	
	
    /** 
     * 회원정보 조회
     */
    @RequestMapping(value = "/memberMypage.do")
    public String memberMypage(HttpServletRequest request, ModelMap modelMap) {

    	String id = request.getParameter("id");
    					
    	System.out.println("++++++++++++++++++++++++++++++++++회원아이디:"+id);
    	
        if (id != null) {
            MemberVO memberInfo = memberService.selectMemberOne(id);
        
            modelMap.addAttribute("memberInfo", memberInfo);
        }
        
        return "member/memberMypage";
    }  
    
	/**
	* 회원정보 저장 
	*/
    @RequestMapping(value = "/memberSave.do")
    public String memberJoin(HttpServletRequest request, MemberVO memberInfo, HttpSession session)  {
	
    try {	
    	
        String[] imgno = request.getParameterValues("imgno");

        System.out.println("+++++++++++++++++++++++++++++이미지 저장유무"+memberInfo.getFilename());
        
        ImageUtil iu = new ImageUtil();
        List<ImageVO> imagelist = iu.saveAllFiles(memberInfo.getUploadfile(), memberInfo.getId(), request);
        
    	String id = request.getParameter("id");
    	
    	//회원가입일때
    	if(id == null || id == ""){
        	memberService.insertMember(memberInfo, imagelist, imgno);
    	}
    	//회원수정일때
    	else {
    		memberService.updateMember(memberInfo, imagelist, imgno);
    	}
    	System.out.println("+++++++++++++++++++++++++++++이미지 갱신");
    	  
    	MemberVO memberInfo2 = memberService.selectMemberOne(id);

        session.setAttribute("id", memberInfo2.getId());
        session.setAttribute("name", memberInfo2.getName());
        session.setAttribute("filename", memberInfo2.getFilename());
    	
	} 
    catch (Exception e) {}
        
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

}
