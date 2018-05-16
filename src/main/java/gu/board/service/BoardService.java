package gu.board.service;

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

import gu.board.vo.*;
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

    /*마이페이지-나의커뮤니티 갯수*/
    public Integer selectMyCount(SearchVO param) {
        return sqlSession.selectOne("selectMyCount", param);
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
    
    /*마이페이지-나의커뮤니티 조회*/
    public List<?> selectMyList(SearchVO param) {
        return sqlSession.selectList("selectMyList", param);
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
                sqlSession.delete("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                f.setBrdtype("N");
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
                sqlSession.delete("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                f.setBrdtype("C");          
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
                sqlSession.delete("deleteBoardFile", fparam);
            }
            
            for (FileVO f : filelist) {
                f.setParentPK(param.getBrdno());
                f.setBrdtype("I");             
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
    /*sql쿼리에서 가져할 변수가 2개(게시번호,아이디)여서 map을 사용하였음 */
    public BoardVO selectBoardOne(String param, String param2  ) {
    	
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("brdno", param);
    	map.put("user_id", param2);
    		
        return sqlSession.selectOne("selectBoardOne", map);
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
    
    
    /*공지사항 첨부파일 조회*/
    public List<?> selectNoticeFileList(String param) {
        return sqlSession.selectList("selectNoticeFileList", param);
    }
    
    /*소비자경험 첨부파일 조회*/
    public List<?> selectBoardFileList(String param) {
        return sqlSession.selectList("selectBoardFileList", param);
    }
    
    /*뉴스 첨부파일 조회*/
    public List<?> selectIssueFileList(String param) {
        return sqlSession.selectList("selectIssueFileList", param);
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
     * 답글. 
     */
    public List<?> selectBoardReplyCnt(String param) {
        return sqlSession.selectList("selectBoardReplyCnt", param);
    }   
    
    public List<?> selectBoardReplyDetailList(String param) {
        return sqlSession.selectList("selectBoardReplyDetailList", param);
    }
    
    public void insertBoardReplyDetail(BoardReplyDetailVO param) {
        if (param.getDeno()==null || "".equals(param.getDeno())) {
            sqlSession.insert("insertBoardReplyDetail", param);
        } else {
            sqlSession.insert("updateBoardReplyDetail", param);
        }
    }   
    
    public void deleteBoardReplyDetail(String param) {
        sqlSession.delete("deleteBoardReplyDetail", param);
    }    
    
    /**
     * 좋아요 추가
     */    
    public void insertLikes(BoardLikesVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            sqlSession.insert("insertLikes", param);

            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }            
    }    

    /**
     * 해당게시물에 좋아요 눌렀는지 여부판단
     * 
     */    
    public int selectYnLikes(BoardLikesVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        int rowcount =0;
        
        try {
        	rowcount = sqlSession.selectOne("selectYnLikes", param);

            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }
		return rowcount;            
    }        
    
    /**
     * 좋아요 조회(추가/삭제후 재카운트)
     * 
     */    
    public int selectLikes(String param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        int rowcount =0;
        
        try {
            
        	rowcount = sqlSession.selectOne("selectLikes", param);

            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }
		return rowcount;            
    }        
    
    /**
     * 좋아요 삭제
     */    
    public void deleteLikes(BoardLikesVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            sqlSession.delete("deleteLikes", param);

            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            System.out.println("데이터 저장 오류: " + ex.toString());
        }            
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
    
    /**
     * 무한스크롤 조회
     */
    
    public List<?> selectBoardOneNew(SearchVO param) {
        return sqlSession.selectList("test1", param);
    }    
    
    public List<BoardVO> selectBoardOneNew2(Integer param) {
        return sqlSession.selectList("test2", param);
    }
    
    /*제품검색 갯수*/
    public Integer selectProductCount(SearchVO param) {
    	int count = 0;
    	
    	count = sqlSession.selectOne("selectProductCount", param);
    	
        return count;
    }    
    
    /*제품검색 리스트 조회*/
    public List<?> selectProductList(SearchVO param) {
        return sqlSession.selectList("selectProductList", param);
    }
    
}
