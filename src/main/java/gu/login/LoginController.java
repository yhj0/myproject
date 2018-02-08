package gu.login;

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
    public ModelAndView loginCheck(LoginVO vo, HttpSession session){
        boolean result = loginService.loginCheck(vo, session);
        ModelAndView mav = new ModelAndView();
        if (result == true) { // 로그인 성공
            // main.jsp로 이동
            mav.setViewName("board/home");
            mav.addObject("msg", "success");
        } else {    // 로그인 실패
            // home.jsp로 이동
            mav.setViewName("login/login");
            mav.addObject("msg", "failure");
        }
        return mav;
    }
    
    // 03. 로그아웃 처리
    @RequestMapping(value ="/logout.do")
    public ModelAndView logout(HttpSession session){
    	loginService.logout(session);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("board/home");
        mav.addObject("msg", "logout");
        return mav;
    }
}
