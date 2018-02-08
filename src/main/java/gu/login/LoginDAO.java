package gu.login;

import javax.servlet.http.HttpSession;

import gu.login.LoginVO;

public interface LoginDAO {
    // 01_01. 회원 로그인 체크
    public boolean loginCheck(LoginVO vo);
    // 01_02. 회원 로그인 정보
    public LoginVO viewLogin(LoginVO vo);
    // 02. 회원 로그아웃
    public void logout(HttpSession session);
}
