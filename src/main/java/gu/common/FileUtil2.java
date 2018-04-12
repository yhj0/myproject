package gu.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public class FileUtil2 {
    /**
     * 이미지첨부업로드
     */
    public HashMap saveAllFiles(MultipartFile uploadfile, HttpSession httpSession) {
        HashMap fileInfo = new HashMap();
        
     //   for (MultipartFile uploadfile : upfiles ) {
            if (uploadfile.getSize() == 0) {
                return fileInfo;
            }
            String defaultPath ="C:\\Users\\SJICT04\\git\\board_sample\\src\\main\\webapp\\upload_img\\";  // 서버기본경로 (프로젝트 폴더 아님)
            //String path = defaultPath + File.separator + "upload" + File.separator + "board" + File.separator + "images" + File.separator + "";
            
            String modifyName = getNewName(uploadfile);
            
            saveFile(uploadfile, defaultPath + "/" + modifyName.substring(0,4) + "/", modifyName);
            //파일경로

            
            
          //  filelist.add(filedo);
         //}  
         // CallBack - Map에 담기 
            //이미지 경로
            String imageurl = httpSession.getServletContext().getContextPath() + "/upload_img/"  + modifyName.substring(0,4) + "/"+ modifyName;
            
            System.out.println("** upload 정보 **");
            System.out.println("** defaultPath : " + defaultPath + " **"); 
            System.out.println("** path : " + "" + " **"); 
            System.out.println("** originalName : " + uploadfile.getOriginalFilename() + " **"); 
            System.out.println("** modifyName : " + modifyName + " **");
            System.out.println("** filesize : " + uploadfile.getSize() + " **");
            System.out.println("** imageurl : " + imageurl + " **");

            
            fileInfo.put("imageurl", imageurl); // 상대파일경로(사이즈변환이나 변형된 파일) 
            fileInfo.put("filename", modifyName); // 파일명 
            fileInfo.put("filesize", uploadfile.getSize()); // 파일사이즈 
            fileInfo.put("imagealign", "C"); // 이미지정렬(C:center) 
            fileInfo.put("originalurl", imageurl); // 실제파일경로 
            fileInfo.put("thumburl", imageurl); // 썸네일파일경로(사이즈변환이나 변형된 파일) 
            fileInfo.put("result", 1); // -1, -2를 제외한 아무거나 싣어도 됨

        return fileInfo;
    }    
    
    /**
     * 파일 저장 경로 생성.
     */
    public void makeBasePath(String path) {
        File dir = new File(path); 
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    /**
     * 실제 파일 저장.
     */
    public String saveFile(MultipartFile file, String basePath, String fileName){
        if (file == null || file.getName().equals("") || file.getSize() < 1) {
            return null;
        }
     
        makeBasePath(basePath);
        String serverFullPath = basePath + fileName;
  
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
    
    /**
     * 날짜로 새로운 파일명 부여.
     */
    public String getNewName(MultipartFile uploadfile) {
        String originalName = uploadfile.getOriginalFilename(); // 실제 파일명
        String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1).toLowerCase(); // 실제파일 확장자 (소문자변경)
        SimpleDateFormat ft = new SimpleDateFormat("yyyyMMddhhmmssSSS");
        return ft.format(new Date()) + "." + originalNameExtension;
    }
    
    public String getFileExtension(String filename) {
          Integer mid = filename.lastIndexOf(".");
          return filename.substring(mid, filename.length());
    }

    public String getRealPath(String path, String filename) {
        return path + filename.substring(0,4) + "/";
    }

}
