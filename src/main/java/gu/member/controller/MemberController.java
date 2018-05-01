package gu.member.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import gu.member.service.*;
import gu.member.vo.MemberVO;


@Controller 
public class MemberController {

    @Autowired
    MemberService memberService;	
    SqlSession sqlSession; //top 이미지 갱신
    
    /**
     * <ul>
     * <li>제  목 : 회원가입 이용약관</li>
     * <li>설  명 : 회원가입 이용약관을 표시한다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberJoinAgree.do")
    public String memberJoinAgree(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "member/memberJoinAgree";
    
    }	 
    
    /**
     * <ul>
     * <li>제  목 : 회원가입 폼</li>
     * <li>설  명 : 회원가입을 위한 사용자정보를 입력받는다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberJoinForm.do")
    public String memberJoinForm(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "member/memberJoinForm";
    
    }	       

    /**
     * <ul>
     * <li>제  목 : 회원가입 성공 안내페이지</li>
     * <li>설  명 : 회원가입이 성공시에 안내하는 페이지를 나타낸다.</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */     
    @RequestMapping(value = "/memberJoinResult.do")
    public String memberJoinResult(HttpServletRequest request, ModelMap modelMap)throws Exception {
    	String id = request.getParameter("id");
    	MemberVO memberInfo = memberService.selectMemberOne(id);
        
        modelMap.addAttribute("memberInfo", memberInfo);
    	
        return  "member/memberJoinResult";
    }  
    
    /**
     * <ul>
     * <li>제  목 : 아이디패스워드 찾기</li>
     * <li>설  명 : 아이디패스워드 찾는다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberFindID.do")
    public String memberFindID(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "member/memberFindID";
    
    }	     
 
    /**
     * <ul>
     * <li>제  목 : 회원가입 이용약관</li>
     * <li>설  명 : 회원가입 이용약관을 표시한다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberAgreeInfo.do")
    public String memberAgreeInfo(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "member/memberAgreeInfo";
    
    }	
	
    /**
     * <ul>
     * <li>제  목 : 회원가입 개인정보처리방침</li>
     * <li>설  명 : 회원가입 개인정보처리방침을 표시한다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberPrivacyInfo.do")
    public String memberPrivacyInfo(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "member/memberPrivacyInfo";
    
    }	        
    
    /**
     * <ul>
     * <li>제  목 : 마이페이지 조회</li>
     * <li>설  명 : 회원정보를 조회한다(이메일값 분리)</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */   
    @RequestMapping(value = "/memberMypage.do")
    public String memberMypage(HttpServletRequest request, ModelMap modelMap,LoginVO vo, HttpSession session) throws Exception{
    	
    	String id = request.getParameter("id");		
    	
        if (id != null) {
            MemberVO memberInfo = memberService.selectMemberOne(id);
            
            //이메일 @를 구분하여 보이기
            String email= memberInfo.getEmail();
            int idx = email.indexOf("@");
            
            String email_1 = email.substring(0, idx);
            String email_2 = email.substring(idx+1);		
            
            modelMap.addAttribute("memberInfo", memberInfo);
            modelMap.put("email_1", email_1);
            modelMap.put("email_2", email_2);
        }
        
        return "member/memberMypage";
    }  

    /**
     * <ul>
     * <li>제  목 : 마이페이지 저장</li>
     * <li>설  명 : 회원정보를 저장한다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */   
    @RequestMapping(value = "/memberSave.do")
     public String memberSave(HttpServletRequest request, MemberVO memberInfo, HttpSession session, ModelMap modelMap, HttpServletResponse response)  throws Exception{
    	String url =  "";

	    try {	
	   
	    	String id = request.getParameter("id");	
	        ImageUtil iu = new ImageUtil();
	    	
	    	//아이디 존재 갯수파악
	    	int rowcount = Integer.parseInt(memberService.checkSignup(id));

	    	//회원가입일때
	    	if(rowcount == 0){
	        	
	    		List<ImageVO> imagelist = iu.saveAllFiles(memberInfo.getUploadfile(), id, request);
	    		
	    		boolean result = memberService.insertMember(memberInfo, imagelist);
	        		
	        	if (result == true) { // 회원가입 성공
	        		url = "forward:/memberJoinResult.do";
	        	} else {    // 회원가입 실패
	        		url = "error.do";
	        	}
	    	}
	    	//회원수정일때
	    	else {
	    		
	    		List<ImageVO> imagelist2 = iu.saveAllFiles2(memberInfo.getUploadfile(), id, request);
	    		
	    		boolean result = memberService.updateMember(memberInfo, imagelist2);
	    		
	        	if (result == true) { // 수정 성공
	        		url = "forward:home.do";
	        	} else {    // 수정 실패
	        		url = "error.do";
	        	}	    		
	    	}
	        
		} 
	    catch (Exception e) {}
	        
	    return url;
    }

