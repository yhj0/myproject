package gu.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import gu.board.vo.*;
import gu.board.service.*;
import gu.common.FileUtil;
import gu.common.FileUtil2;
import gu.common.FileVO;
import gu.common.SearchVO;

@Controller 
public class BoardController {

    @Autowired
    private BoardService boardservice;

    /**
     * <ul>
     * <li>제  목 : 메인페이지 조회</li>
     * <li>설  명 : 메인페이지 조회하며 게시물중 메인홈에 나타낼 값도 조회한다.</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */    
    
    @RequestMapping(value = "/home.do")
    public String home(HttpServletRequest request, ModelMap modelMap)  throws Exception{

    	//String boardtype =  StringUtils.defaultString((String)request.getParameter("boardtype"),"");
		String brdno = request.getParameter("brdno");

    	//소비자경험
	        List<?> consumerList  = boardservice.selectConsumerListMain(brdno);
	        modelMap.addAttribute("consumerList", consumerList);
	        
    	//이슈
	        List<?> issueList  = boardservice.selectIssueListMain(brdno);  

	        modelMap.addAttribute("issueList", issueList);
	        
	    //공지사항
	        List<?> noticeList  = boardservice.selectNoticeListMain(brdno);  
	        modelMap.addAttribute("noticeList", noticeList);
          	  		
      	return "board/home";  
    }	 
    
    /**
     * <ul>
     * <li>제  목 : 게시판 조회</li>
     * <li>설  명 : 게시판을 조회한다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */   
    
