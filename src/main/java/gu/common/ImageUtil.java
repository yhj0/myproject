package gu.common;

import java.io.File;
import java.io.FileInputStream;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

/**
 * 프로필 사진을 처리하는 로직
 */

public class ImageUtil {
    /**
     * 이미지 업로드.
     * @throws IOException 
     */
	
    /**
     * 회원가입일때 사진로직
     */
    public List<ImageVO> saveAllFiles(List<MultipartFile> upfiles, String id , HttpServletRequest request) throws IOException {
        //이미지 유무를 확인하는 flag
    	String fileName = request.getParameter("filename");
    	String fileSize = request.getParameter("filesize");

    	String filePath = "C:\\web_project\\worksplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\board\\upload_img\\"; 
        List<ImageVO> Imagelist = new ArrayList<ImageVO>();
        for (MultipartFile uploadfile : upfiles ) {
        	
            if (uploadfile.getOriginalFilename() == null || uploadfile.getOriginalFilename()=="") {
            	//디렉토리 생성
                makeBasePath(filePath + "/"+ id + "/");
                String serverFullPath = filePath + "/"+ id + "/" + "no_photo.jpg";
                
                long fsize = 0; 
                //원본위치
                FileInputStream  org_file = new FileInputStream("C:\\web_project\\worksplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\board\\upload_img\\no_photo.jpg");
                //복사될 곳
                FileOutputStream  new_file = new FileOutputStream(serverFullPath);
                
                FileChannel fcin = org_file.getChannel(); 
                FileChannel fcout = new_file.getChannel(); 
                
                //복사될 파일의 size 
                fsize = fcin.size(); 
                
                //transferTo 메소드를 이용하여 복사할 파일의 채널을 지정 
                //복사할  position은 0부터 파일 크기 만큼
                fcin.transferTo(0, fsize, fcout); 
                
                fcout.close(); 
                fcin.close(); 
                org_file.close(); 
                new_file.close();                
                
                //수동 기본 이미지 파일DB입력
                ImageVO imagevo = new ImageVO();
                imagevo.setFilename("no_photo.jpg");
                imagevo.setFilesize(1783);
                Imagelist.add(imagevo);
            	
                continue;
                
            }else{
            
	            saveFile(uploadfile, filePath + "/"+ id + "/", uploadfile.getOriginalFilename());
	            
	            ImageVO imagevo = new ImageVO();
	            imagevo.setFilename(uploadfile.getOriginalFilename());
	            //filedo.setRealname(newName);
	            imagevo.setFilesize(uploadfile.getSize());
	            Imagelist.add(imagevo);	
            }
        }
        return Imagelist;
    }    
    
    /**
     * 회원수정일때 사진로직
     */
    public List<ImageVO> saveAllFiles2(List<MultipartFile> upfiles, String id , HttpServletRequest request) throws IOException {
        //이미지 유무를 확인하는 flag
    	String fileName = request.getParameter("filename");
    	String fileSize = request.getParameter("filesize");
    	
    	String filePath = "C:\\web_project\\worksplace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\board\\upload_img\\"; 
        List<ImageVO> Imagelist = new ArrayList<ImageVO>();
        for (MultipartFile uploadfile : upfiles ) {
        	  
            saveFile(uploadfile, filePath + "/"+ id + "/", uploadfile.getOriginalFilename());
            
            ImageVO imagevo = new ImageVO();
            
            //수정을 하나 이미지를 첨부하지않았을때 
            if (uploadfile.getOriginalFilename() == null||uploadfile.getOriginalFilename()==""){
            
            }
            else 
            {
                imagevo.setFilename(uploadfile.getOriginalFilename());
                //filedo.setRealname(newName);
                imagevo.setFilesize(uploadfile.getSize());
                Imagelist.add(imagevo);	
            }

        }
        return Imagelist;
    }    
    
    
    /**
     * 이미지 저장 경로 생성.
     */
    public void makeBasePath(String path) {
        File dir = new File(path); 
        if (!dir.exists()) {
        	System.out.println("디렉토리만들기");
            dir.mkdirs();
        }
    }

    /**
     * 실제 이미지 저장.
     */
    public String saveFile(MultipartFile file, String basePath, String fileName){
        if (file == null || file.getName().equals("") || file.getSize() < 1) {
            return null;
        }
        
        makeBasePath(basePath);
        String serverFullPath =  basePath + fileName;
  
        File file1 = new File(serverFullPath);
        try {
            file.transferTo(file1);
        } catch (IllegalStateException ex) {
            System.out.println("IllegalStateException: " + ex.toString());
        } catch (IOException ex) {
            System.out.println("IOException: " + ex.toString());
        }
        
        return serverFullPath;
    }
    
    public String getFileExtension(String filename) {
          Integer mid = filename.lastIndexOf(".");
          return filename.substring(mid, filename.length());
    }

    public String getRealPath(String path, String filename) {
        return path + filename.substring(0,4) + "/";
    }
}
