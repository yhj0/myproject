package gu.login;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gu.login.LoginDAO;
import gu.login.LoginVO;


@Service // 현재 클래스를 스프링에서 관리하는 service bean으로 등록
public class LoginServiceImpl implements LoginService {
    
    @Autowired
    LoginDAO loginDao;
    
    // 01_01. 회원 로그인체크
    @Override
    public boolean loginCheck(LoginVO vo, HttpSession session) {
        boolean result = loginDao.loginCheck(vo);
        if (result) { // true일 경우 세션에 등록
        	LoginVO vo2 = viewLogin(vo);
            // 세션 변수 등록
            session.setAttribute("id", vo2.getId());
            session.setAttribute("name", vo2.getName());
        } 
        return result;
    }
    // 01_02. 회원 로그인 정보
    @Override
    public LoginVO viewLogin(LoginVO vo) {
        return loginDao.viewLogin(vo);
   }
    // 02. 회원 로그아웃
    @Override
    public void logout(HttpSession session) {
        // 세션 변수 개별 삭제
        // session.removeAttribute("userId");
        // 세션 정보를 초기화 시킴
        session.invalidate();
    }
}