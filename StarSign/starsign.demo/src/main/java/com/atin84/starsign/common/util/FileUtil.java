package com.atin84.starsign.common.util;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.atin84.starsign.common.properties.PropertyManager;

@Component("fileUtil")
public class FileUtil {
	private static Logger logger = LoggerFactory.getLogger(FileUtil.class);

	@Autowired
	private PropertyManager propertyManager;
			
	public String getUploadBase() {
		return this.propertyManager.getUploadBase();
	}
	
	public String saveFile(String subPath, MultipartFile multiPartFile, String oldFileName) throws IOException {
		if (multiPartFile == null || multiPartFile.getSize() == 0)
			return null;
		logger.debug("saveFile Path : " + this.propertyManager.getUploadBase() + File.separator + subPath);
		
		String uploadPath = makeUploadPath(subPath);
		
		String fileName = multiPartFile.getOriginalFilename();
		
		if (oldFileName != null && oldFileName.length() > 0 && fileName.equals(oldFileName) == false) {
			File file = new File(uploadPath, oldFileName);
			
			if (file.delete() == false) {
				logger.error(file.getAbsolutePath() + " 파일 삭제 실패");
			}
		}
		
		fileName = getNewFileName(uploadPath, fileName);

		multiPartFile.transferTo(new File(uploadPath, fileName));

		return fileName;
	}
	
	public void deleteFile(String subPath, String fileName) {
//		String uploadPath = propertiesService.getString("uploadPath");
		String uploadPath = this.propertyManager.getUploadBase();
		
		if (subPath != null && subPath.length() > 0) {
			uploadPath = uploadPath + File.separator + subPath;
		}
		
		File file = new File(uploadPath, fileName);
		
		if (file.delete() == false) {
			logger.error(file.getAbsolutePath() + " 파일 삭제 실패");
		} else {
			logger.debug(file.getAbsolutePath() + " 파일 삭제");
		}
	}
	
	private String makeUploadPath(String subPath) throws IOException {
//		String uploadPath = propertiesService.getString("uploadPath");
		String uploadPath = this.propertyManager.getUploadBase();
		
		if (subPath != null && subPath.length() > 0) {
			uploadPath = uploadPath + File.separator + subPath;
		}

		File file = new File(uploadPath);
		
		if (file.exists() == false) {
			if (file.mkdir() == false) {
				throw new IOException(file.getAbsolutePath() + " 디렉토리 생성 실패\n");
			} else
				logger.info(file.getAbsolutePath() + " 디렉토리 생성");
		}
		
		return uploadPath;
	}
	
	private String getNewFileName(String filePath, String fileName) {		
		int cnt = 0;  
		File file = new File(filePath, fileName);
		String fileNameWithoutExt = fileName.substring(0, fileName.lastIndexOf("."));
		String ext = fileName.substring(fileName.lastIndexOf("."));

		while (file.exists()) {
			fileNameWithoutExt += "(" + cnt +")";
			fileName = fileNameWithoutExt + ext;
			file = new File(filePath, fileName);
			cnt++;
		}	 		  
		return fileName;
	 }
	
	public File getFile(String subPath, String fileName) {
//		String uploadPath = propertiesService.getString("uploadPath");
		String uploadPath = this.propertyManager.getUploadBase();
		
		if (subPath != null && subPath.length() > 0) {
			uploadPath = uploadPath + File.separator + subPath;
		}

		File file = new File(uploadPath, fileName);
		logger.debug("=== file :" + file.getAbsolutePath());
		
		if (file.exists() == false || file.length() == 0) 
			return null;
		else
			return file;
	}
	
	public boolean deleteFolder(File targetFolder) {

		File[] childFile = targetFolder.listFiles();
		int size = childFile.length;

		if (size > 0) {
			for (int i = 0; i < size; i++) {
				if (childFile[i].isFile()) {
					if (childFile[i].delete())
						logger.debug(childFile[i] + " 파일 삭제");
					else
						logger.error(childFile[i] + " 파일 삭제 실패");
				} else {
					deleteFolder(childFile[i]);
				}
			}
		}
		
		if (targetFolder.delete())
			logger.debug(targetFolder + " 폴더 삭제");
		else
			logger.error(targetFolder + " 폴더 삭제 실패");
			
		return (!targetFolder.exists());
	}// deleteFolder
	
	public boolean deleteFolder(String folder) {
		return deleteFolder(new File(folder));
	}
	
	public static void main(String[] args) {
		FileUtil fileUtil = new FileUtil();
		
		fileUtil.deleteFolder("C:\\uploadPath" + File.separator + "v3mobile");
	}
	
 }
