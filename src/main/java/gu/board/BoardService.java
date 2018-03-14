package gu.board;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gu.common.FileVO;
import gu.common.SearchVO;

@Service
public class BoardService {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;
    
    /*공지사항 갯수*/
    public Integer selectNoticeCount(SearchVO param) {
        return sqlSession.selectOne("selectNoticeCount", param);
    }    
    
    /*소비자경험 갯수*/
    public Integer selectConsumerCount(SearchVO param) {
        return sqlSession.selectOne("selectConsumerCount", param);
    }
    
    /*최근 이슈 갯수*/
    public Integer selectIssueCount(SearchVO param) {
        return sqlSession.selectOne("selectIssueCount", param);
    }
    
    /*공지사항 홈리스트 조회*/
    public List<?> selectNoticeListMain(String param) {
        return sqlSession.selectList("selectNoticeListMain", param);
    }   
    
    /*소비자경험 홈리스트 조회*/
    public List<?> selectConsumerListMain(String param) {
        return sqlSession.selectList("selectConsumerListMain", param);
    }
    
    /*최근 이슈 홈리스트 조회*/
    public List<?> selectIssueListMain(String param) {
        return sqlSession.selectList("selectIssueListMain", param);
    }    
    
    /*공지사항 리스트 조회*/
    public List<?> selectNoticeList(SearchVO param) {
        return sqlSession.selectList("selectNoticeList", param);
    }  
    
    /*소비자경험 리스트 조회*/
    public List<?> selectConsumerList(SearchVO param) {
        return sqlSession.selectList("selectConsumerList", param);
    }
    
    /*이슈 리스트 조회*/
    public List<?> selectIssueList(SearchVO param) {
        return sqlSession.selectList("selectIssueList", param);
    }    
    
    
    /**
     * 글 저장.
     */
    /*공지사항 입력*/
    public void insertNotice(BoardVO param, List<FileVO> filelist, String[] fileno) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getBrdno() == null || "".equals(param.getBrdno())) {
                 sqlSession.insert("insertNotice", param);
            } else {
                sqlSession.update("updateNotice", param);
            }
            
            if (fileno != null) {
                HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                sqlSession.insert("insertBoardFile", f);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }            
    }   
    
    /*소비자경험 입력*/
    public void insertBoard(BoardVO param, List<FileVO> filelist, String[] fileno) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getBrdno() == null || "".equals(param.getBrdno())) {
                 sqlSession.insert("insertBoard", param);
            } else {
                sqlSession.update("updateBoard", param);
            }
            
            if (fileno != null) {
                HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                sqlSession.insert("insertBoardFile", f);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }            
    }
    
    /*최근 이슈 입력*/
    public void insertIssue(BoardVO param, List<FileVO> filelist, String[] fileno) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getBrdno() == null || "".equals(param.getBrdno())) {
                 sqlSession.insert("insertIssue", param);
            } else {
                sqlSession.update("updateIssue", param);
            }
            
            if (fileno != null) {
                HashMap<String, String[]> fparam = new HashMap<String, String[]>();
                fparam.put("fileno", fileno);
                sqlSession.insert("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                sqlSession.insert("insertBoardFile", f);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }            
    }
 
    /*공지사항 개별조회*/    
    public BoardVO selectNoticeOne(String param) {
        return sqlSession.selectOne("selectNoticeOne", param);
    }    
    
    /*소비자경험 개별조회*/
    public BoardVO selectBoardOne(String param) {
        return sqlSession.selectOne("selectBoardOne", param);
    }

    /*이슈 개별조회*/
    public BoardVO selectIssueOne(String param) {
        return sqlSession.selectOne("selectIssueOne", param);
    }    
    
    /*공지사항 수정*/ 
    public void updateNoticeRead(String param) {
        sqlSession.insert("updateNoticeRead", param);
    }    
    /*소비자경험 수정*/
    public void updateBoardRead(String param) {
        sqlSession.insert("updateBoardRead", param);
    }
    /*이슈 수정*/
    public void updateIssueRead(String param) {
        sqlSession.insert("updateIssueRead", param);
    }
    
    /*공지사항 삭제*/
    public void deleteNoticeOne(String param) {
        sqlSession.delete("deleteNoticeOne", param);
    }    
    /*소비자경험 삭제*/
    public void deleteBoardOne(String param) {
        sqlSession.delete("deleteBoardOne", param);
    }
    /*이슈 삭제*/
    public void deleteIssueOne(String param) {
        sqlSession.delete("deleteIssueOne", param);
    }
    
    /*소비자경험 첨부파일 조회*/
    public List<?> selectBoardFileList(String param) {
        return sqlSession.selectList("selectBoardFileList", param);
    }
    
    
    /**
     * 댓글. 
     */
    public List<?> selectBoardReplyList(String param) {
        return sqlSession.selectList("selectBoardReplyList", param);
    }
    
    public void insertBoardReply(BoardReplyVO param) {
        if (param.getReno()==null || "".equals(param.getReno())) {
            sqlSession.insert("insertBoardReply", param);
        } else {
            sqlSession.insert("updateBoardReply", param);
        }
    }   
    
    public void deleteBoardReply(String param) {
        sqlSession.delete("deleteBoardReply", param);
    }

    /**
     * 검색. 
     */
    /*검색된 갯수*/
    public int searchCount(SearchVO param) {
        return sqlSession.selectOne("searchCount", param);
    }    
    /*검색내용*/
    public List<?> selectSearch(SearchVO param) {
        return sqlSession.selectList("selectSearch", param);
    }    
}