    /**
     * <ul>
     * <li>제  목 : 마이페이지-나의커뮤니티 페이지 조회</li>
     * <li>설  명 : 나의커뮤니티 페이지를 조회한다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberMyList.do")
    public String memberMyList(HttpSession session, ModelMap modelMap) throws Exception{
    	
    	return "member/memberMyList";
    
    }	    
    
    /**
     * <ul>
     * <li>제  목 : 마이페이지-회원탈퇴 페이지 조회</li>
     * <li>설  명 : 회원탈퇴 페이지를 조회한다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberQuit.do")
    public String memberQuit(HttpSession session, ModelMap modelMap) throws Exception{
    	
    	return "member/memberQuit";
    
    }	    
 
    /**
     * <ul>
     * <li>제  목 : 마이페이지-회원탈퇴 처리</li>
     * <li>설  명 : 회원을 탈퇴시킨다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/memberQuitProc.do")
    public String memberQuitProc(HttpServletRequest request, MemberVO memberInfo, ModelMap modelMap,HttpSession session) throws Exception{
    	String url =  "";
    	String id = request.getParameter("id");
    	System.out.println(id);
    	
    	boolean result = memberService.quitMember(memberInfo);

    	if (result == true) { 
    		session.invalidate(); //로그아웃시킴
    		url = "forward:home.do";
    	} else {   
    		url = "error.do";
    	}    	
    	
    	return url; 
    
    }	
    
    /**
     * <ul>
     * <li>제  목 : 회원가입 아이디중복 조회</li>
     * <li>설  명 : 회원가입시 아이디 존재여부를 확인하여 ajax으로 나타낸다.</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @ResponseBody
    @RequestMapping(value = "/checkID.do", method = RequestMethod.POST)
    public String checkSignup(HttpServletRequest request)throws Exception {
        String id = request.getParameter("id");
        String rowcount = memberService.checkSignup(id);
        return String.valueOf(rowcount);
    }    
    
    
    /**
     * <ul>
     * <li>제  목 : 회원가입 후 자동로그인</li>
     * <li>설  명 : 자동로그인 버튼을 클릭시 세션값에 사용자정보를 저장시킨다.</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */     
    @RequestMapping(value = "/JoinLogin.do")
    public String JoinLogin(HttpServletRequest request, HttpSession session, ModelMap modelMap)throws Exception {
    	String id = request.getParameter("id");
    	//가입 후 자동로그인  
    	memberService.selectMemberOne(id);
    	
    	MemberVO memberInfo = memberService.selectMemberOne(id);
        
        modelMap.addAttribute("memberInfo", memberInfo);
    	
        session.setAttribute("id", memberInfo.getId());
        session.setAttribute("name", memberInfo.getName());
        session.setAttribute("filename", memberInfo.getFilename());    	
    	
        return  "forward:home.do";
    }    

    /**
     * <ul>
     * <li>제  목 : 회원가입 실패 페이지</li>
     * <li>설  명 : 회원가입 실패시 에러값을 화면에 리턴한다.</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */      
    @RequestMapping(value = "/error.do")
    public void error(HttpServletResponse response)throws Exception {
        
    	response.setCharacterEncoding("EUC-KR");
        PrintWriter writer=response.getWriter();
        writer.println("<script type='text/javascript'>alert('에러가 발생하였습니다. 관리자에게 문의하세요.');</script>");
        writer.flush();
        return ;
    } 
}