    /* 공지사항===================================================================== */
    @RequestMapping(value = "/noticeList.do")
    public String noticeList(SearchVO searchVO, ModelMap modelMap) throws Exception{

        searchVO.pageCalculate( boardservice.selectNoticeCount(searchVO) ); // startRow, endRow
        
        List<?> listview  = boardservice.selectNoticeList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/NoticeList";
    }    
    
    
    /* 소비자 경험===================================================================== */
    @RequestMapping(value = "/boardList.do")
    public String boardList(SearchVO searchVO, ModelMap modelMap) throws Exception{

        searchVO.pageCalculate( boardservice.selectConsumerCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectConsumerList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/BoardReadScroll";
    }  
    
    /* 최근이슈=================================================================== */
    @RequestMapping(value = "/issueList.do")
    public String issueList(SearchVO searchVO, ModelMap modelMap) throws Exception{
    	
        searchVO.pageCalculate( boardservice.selectIssueCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectIssueList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/IssueList";
    }        
    
    /* 마이페이지-나의커뮤니티==================================================== */
    @RequestMapping(value = "/myBoardList.do")
    public String myBoardList(SearchVO searchVO, ModelMap modelMap, HttpServletRequest request) throws Exception{
    	/***내 게시물만 보이기 ***/
    	//1.회원정보관리 -> 나의커뮤니티로 넘어올때 id값을 받아옴
    	String id = request.getParameter("id");	
    	
    	//2.검색 SearchVO에 받아온 id값을 셋팅
    	searchVO.setId(id);
    	
    	//3.게시물검색시 where 조건에 해당 id값을 넘겨줌
        searchVO.pageCalculate(boardservice.selectMyCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectMyList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/MyBoardList";
    }      
    
    /**
     * <ul>
     * <li>제  목 : 게시판 편집</li>
     * <li>설  명 : 게시판 편집 기능을 수행한다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    /* 공지사항===================================================================== */
    @RequestMapping(value = "/noticeForm.do")
    public String noticeForm(HttpServletRequest request, ModelMap modelMap) throws Exception{
        String brdno = request.getParameter("brdno");
        
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectNoticeOne(brdno);
            
            List<?> listview = boardservice.selectNoticeFileList(brdno);
        
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/NoticeForm";
    }    
    
    /* 마이페이지-나의커뮤니티======================================================= */
    @RequestMapping(value = "/myBoardForm.do")
    public String myBoardForm(HttpServletRequest request, ModelMap modelMap) throws Exception{
        String brdno = request.getParameter("brdno");
        String id = request.getParameter("id");	
        
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectBoardOne(brdno,id);
            
            List<?> listview = boardservice.selectBoardFileList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/MyBoardForm";
    }
    
    /* 최근이슈===================================================================== */
    @RequestMapping(value = "/issueForm.do")
    public String issueForm(HttpServletRequest request, ModelMap modelMap) throws Exception{
        String brdno = request.getParameter("brdno");
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectIssueOne(brdno);
            
            List<?> listview = boardservice.selectIssueFileList(brdno);
        
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/IssueForm";
    }    
    
    /* 소비자 경험===================================================================== */
    @RequestMapping(value = "/boardForm.do")
    public String boardForm(HttpServletRequest request, ModelMap modelMap) throws Exception{
        String brdno = request.getParameter("brdno");
        String id = request.getParameter("id");	
        
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectBoardOne(brdno,id);
            
            List<?> listview = boardservice.selectBoardFileList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/BoardForm";
    }    
    
    /* ===================================================================== */
    /**
     * <ul>
     * <li>제  목 : 게시판 저장</li>
     * <li>설  명 : 게시판을 저장한다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    /*공지사항*/
    @RequestMapping(value = "/noticeSave.do")
    public String noticeSave(HttpServletRequest request, BoardVO boardInfo) throws Exception{
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertNotice(boardInfo, filelist, fileno);

        return "redirect:/noticeList.do";
    }    
    
    /*소비자경험*/
    @RequestMapping(value = "/boardSave.do")
    public String boardSave(HttpServletRequest request, BoardVO boardInfo) throws Exception{
    	String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertBoard(boardInfo, filelist, fileno);

        return "redirect:/consumerList.do";
    }
    
    /*최근이슈*/
    @RequestMapping(value = "/issueSave.do")
    public String issueSave(HttpServletRequest request, BoardVO boardInfo) throws Exception{
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertIssue(boardInfo, filelist, fileno);

        return "redirect:/issueList.do";
    }    

    /*마이페이지-나의커뮤니티*/
    @RequestMapping(value = "/myBoardSave.do")
    public String myBoardSave(HttpServletRequest request, BoardVO boardInfo) throws Exception{
    	String id = request.getParameter("id");
    	String[] fileno = request.getParameterValues("fileno");
        String brdno = request.getParameter("brdno");
    	
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertBoard(boardInfo, filelist, fileno);

        return "redirect:/myBoardRead.do?brdno="+ brdno + "&id=" + id;
    }    

    /* ===================================================================== */
    /**
     * <ul>
     * <li>제  목 : 좋아요 저장</li>
     * <li>설  명 : 해당게시물에 좋아요 +1을 한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
     
    /*나의커뮤니티*/
    @ResponseBody
    @RequestMapping(value = "/myLikeUp.do")
    public String myLike(HttpServletRequest request, BoardLikesVO likesInfo ) throws Exception{
    	String brdno = request.getParameter("brdno");
    	int flag = 0;
    	int rowcount = 0;
    	//게시물 좋아요를 눌렀는지 여부
    	flag = boardservice.selectYnLikes(likesInfo);
    	
    	if(flag!=0)
    	{ 
    		//이미 좋아요를 눌러 rowcount값에 -1 값을 할당한다. view에서 리턴시킬것! 
    		rowcount = -1;	
    	}
    	else
    	{	
    		//좋아요 추가
            boardservice.insertLikes(likesInfo);
            //좋아요 재카운트
            rowcount = boardservice.selectLikes(brdno);	
    	}
  
        return String.valueOf(rowcount);
    }        

    /**
     * <ul>
     * <li>제  목 : 좋아요 삭제</li>
     * <li>설  명 : 해당게시물에 좋아요를 취소한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    /*나의커뮤니티*/
    @ResponseBody
    @RequestMapping(value = "/myLikeDown.do")
    public String myLikeDown(HttpServletRequest request, BoardLikesVO likesInfo) throws Exception{
    	String brdno = request.getParameter("brdno");
    	
    	//좋아요 삭제
        boardservice.deleteLikes(likesInfo);
        //좋아요 재카운트
        int rowcount = boardservice.selectLikes(brdno);
        
        return String.valueOf(rowcount);
    }          
    
    /**
     * <ul>
     * <li>제  목 : 메인홈에서 게시판 읽기</li>
     * <li>설  명 : 메인홈에서 게시된 게시판 조회한다. 처음 게시판분류값을 썼으나 현재사용하지않음</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/mainRead.do")
    public String mainRead(HttpServletRequest request, ModelMap modelMap) throws Exception{
    	
    	//리턴정의
    	String result = "";
    	
    	//게시판구분 
    	String brdtype = request.getParameter("brdtype");
        String brdno = request.getParameter("brdno");
        String id = request.getParameter("id");	
        
    	//구분에 따라 분기
    	if ("C".equals(brdtype))
    	{
            boardservice.updateBoardRead(brdno);
            BoardVO boardInfo = boardservice.selectBoardOne(brdno,id);
            List<?> listview = boardservice.selectBoardFileList(brdno);
            List<?> replylist = boardservice.selectBoardReplyList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
            modelMap.addAttribute("replylist", replylist);   
            
            result = "board/BoardRead";
    	}
    	else if("I".equals(brdtype))
    	{
            boardservice.updateIssueRead(brdno);
            BoardVO boardInfo = boardservice.selectIssueOne(brdno);
            List<?> listview = boardservice.selectIssueFileList(brdno);
            List<?> replylist = boardservice.selectBoardReplyList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
            modelMap.addAttribute("replylist", replylist);
            
            result = "board/IssueRead";
    	}
    	else
    	{
            boardservice.updateNoticeRead(brdno);
            BoardVO boardInfo = boardservice.selectNoticeOne(brdno);
            List<?> listview = boardservice.selectNoticeFileList(brdno);
            List<?> replylist = boardservice.selectBoardReplyList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
            modelMap.addAttribute("replylist", replylist);
        	
            result = "board/NoticeRead" ;    		
    		
    	}

        return result;
    }        
    
    /**
     * <ul>
     * <li>제  목 : 게시판 읽기</li>
     * <li>설  명 : 게시판 조회한다.</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */      
    
    /*공지사항*/
    @RequestMapping(value = "/noticeRead.do")
    public String noticeRead(HttpServletRequest request, ModelMap modelMap) throws Exception{
        
        String brdno = request.getParameter("brdno");
        
        boardservice.updateNoticeRead(brdno);
        BoardVO boardInfo = boardservice.selectNoticeOne(brdno);
        List<?> listview = boardservice.selectNoticeFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        
        return "board/NoticeRead";
    }    
    
    /*소비자경험*/    
    @RequestMapping(value = "/boardRead.do")
    public String boardRead(HttpServletRequest request, ModelMap modelMap) throws Exception{
        String id = request.getParameter("user_id");	
        String brdno = request.getParameter("brdno");
        
        boardservice.updateBoardRead(brdno);
        BoardVO boardInfo = boardservice.selectBoardOne(brdno,id);
        List<?> listview = boardservice.selectBoardFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        List<?> replydeatil = boardservice.selectBoardReplyDetailList(brdno);
        List<?> replycnt = boardservice.selectBoardReplyCnt(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        modelMap.addAttribute("replydeatil", replydeatil);
        modelMap.addAttribute("replycnt", replycnt);
        
        return "board/BoardRead";
    }
    
    /*최근이슈*/
    @RequestMapping(value = "/issueRead.do")
    public String issueRead(HttpServletRequest request, ModelMap modelMap) throws Exception{
        
        String brdno = request.getParameter("brdno");
        
        boardservice.updateIssueRead(brdno);
        BoardVO boardInfo = boardservice.selectIssueOne(brdno);
        List<?> listview = boardservice.selectIssueFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        
        return "board/IssueRead";
    }
 
    /*마이페이지-나의커뮤니티*/    
    @RequestMapping(value = "/myBoardRead.do")
    public String myBoardRead(HttpServletRequest request, ModelMap modelMap) throws Exception{
        
        String brdno = request.getParameter("brdno");
        String id = request.getParameter("id");	
        boardservice.updateBoardRead(brdno);
        
        BoardVO boardInfo = boardservice.selectBoardOne(brdno,id);
        List<?> listview = boardservice.selectBoardFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        List<?> replydeatil = boardservice.selectBoardReplyDetailList(brdno);
        List<?> replycnt = boardservice.selectBoardReplyCnt(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        modelMap.addAttribute("replydeatil", replydeatil);
        modelMap.addAttribute("replycnt", replycnt);
        
        return "board/MyBoardRead";
    }    
 
    /**
     * <ul>
     * <li>제  목 : 게시물 삭제</li>
     * <li>설  명 : 게시물을 삭제한다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    /*공지사항*/
    @RequestMapping(value = "/noticeDelete.do")
    public String noticeDelete(HttpServletRequest request) throws Exception{
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteNoticeOne(brdno);
        
        return "redirect:/noticeList.do";
    }    
    
    /*소비자경험*/
    @RequestMapping(value = "/boardDelete.do")
    public String boardDelete(HttpServletRequest request) throws Exception{
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteBoardOne(brdno);
        
        return "redirect:/consumerList.do";
    }
    
    /*최근이슈*/
    @RequestMapping(value = "/issueDelete.do")
    public String issueDelete(HttpServletRequest request) throws Exception{
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteIssueOne(brdno);
        
        return "redirect:/issueList.do";
    }

    /*마이페이지-나의커뮤니티*/
    @RequestMapping(value = "/myBoardDelete.do")
    public String myBoardDelete(HttpServletRequest request) throws Exception{
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteBoardOne(brdno);
        
        return "redirect:/myBoardList.do";
    }    
    
    /**
     * <ul>
     * <li>제  목 : 소비자게시판 댓글 저장</li>
     * <li>설  명 : 게시물 댓글 저장한다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    @RequestMapping(value = "/boardReplySave.do")
    public String boardReplySave(HttpServletRequest request, BoardReplyVO boardReplyInfo) throws Exception{
        String id = request.getParameter("reg_id");
    	boardservice.insertBoardReply(boardReplyInfo);

        return "redirect:/boardRead.do?brdno=" + boardReplyInfo.getBrdno() + "&id=" + id;
    }
    
    /**
     * <ul>
     * <li>제  목 : 소비자게시판 댓글 삭제</li>
     * <li>설  명 : 게시물 댓글 삭제한다. 단 댓글에 답글이 있는경우 댓글 내용만 삭제한다.</li>
     * <li>작성일 : 2018-05-21</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/boardReplyDelete.do")
    public String boardReplyDelete(HttpServletRequest request, BoardReplyVO boardReplyInfo) throws Exception{
    	String id = request.getParameter("reg_id");
    	
    	String reno = request.getParameter("reno"); //하위 답글이 달렸는지 조회용

    	// 하위 답글 조회
    	int cnt = boardservice.selectDelBoardReply(reno); 
    	
    	//답글이 1건 이상일때 
    	if(cnt > 0 )
    	{
    		//댓글을 삭제하지않음(내용만 초기화)
    		boardservice.deleteBoardReplyEx(boardReplyInfo);
    	}
    	else 
    	{
    		//댓글을 삭제
    		boardservice.deleteBoardReply(boardReplyInfo);
    	}

        return "redirect:/boardRead.do?brdno=" + boardReplyInfo.getBrdno() + "&id=" + id;
    }      

    /* ===================================================================== */     
    /**
     * <ul>
     * <li>제  목 : 소비자게시판 답글 저장</li>
     * <li>설  명 : 소비자게시판 답글 저장한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    @RequestMapping(value = "/replyDetailSave.do")
    public String replyDetailSave(HttpServletRequest request, BoardReplyDetailVO replyDetailInfo) throws Exception{
    	
        String brdno = request.getParameter("brdno"); //게시물번호
        String reno = request.getParameter("reno");	  //댓글번호
    	String id = request.getParameter("reg_id"); //사용자아이디

        boardservice.insertBoardReplyDetail(replyDetailInfo);

        return "redirect:/boardRead.do?brdno=" + brdno + "&id=" + id;
    }
    
    /**
     * <ul>
     * <li>제  목 : 소비자게시판 답글 삭제</li>
     * <li>설  명 : 소비자게시판 답글 삭제한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     * 
     * @author 유형준
     */  
    
    @RequestMapping(value = "/replyDetailDelete.do")
    public String replyDetailDelete(HttpServletRequest request, BoardReplyDetailVO replyDetailInfo) throws Exception{
    	
        String brdno = request.getParameter("brdno"); //게시물번호
    	String id = request.getParameter("reg_id"); //사용자아이디
    
    	boardservice.deleteBoardReplyDetail(replyDetailInfo);

        return "redirect:/boardRead.do?brdno=" + brdno + "&id=" + id;
    }          

    /**
     * <ul>
     * <li>제  목 : 나의커뮤니티 댓글 저장</li>
     * <li>설  명 : 나의커뮤니티 댓글 저장한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/myReplySave.do")
    public String myReplySave(HttpServletRequest request, BoardReplyVO boardReplyInfo) throws Exception{
        String id = request.getParameter("reg_id");
        boardservice.insertBoardReply(boardReplyInfo);

        return "redirect:/myBoardRead.do?brdno=" + boardReplyInfo.getBrdno() + "&id=" + id;
    }
    
    /**
     * <ul>
     * <li>제  목 : 나의커뮤니티 댓글 삭제</li>
     * <li>설  명 : 나의커뮤니티 댓글 삭제한다</li>
     * <li>작성일 : 2018-05-23</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/myReplyDelete.do")
    public String myReplyDelete(HttpServletRequest request, BoardReplyVO boardReplyInfo) throws Exception{
    	String id = request.getParameter("reg_id");
    	
    	String reno = request.getParameter("reno"); //하위 답글이 달렸는지 조회용
    	
    	// 하위 답글 조회
    	int cnt = boardservice.selectDelBoardReply(reno); 
    	
    	//답글이 1건 이상일때 
    	if(cnt > 0 )
    	{
    		//댓글을 삭제하지않음(내용만 초기화)
    		boardservice.deleteBoardReplyEx(boardReplyInfo);
    	}
    	else 
    	{
    		//댓글을 삭제
    		boardservice.deleteBoardReply(boardReplyInfo);
    	}

        return "redirect:/myBoardRead.do?brdno=" + boardReplyInfo.getBrdno() + "&id=" + id;
    }          

    /**
     * <ul>
     * <li>제  목 : 나의커뮤니티 답글 저장</li>
     * <li>설  명 : 나의커뮤니티 답글 저장한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/myReplyDetailSave.do")
    public String myReplyDetailSave(HttpServletRequest request, BoardReplyDetailVO replyDetailInfo) throws Exception{
    	
        String brdno = request.getParameter("brdno"); //게시물번호
        String reno = request.getParameter("reno");	  //댓글번호
    	String id = request.getParameter("reg_id"); //사용자아이디

        boardservice.insertBoardReplyDetail(replyDetailInfo);

        return "redirect:/myBoardRead.do?brdno=" + brdno + "&id=" + id;
    }
    
    /**
     * <ul>
     * <li>제  목 : 나의커뮤니티 답글 삭제</li>
     * <li>설  명 : 나의커뮤니티 답글 삭제한다</li>
     * <li>작성일 : 2018-05-01</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/myReplyDetailDelete.do")
    public String myReplyDetailDelete(HttpServletRequest request, BoardReplyDetailVO replyDetailInfo) throws Exception{
    	
        String brdno = request.getParameter("brdno"); //게시물번호
        String id = request.getParameter("id");	//사용자아이디
    
    	boardservice.deleteBoardReplyDetail(replyDetailInfo);

        return "redirect:/myBoardRead.do?brdno=" + brdno + "&id=" + id;
    }        

    /**
     * <ul>
     * <li>제  목 : 통합 검색 </li>
     * <li>설  명 : 검색어를 통해 각 게시판을 검색하여 결과값을 알려준다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */   
    
    @RequestMapping(value = "/search.do")
    public String mainSearch(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) throws Exception{
    	
        int searchCount = boardservice.searchCount(searchVO);
        List<?> listview  = boardservice.selectSearch(searchVO);
        
        //리턴할 값 셋팅 
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchCount", searchCount);
        modelMap.addAttribute("searchVO", searchVO);
       
        return "board/SearchResult";
    }  
    

    /**
     * <ul>
     * <li>제  목 : 소비자경험 커뮤니티 조회</li>
     * <li>설  명 : 커뮤니티 게시물을 스크롤게시물 형태로 보여준다.</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */ 
    
    @RequestMapping(value = "/consumerList.do")
    public String consumerList(SearchVO searchVO, ModelMap modelMap) throws Exception{

        List<?> listview  = boardservice.selectBoardOneNew(searchVO);
 
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/BoardReadScroll";
    }    
    
    
    /**
     * <ul>
     * <li>제  목 : 소비자경험 커뮤니티 스크롤 다운</li>
     * <li>설  명 : 마우스 스크롤 다운시 DB를 조회하여 화면 표시한다.</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */ 

    @RequestMapping(value = "/scrollDown.do", method = RequestMethod.POST)
    public @ResponseBody List<BoardVO> scrollDown(@RequestBody BoardVO board,SearchVO searchVO, ModelMap modelMap ) throws Exception{
    	
    	//마지막번호 밑으로만 검색
        Integer brdno = Integer.parseInt(board.getBrdno())-1;
        
        List<?> listview = boardservice.selectBoardOneNew2(brdno);
        
        modelMap.addAttribute("listview", listview);
        
        //테스트 읽기페이지
        return boardservice.selectBoardOneNew2(brdno);
    }    
    
    
    /**
     * <ul>
     * <li>제  목 : 다음에디터 링크</li>
     * <li>설  명 : 이하 다음에디터를 이용하여 첨부파일, 이미지를 나타내는 기능이다</li>
     * <li>작성일 : 2018-04-19</li>
     * <li>작성자 : 유형준</li>
     * </ul>
     *
     * @author 유형준
     */  
    
    @RequestMapping(value = "/daumEditor.do")
    public String home(HttpServletRequest request) throws Exception{

        return "daumeditor/editor_frame";
    }    
    
    // 이미지 첨부 팝업 
    @RequestMapping(value = "/imagePopup.do") 
    public String imagePopup() throws Exception{ 
    	
    	return "daumeditor/image"; 
    }
    
    //이미지 첨부파일
   @RequestMapping(value = "/uploadImageAjax.do", method = RequestMethod.POST) 
    public @ResponseBody HashMap uploadImageAjax(@RequestParam("Filedata") MultipartFile multipartFile,HttpSession httpSession) throws Exception{
	   
            FileUtil2 fs = new FileUtil2();

            HashMap fileInfo = fs.saveAllFiles(multipartFile, httpSession);
            
        return fileInfo;
    }
   
   /**
    * <ul>
    * <li>제  목 : 제품검색 조회</li>
    * <li>설  명 : 제품을 검색한다</li>
    * <li>작성일 : 2018-05-15</li>
    * <li>작성자 : 유형준</li>
    * </ul>
    *
    * @author 유형준
    */      
   
   @RequestMapping(value = "/searchPop.do")
   public String searchProduct(SearchVO searchVO, ModelMap modelMap) throws Exception{
	   
	   int count = 0;
	   count = boardservice.selectProductCount(searchVO);
	   
	   searchVO.pageCalculatePop(count); // startRow, endRow
	   
	   modelMap.addAttribute("count", count);
        
       List<?> prolist  = boardservice.selectProductList(searchVO);
         
       modelMap.addAttribute("prolist", prolist);
       modelMap.addAttribute("searchVO", searchVO);
       
       return "board/SearchPop";
   }       
   
}
