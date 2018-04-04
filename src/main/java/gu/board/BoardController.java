package gu.board;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import gu.board.BoardVO;
import gu.common.FileUtil;
import gu.common.FileVO;
import gu.common.SearchVO;

@Controller 
public class BoardController {

    @Autowired
    private BoardService boardservice;
    /**
     * 메인으로 이동
     */
    @RequestMapping(value = "/home.do")
    public String home(HttpServletRequest request, ModelMap modelMap) {

    	String boardtype = request.getParameter("boardtype");
    	
    	System.out.println("++++++++++++++++++++++++++boardtype:"+boardtype);
    	
    	//보안코딩 변수가 앞으로
    	//소비자경험
    	if("consumer".equals(boardtype)) 
    	{
			String brdno = request.getParameter("brdno");
			
	        List<?> listview  = boardservice.selectConsumerListMain(brdno);
	            
	        modelMap.addAttribute("listview", listview);
    	}
    	//이슈
    	else if("issue".equals(boardtype))
    	{
			String brdno = request.getParameter("brdno");
			
	        List<?> listview  = boardservice.selectIssueListMain(brdno);
	            
	        modelMap.addAttribute("listview", listview);
    	}
    	else
    	{
			String brdno = request.getParameter("brdno");
			
	        List<?> listview  = boardservice.selectNoticeListMain(brdno);
	            
	        modelMap.addAttribute("listview", listview);
          	  		
    	}
      	return "board/home";  
    }	 
    
    /**
     * 리스트.
     */
    
    /* 공지사항===================================================================== */
    @RequestMapping(value = "/noticeList.do")
    public String noticeList(SearchVO searchVO, ModelMap modelMap) {

        searchVO.pageCalculate( boardservice.selectNoticeCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectNoticeList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/NoticeList";
    }    
    
    
    /* 소비자 경험===================================================================== */
    @RequestMapping(value = "/boardList.do")
    public String boardList(SearchVO searchVO, ModelMap modelMap) {

        searchVO.pageCalculate( boardservice.selectConsumerCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectConsumerList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/BoardReadTest";
    }
    
    
    /* 최근이슈===================================================================== */
    @RequestMapping(value = "/issueList.do")
    public String issueList(SearchVO searchVO, ModelMap modelMap) {

        searchVO.pageCalculate( boardservice.selectIssueCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectIssueList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/IssueList";
    }        
    
    /** 
     * 글 쓰기. 
     */
    
    /* 공지사항===================================================================== */
    @RequestMapping(value = "/noticeForm.do")
    public String noticeForm(HttpServletRequest request, ModelMap modelMap) {
        String brdno = request.getParameter("brdno");
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectNoticeOne(brdno);
            List<?> listview = boardservice.selectBoardFileList(brdno);
        
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/NoticeForm";
    }    
    
    /* 소비자 경험===================================================================== */
    @RequestMapping(value = "/boardForm.do")
    public String boardForm(HttpServletRequest request, ModelMap modelMap) {
        String brdno = request.getParameter("brdno");
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectBoardOne(brdno);
            List<?> listview = boardservice.selectBoardFileList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/BoardForm";
    }
    
    /* 최근이슈===================================================================== */
    @RequestMapping(value = "/issueForm.do")
    public String issueForm(HttpServletRequest request, ModelMap modelMap) {
        String brdno = request.getParameter("brdno");
        if (brdno != null) {
            BoardVO boardInfo = boardservice.selectIssueOne(brdno);
            List<?> listview = boardservice.selectBoardFileList(brdno);
        
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
        }
        
        return "board/IssueForm";
    }    
    
    /**
     * 글 저장.
     */
    /*공지사항*/
    @RequestMapping(value = "/noticeSave.do")
    public String noticeSave(HttpServletRequest request, BoardVO boardInfo) {
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertNotice(boardInfo, filelist, fileno);

        return "redirect:/noticeList.do";
    }    
    
    /*소비자경험*/
    @RequestMapping(value = "/boardSave.do")
    public String boardSave(HttpServletRequest request, BoardVO boardInfo) {
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertBoard(boardInfo, filelist, fileno);

        return "redirect:/boardList.do";
    }
    
    /*최근이슈*/
    @RequestMapping(value = "/issueSave.do")
    public String issueSave(HttpServletRequest request, BoardVO boardInfo) {
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertIssue(boardInfo, filelist, fileno);

        return "redirect:/issueList.do";
    }    

    /**
     * 글 읽기.
     */
    @RequestMapping(value = "/mainRead.do")
    public String mainRead(HttpServletRequest request, ModelMap modelMap) {
    	
    	//리턴정의
    	String result = "";
    	
    	//게시판구분 
    	String brdtype = request.getParameter("brdtype");
        String brdno = request.getParameter("brdno");
    	
    	//구분에 따라 분기
    	if ("C".equals(brdtype))
    	{
            boardservice.updateBoardRead(brdno);
            BoardVO boardInfo = boardservice.selectBoardOne(brdno);
            List<?> listview = boardservice.selectBoardFileList(brdno);
            List<?> replylist = boardservice.selectBoardReplyList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
            modelMap.addAttribute("replylist", replylist);   
            
            result = "board/NoticeRead";
    	}
    	else if("I".equals(brdtype))
    	{
            boardservice.updateIssueRead(brdno);
            BoardVO boardInfo = boardservice.selectIssueOne(brdno);
            List<?> listview = boardservice.selectBoardFileList(brdno);
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
            List<?> listview = boardservice.selectBoardFileList(brdno);
            List<?> replylist = boardservice.selectBoardReplyList(brdno);
            
            modelMap.addAttribute("boardInfo", boardInfo);
            modelMap.addAttribute("listview", listview);
            modelMap.addAttribute("replylist", replylist);
        	
            result = "board/NoticeRead" ;    		
    		
    	}

        return result;
    }        
    
    
    /*공지사항*/
    @RequestMapping(value = "/noticeRead.do")
    public String noticeRead(HttpServletRequest request, ModelMap modelMap) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.updateNoticeRead(brdno);
        BoardVO boardInfo = boardservice.selectNoticeOne(brdno);
        List<?> listview = boardservice.selectBoardFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        
        return "board/NoticeRead";
    }    
    
    /*소비자경험*/    
    @RequestMapping(value = "/boardRead.do")
    public String boardRead(HttpServletRequest request, ModelMap modelMap) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.updateBoardRead(brdno);
        BoardVO boardInfo = boardservice.selectBoardOne(brdno);
        List<?> listview = boardservice.selectBoardFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        
        return "board/BoardRead";
    }
    
    /*최근이슈*/
    @RequestMapping(value = "/issueRead.do")
    public String issueRead(HttpServletRequest request, ModelMap modelMap) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.updateIssueRead(brdno);
        BoardVO boardInfo = boardservice.selectIssueOne(brdno);
        List<?> listview = boardservice.selectBoardFileList(brdno);
        List<?> replylist = boardservice.selectBoardReplyList(brdno);
        
        modelMap.addAttribute("boardInfo", boardInfo);
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("replylist", replylist);
        
        return "board/IssueRead";
    }
    
