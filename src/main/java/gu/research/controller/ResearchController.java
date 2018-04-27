package gu.research.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.research.service.ResearchService;

@Controller 
public class ResearchController {

    @Autowired
    ResearchService researchService;	
    SqlSession sqlSession; //top 이미지 갱신
    
    /**
     * <ul>
     * <li>제  목 : 정형 데이터_사용자 행태 분석 </li>
     * <li>설  명 : 해당페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/formalData_User.do")
    public String formalData_User(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "research/formalData_User";
    
    }	

    /**
     * <ul>
     * <li>제  목 : 정형 데이터_이용패턴 별 사용자 분류 </li>
     * <li>설  명 : 해당페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/formalData_Pattern.do")
    public String formalData_Pattern(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "research/formalData_Pattern";
    
    }	    

    /**
     * <ul>
     * <li>제  목 : 정형 데이터_종별 제품별 사용 통계 </li>
     * <li>설  명 : 해당페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/formalData_Product.do")
    public String formalData_Product(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "research/formalData_Product";
    
    }	
    
    
    /**
     * <ul>
     * <li>제  목 : 비정형 데이터_이용 트렌드 분석</li>
     * <li>설  명 : 해당페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/informalData_User.do")
    public String informalData_User(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "research/informalData_User";
    
    }	    

    /**
     * <ul>
     * <li>제  목 : 비정형 데이터_리뷰 데이터 감성 분석</li>
     * <li>설  명 : 해당페이지를 보여준다</li>
     * <li>작성일 : 2018-04-25</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    @RequestMapping(value = "/informalData_Review.do")
    public String informalData_Review(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	return "research/informalData_Review";
    
    }	    
    
}

