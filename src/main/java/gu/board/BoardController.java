package gu.board;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

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
    	return "board/home";
    }	   
    
    /**
     * 리스트.
     */
    @RequestMapping(value = "/boardList.do")
    public String boardList(SearchVO searchVO, ModelMap modelMap) {

        searchVO.pageCalculate( boardservice.selectBoardCount(searchVO) ); // startRow, endRow

        List<?> listview  = boardservice.selectBoardList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        modelMap.addAttribute("searchVO", searchVO);
        
        return "board/BoardList";
    }
    
    /** 
     * 글 쓰기. 
     */
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
    
    /**
     * 글 저장.
     */
    @RequestMapping(value = "/boardSave.do")
    public String boardSave(HttpServletRequest request, BoardVO boardInfo) {
        String[] fileno = request.getParameterValues("fileno");
        
        FileUtil fs = new FileUtil();
        List<FileVO> filelist = fs.saveAllFiles(boardInfo.getUploadfile());

        boardservice.insertBoard(boardInfo, filelist, fileno);

        return "redirect:/boardList.do";
    }

    /**
     * 글 읽기.
     */
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
    
    /**
     * 글 삭제.
     */
    @RequestMapping(value = "/boardDelete.do")
    public String boardDelete(HttpServletRequest request) {
        
        String brdno = request.getParameter("brdno");
        
        boardservice.deleteBoardOne(brdno);
        
        return "redirect:/boardList.do";
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
}
