package gu.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FileDownload {

    /**
     * 파일(첨부파일, 이미지등) 다운로드.
     * @throws UnsupportedEncodingException 
     * 
     */
    @RequestMapping(value = "fileDownload")
    public void fileDownload(HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
    	String path = "c:\\fileupload\\"; 
        
        String filename = request.getParameter("filename");
        String downname = request.getParameter("downname");
        
        String realPath = "";
        
        String header = request.getHeader("User-Agent");
 
        if (filename == null || "".equals(filename)) {
            filename = downname;
        }
        
        realPath = path + downname.substring(0,4) + "/" + downname;

        File file1 = new File(realPath);
        if (!file1.exists()) {
            return ;
        }
 
        // 인터넷익스플로러 브라우저
        if (header.contains("MSIE")|| header.contains("Trident")){
        	filename = URLEncoder.encode(filename, "UTF-8").replace("+", "%20");
        	response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\""); 
        }
        //그외 브라우저
        else
        {
        	filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
        	response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");         	
        }

        
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realPath);

            int ncount = 0;
            byte[] bytes = new byte[1024];

            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (FileNotFoundException ex) {
            System.out.println("FileNotFoundException");
        } catch (IOException ex) {
            System.out.println("IOException");
        }
    }
    
}
