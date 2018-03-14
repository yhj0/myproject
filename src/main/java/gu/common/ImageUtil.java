package gu.common;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;


public class ImageUtil {
    /**
     * 이미지 업로드.
     */
    public List<ImageVO> saveAllFiles(List<MultipartFile> upfiles, String id) {
        String filePath = "C:\\Users\\SJICT04\\git\\board_sample\\src\\main\\webapp\\upload_img\\"; 
        List<ImageVO> Imagelist = new ArrayList<ImageVO>();

        for (MultipartFile uploadfile : upfiles ) {
            if (uploadfile.getSize() == 0) {
                continue;
            }
            
            saveFile(uploadfile, filePath + "/"+ id + "/", uploadfile.getOriginalFilename());
            
            ImageVO imagevo = new ImageVO();
            imagevo.setFilename(uploadfile.getOriginalFilename());
            //filedo.setRealname(newName);
            imagevo.setFilesize(uploadfile.getSize());
            Imagelist.add(imagevo);
        }
        return Imagelist;
    }    
    
    /**
     * 이미지 저장 경로 생성.
     */
    public void makeBasePath(String path) {
        File dir = new File(path); 
        if (!dir.exists()) {
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
    
    public String getFileExtension(String filename) {
          Integer mid = filename.lastIndexOf(".");
          return filename.substring(mid, filename.length());
    }

    public String getRealPath(String path, String filename) {
        return path + filename.substring(0,4) + "/";
    }
}
