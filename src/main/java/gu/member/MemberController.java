package gu.member;

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


@Controller 
public class MemberController {

    @Autowired
    MemberService memberService;	
    SqlSession sqlSession; //top 이미지 갱신
    
    /**
     * 회원가입폼.
     */
    @RequestMapping(value = "/memberJoinForm.do")
    public String memberjoinForm(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "member/memberJoinForm";
    
    }	
	
    /** 
     * 회원정보 조회
     */
    @RequestMapping(value = "/memberMypage.do")
    public String memberMypage(HttpServletRequest request, ModelMap modelMap,LoginVO vo, HttpSession session) throws Exception{
    	
    	String id = request.getParameter("id");		
    	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+id);
    	
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
     public String memberJoin(HttpServletRequest request, MemberVO memberInfo, HttpSession session, ModelMap modelMap, HttpServletResponse response)  throws Exception{

    	String url =  "";

	    try {	
	   
	    	String id = request.getParameter("id");	
	    	
	        ImageUtil iu = new ImageUtil();
	        List<ImageVO> imagelist = iu.saveAllFiles(memberInfo.getUploadfile(), id, request);
	    	
	    	System.out.println("+++++++++++++++++++++++id 존재유무 : "+id);
	    	
	    	//아이디 존재 갯수파악
	    	int rowcount = Integer.parseInt(memberService.checkSignup(id));

	    	System.out.println("+++++++++++++++++++++++id 갯수파악 : "+rowcount);
	    	
	    	//회원가입일때
	    	if(rowcount == 0){
	    		System.out.println("+++++++++++++++++++++++회원가입 ");
	        	boolean result = memberService.insertMember(memberInfo, imagelist);

	        	if (result == true) { // 회원가입 성공
	        		url = "forward:/JoinResult.do";
	        	} else {    // 회원가입 실패
	        		url = "error.do";
	        	}
	    	}
	    	//회원수정일때
	    	else {
	    		System.out.println("+++++++++++++++++++++++회원수정 ");
	    		
	    		boolean result = memberService.updateMember(memberInfo, imagelist);

	        	if (result == true) { // 회원가입 성공
	        		url = "forward:home.do";
	        	} else {    // 회원가입 실패
	        		url = "error.do";
	        	}	    		
	    	}
	        
		} 
	    catch (Exception e) {}
	        
	    return url;
    }
    
	/**
	* ID중복확인
	*/   
    @ResponseBody
    @RequestMapping(value = "/checkID.do", method = RequestMethod.POST)
    public String checkSignup(HttpServletRequest request)throws Exception {
        String id = request.getParameter("id");
        String rowcount = memberService.checkSignup(id);
        return String.valueOf(rowcount);
    }

	/**
	* 회원가입 완료페이지
	*/   
    @RequestMapping(value = "/JoinResult.do")
    public String JoinResult(HttpServletRequest request, ModelMap modelMap)throws Exception {
    	String id = request.getParameter("id");
    	MemberVO memberInfo = memberService.selectMemberOne(id);
        
        modelMap.addAttribute("memberInfo", memberInfo);
    	
        return  "member/memberJoinResult";
    }      
    
    
	/**
	* 회원가입 후 자동로그인
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
	* 회원가입 에러페이지 
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

