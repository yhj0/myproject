package gu.board;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

import gu.common.utiletc;

public class BoardVO {

	private String num;	
    private String brdno;
    private String brdtype;
    private String brdtitle; 
    private String brdwriter; 
    private String brdmemo; 
    private String brddate; 
    private String brdhit; 
    private String brddeleteflag; 
    private String filecnt;
    private String replycnt;
    private String reg_id;
    private String reg_dttm;
    private String chg_id;
    private String chg_dttm;
    private String brdlike;
    
    /* 첨부파일 */
    private List<MultipartFile> uploadfile;

    /**
     * 게시물 제목을 글자수에 맞추어 자르기.
     */
    public String getShortTitle(Integer len) {
        return utiletc.getShortString(brdtitle, len);
    }
    

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getBrdno() {
        return brdno;
    }

    public void setBrdno(String brdno) {
        this.brdno = brdno;
    }

    public String getBrdtype() {
		return brdtype;
	}

	public void setBrdtype(String brdtype) {
		this.brdtype = brdtype;
	}
    
    public String getBrdtitle() {
        return brdtitle; 
    }

    public void setBrdtitle(String brdtitle) {
        this.brdtitle = brdtitle;
    }

    public String getBrdwriter() {
        return brdwriter;
    }

    public void setBrdwriter(String brdwriter) {
        this.brdwriter = brdwriter;
    }

    public String getBrdmemo() {
        return brdmemo.replaceAll("(?i)<script", "&lt;script");
    }

    public void setBrdmemo(String brdmemo) {
        this.brdmemo = brdmemo;
    }

    public String getBrddate() {
        return brddate;
    }

    public void setBrddate(String brddate) {
        this.brddate = brddate;
    }

    public String getBrdhit() {
        return brdhit;
    }

    public void setBrdhit(String brdhit) {
        this.brdhit = brdhit;
    }

    public String getBrddeleteflag() {
        return brddeleteflag;
    }

    public void setBrddeleteflag(String brddeleteflag) {
        this.brddeleteflag = brddeleteflag;
    }

    public List<MultipartFile> getUploadfile() {
        return uploadfile;
    }

    public void setUploadfile(List<MultipartFile> uploadfile) {
        this.uploadfile = uploadfile;
    }

    public String getFilecnt() {
        return filecnt;
    }

    public void setFilecnt(String filecnt) {
        this.filecnt = filecnt;
    }

    public String getReplycnt() {
        return replycnt;
    }

    public void setReplycnt(String replycnt) {
        this.replycnt = replycnt;
    }

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getReg_dttm() {
		return reg_dttm;
	}

	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}

	public String getChg_id() {
		return chg_id;
	}

	public void setChg_id(String chg_id) {
		this.chg_id = chg_id;
	}

	public String getChg_dttm() {
		return chg_dttm;
	}

	public void setChg_dttm(String chg_dttm) {
		this.chg_dttm = chg_dttm;
	}

	public String getBrdlike() {
		return brdlike;
	}

	public void setBrdlike(String brdlike) {
		this.brdlike = brdlike;
	}


}
