package gu.info.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.info.service.*;


@Controller 
public class InfoController {

    @Autowired
    InfoService infoService;	
    SqlSession sqlSession; //top 이미지 갱신
    
    /**
     * <ul>
     * <li>제  목 : 플랫폼 소개 개요페이지</li>
     * <li>설  명 : 개요페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/infoHome.do")
    public String infoHome(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "info/infoHome";
    
    }	

    /**
     * <ul>
     * <li>제  목 : 플랫폼 소개 목적페이지</li>
     * <li>설  명 : 목적페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/infoSub.do")
    public String infoSub(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "info/infoSub";
    
    }	    
    
}

