package gu.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import gu.login.LoginVO;
import gu.login.LoginService;

@Controller 
public class LoginController {
    // 로깅을 위한 변수
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
    
    @Autowired
    LoginService loginService;
    
    // 01. 로그인 화면 
    @RequestMapping(value ="/login.do")
    public String login(){
        return "login/login";    // views/member/login.jsp로 포워드
    }
    
    // 02. 로그인 처리
    @RequestMapping(value ="/loginCheck.do")
    public ModelAndView loginCheck(LoginVO vo, HttpSession session, HttpServletResponse reponse) throws IOException{
        boolean result = loginService.loginCheck(vo, session);
        ModelAndView mav = new ModelAndView();
        
        if (result == true) { // 로그인 성공
            // home.jsp로 이동
            mav.setViewName("redirect:/home.do");
            mav.addObject("msg", "success");
        } else {    // 로그인 실패
         
            mav.setViewName("redirect:/login.do");
            mav.addObject("msg", "failure");
            
            reponse.setContentType("text/html; charset=UTF-8"); 
            PrintWriter out =  reponse.getWriter();
            out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.go(-1);</script>"); 
            out.flush(); 
        }
        return mav;
    }
    
    // 03. 로그아웃 처리
    @RequestMapping(value ="/logout.do")
    public ModelAndView logout(HttpSession session, HttpServletResponse reponse) throws IOException{
    	loginService.logout(session);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/home.do");
        mav.addObject("msg", "logout");
        
        return mav;
    	}
}
