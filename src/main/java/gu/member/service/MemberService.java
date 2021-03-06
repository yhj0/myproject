package gu.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;


import gu.common.ImageVO;
import gu.member.vo.*;

@Service
public class MemberService {

	@Autowired
	private SqlSessionTemplate sqlSession; 
    @Autowired
    private DataSourceTransactionManager txManager;
	
    /*회원정보 조회*/    
    public MemberVO selectMemberOne(String param) {
    	
        return sqlSession.selectOne("selectMemberOne", param);
    }     
    
    /**
     * 회원가입
     */
    public boolean insertMember(MemberVO param, List<ImageVO> imagelist) throws Exception {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        boolean result = true;
        
        try {
            sqlSession.insert("insertMember", param); 
            
            //저장해놓은게 없으면 이미지저장
            for (ImageVO f : imagelist) {
            	//paretPK에 사용자 아이디를 넣는다.
                f.setParentPK(param.getId());
                sqlSession.insert("insertImage", f);
                
            }

            txManager.commit(status);
            
            
        } catch (Exception e) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + e.toString());
            throw e;
        }
		return result;            
    }	

    /**
     * 회원정보수정
     */
    public boolean updateMember(MemberVO param, List<ImageVO> imagelist) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        boolean result = true;
        
        try {
        	//회원정보수정
            sqlSession.update("updateMember", param); 
            
            //저장해놓은게 없으면 이미지저장
            for (ImageVO f : imagelist) {
            	//paretPK에 사용자 아이디를 넣는다.
                f.setParentPK(param.getId());
                sqlSession.update("updateImage", f);
                
            }
            
            txManager.commit(status);
            
            
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }
		return result;            
    }	      
    
    /**
     * ID중복조회
     *
     */
    public String checkSignup(String id) {

    		String count = sqlSession.selectOne("checkID", id); 
            return  count;    
    }	
    
    /*아이디 찾기*/    
    public MemberVO selectFindID(String param, String param2) {
    	
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("user_name", param);
    	map.put("email", param2);
    		
        return sqlSession.selectOne("selectFindID", map);
    }     
    
    /*비밀번호 찾기*/    
    public MemberVO selectFindPW(String param, String param2) {
    	
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("user_id", param);
    	map.put("email", param2);
    		
        return sqlSession.selectOne("selectFindPW", map);
    }  
    
    /**
     * 회원탈퇴
     */
    public boolean quitMember(MemberVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        boolean result = true;
        
        try {
        	//회원정보수정
            sqlSession.update("quitMember", param); 
            txManager.commit(status);
            
            
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }
		return result;            
    }	    
    
}
