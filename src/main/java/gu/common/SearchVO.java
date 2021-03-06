package gu.common;


public class SearchVO extends  PageVO  {

	private String id;						//사용자아이디
    private String brdno;                       // 게시판 그룹
    private String searchKeyword = "";         // 검색 키워드 (전체_검색용)
    private String searchKeyword2 = "";         // 검색 키워드 (게시판_검색용)
    private String searchType = "";            // 검색 필드: 제목, 내용  
    private String[] searchTypeArr;            // 검색 필드를 배열로 변환
    private int searchCount;            // 검색된 건수
    
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getbrdno() {
        return brdno;
    }

    public void setbrdno(String brdno) {
        this.brdno = brdno;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }
    
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }
    
    public String getSearchKeyword2() {
		return searchKeyword2;
	}

	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
	}

	public String getSearchType() {
        return searchType;
    }
    
    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    
    public String[] getSearchTypeArr() {
        return searchType.split(",");
    }
    
    public int getSearchCount() {
		return searchCount;
	}

	public void setSearchCount(int searchCount) {
		this.searchCount = searchCount;
	}
    
}
 