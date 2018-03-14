package gu.common;

public class ImageVO {
    private Integer imgno; 
    private String filename;
    private String realname;
    private long filesize;
    private String reg_id;
    private String reg_dttm;
    private String chg_id;
    private String chg_dttm;
    
    private String parentPK;
    /**
     * 파일 크기를 정형화하기.
     */
    public String size2String() {
        Integer unit = 1024;
        if (filesize < unit) {
            return String.format("(%d B)", filesize);
        }
        int exp = (int) (Math.log(filesize) / Math.log(unit));

        return String.format("(%.0f %s)", filesize / Math.pow(unit, exp), "KMGTPE".charAt(exp - 1));
    }

	public Integer getImgno() {
		return imgno;
	}

	public void setImgno(Integer imgno) {
		this.imgno = imgno;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public long getFilesize() {
		return filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
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

	public String getParentPK() {
		return parentPK;
	}

	public void setParentPK(String parentPK) {
		this.parentPK = parentPK;
	}
    
    
}
