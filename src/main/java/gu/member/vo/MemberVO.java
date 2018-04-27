package gu.member.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	
    private String id;
    private String password; 
    private String name; 
    private String nick_name; 
    private String email;
    private String email_1;
    private	String email_2;
    private String reg_dttm;
    private String filename;
    private String mobile1;
    private String mobile2;
    private String mobile3;
    private String hom_phone1;
    private String hom_phone2;
    private String hom_phone3;

   
    /* 프로필이미지 */
    private List<MultipartFile> uploadfile;
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getReg_dttm() {
		return reg_dttm;
	}
	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}

    public List<MultipartFile> getUploadfile() {
        return uploadfile;
    }

    public void setUploadfile(List<MultipartFile> uploadfile) {
        this.uploadfile = uploadfile;
    }
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getEmail_1() {
		return email_1;
	}
	public void setEmail_1(String email_1) {
		this.email_1 = email_1;
	}
	public String getEmail_2() {
		return email_2;
	}
	public void setEmail_2(String email_2) {
		this.email_2 = email_2;
	}
	public String getMobile1() {
		return mobile1;
	}
	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getMobile3() {
		return mobile3;
	}
	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}
	public String getHom_phone1() {
		return hom_phone1;
	}
	public void setHom_phone1(String hom_phone1) {
		this.hom_phone1 = hom_phone1;
	}
	public String getHom_phone2() {
		return hom_phone2;
	}
	public void setHom_phone2(String hom_phone2) {
		this.hom_phone2 = hom_phone2;
	}
	public String getHom_phone3() {
		return hom_phone3;
	}
	public void setHom_phone3(String hom_phone3) {
		this.hom_phone3 = hom_phone3;
	}
	
}