    /**
     * 글 삭제.
     */
    /*공지사항*/
    @RequestMapping(value = "/noticeDelete.do")
    public String noticeDelete(HttpServletRequest request) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteNoticeOne(brdno);
        
        return "redirect:/noticeList.do";
    }    
    
    /*소비자경험*/
    @RequestMapping(value = "/boardDelete.do")
    public String boardDelete(HttpServletRequest request) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteBoardOne(brdno);
        
        return "redirect:/boardList.do";
    }
    
    /*최근이슈*/
    @RequestMapping(value = "/issueDelete.do")
    public String issueDelete(HttpServletRequest request) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteIssueOne(brdno);
        
        return "redirect:/issueList.do";
    }

    /* ===================================================================== */
    
    /**
     * 댓글 저장.
     */
    @RequestMapping(value = "/boardReplySave.do")
    public String boardReplySave(HttpServletRequest request, BoardReplyVO boardReplyInfo) {
        
    	boardservice.insertBoardReply(boardReplyInfo);

        return "redirect:/boardRead.do?brdno=" + boardReplyInfo.getBrdno();
    }
    
    /**
     * 댓글 삭제.
     */
    @RequestMapping(value = "/boardReplyDelete.do")
    public String boardReplyDelete(HttpServletRequest request, BoardReplyVO boardReplyInfo) {
        
    	boardservice.deleteBoardReply(boardReplyInfo.getReno());

        return "redirect:/boardRead.do?brdno=" + boardReplyInfo.getBrdno();
    }      
    
    /**
     * 전체검색.
     */    
    @RequestMapping(value = "/search.do")
    public String mainSearch(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
       System.out.println("+++++++++++++++++++++++++++mainSearch");
    	
        int searchCount = boardservice.searchCount(searchVO);
        List<?> listview  = boardservice.selectSearch(searchVO);
        
        //리턴할 값 셋팅 
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchCount", searchCount);
        modelMap.addAttribute("searchVO", searchVO);
       
        return "board/SearchResult";
    }  
    

    /* 신 소비자 경험===================================================================== */
    @RequestMapping(value = "/consumerList.do")
    public String consumerList(SearchVO searchVO, ModelMap modelMap) {

        List<?> listview  = boardservice.selectBoardOneNew(searchVO);
        
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/BoardReadTest";
    }    
    
    
    /**
     * 신 댓글 읽기
     */
    @RequestMapping(value = "/replyRead.do", method = RequestMethod.POST)
    public @ResponseBody List<BoardReplyVO> replyRead(@RequestBody BoardReplyVO replyVO,  ModelMap modelMap) {

    	Integer brdno = Integer.parseInt(replyVO.getBrdno());
    	
        System.out.println("+++++++++++++++++++++++++++++댓글 번호:"+brdno);
        //조회수 올림(사용x)
        //boardservice.updateBoardRead(brdno);
        
        List<?> replylist = boardservice.selectBoardReplyListNew(brdno);
        
        modelMap.addAttribute("replylist", replylist);
    	
        return  boardservice.selectBoardReplyListNew(brdno);
    }    
    
    /**
     * 다운스크롤시 게시물 읽기 
     */    
    //@ResponseBody json 데이터를 객체로 자동바인딩하는 함수
    @RequestMapping(value = "/scrollDown.do", method = RequestMethod.POST)
    public @ResponseBody List<BoardVO> scrollDown(@RequestBody BoardVO board,SearchVO searchVO, ModelMap modelMap ) {
    	
    	//마지막번호 밑으로만 검색
        Integer brdno = Integer.parseInt(board.getBrdno())-1;
        
        System.out.println("+++++++++++++++++++++++++++++마지막 번호:"+brdno);
        
        List<?> listview = boardservice.selectBoardOneNew2(brdno);
        
        modelMap.addAttribute("listview", listview);
        
        //테스트 읽기페이지
        return boardservice.selectBoardOneNew2(brdno);
    }    
    
    
}
