package gu.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gu.member.MemberVO;

@Service
public class MemberService {

	@Autowired
	private SqlSessionTemplate sqlSession; 
    @Autowired
    private DataSourceTransactionManager txManager;
	
    
    /**
     * 회원가입 저장
     */
    public void insertMember(MemberVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            sqlSession.insert("insertMember", param);    
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }            
    }	

    /**
     * ID조회
     *
     */
    public String checkSignup(String id) {

    		String count = sqlSession.selectOne("checkID", id); 
            System.out.println("+++++++++++++++++++++++++++서비스   "+count);
            return  count;    
    }	
    
}
