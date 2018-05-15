package gu.common;

public class PageVO {
    private Integer displayRowCount = 10;           // 출력할 데이터 개수
    private Integer rowStart;                       // 시작행번호
    private Integer rowEnd;                         // 종료행 번호
    private Integer totPage;                        // 전체 페이수
    private Integer totRow = 0;                     // 전체 데이터 수
    private Integer page;                           // 현재 페이지
    private Integer pageStart;                      // 시작페이지
    private Integer pageEnd;                        // 종료페이지

    private Integer displayRowCount2 = 5;           // 출력할 데이터 개수 제품검색용
    /**
     * 전체 데이터 개수(total)를 이용하여 페이지수 계산. 
     */
    public void pageCalculate(Integer total) {
        getPage();
        totRow  = total;
        totPage    = (int) ( total / displayRowCount );
        
        if ( total % displayRowCount > 0 ) {
            totPage++;
        }

        pageStart = (page - (page - 1) % 10) ;
        pageEnd = pageStart + 9;
        if (pageEnd > totPage) {
            pageEnd = totPage;
        }
        
        rowStart = ((page - 1) * displayRowCount) + 1 ;
        rowEnd   = rowStart + displayRowCount - 1;
    } 
    
    /**
     * 전체 데이터 개수(total)를 이용하여 페이지수 계산. 제품검색 팝업용(5개제한)  
     */
    public void pageCalculatePop(Integer total) {
        getPage();
        totRow  = total;
        totPage    = (int) ( total / displayRowCount2 );
        
        if ( total % displayRowCount2 > 0 ) {
            totPage++;
        }

        pageStart = (page - (page - 1) % 5) ;
        pageEnd = pageStart + 4;
        if (pageEnd > totPage) {
            pageEnd = totPage;
        }
        
        rowStart = ((page - 1) * displayRowCount2) + 1 ;
        rowEnd   = rowStart + displayRowCount2 - 1;
    } 
    

    /**
     * 현재 페이지 번호. 
     */
    public Integer getPage() {
        if (page == null || page == 0) {
            page = 1;
        }
        
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRowStart() {
        return rowStart;
    }

    public void setRowStart(Integer rowStart) {
        this.rowStart = rowStart;
    }

    public Integer getRowEnd() {
        return rowEnd;
    }

    public void setRowEnd(Integer rowEnd) {
        this.rowEnd = rowEnd;
    }

    public Integer getDisplayRowCount() {
        return displayRowCount;
    }

    public void setDisplayRowCount(Integer displayRowCount) {
        this.displayRowCount = displayRowCount;
    }

    public Integer getTotPage() {
        return totPage;
    }

    public void setTotPage(Integer totPage) {
        this.totPage = totPage;
    }

    public Integer getTotRow() {
        return totRow;
    }

    public void setTotRow(Integer totRow) {
        this.totRow = totRow;
    }

    public Integer getPageStart() {
        return pageStart;
    }

    public void setPageStart(Integer pageStart) {
        this.pageStart = pageStart;
    }

    public Integer getPageEnd() {
        return pageEnd;
    }

    public void setPageEnd(Integer pageEnd) {
        this.pageEnd = pageEnd;
    }

	public Integer getDisplayRowCount2() {
		return displayRowCount2;
	}

	public void setDisplayRowCount2(Integer displayRowCount2) {
		this.displayRowCount2 = displayRowCount2;
	}
    
}


