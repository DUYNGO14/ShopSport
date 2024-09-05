package com.duyngostore.shopsport.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;

import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleSaveUploadFile(MultipartFile file, String targetFodel) {
        if (file.isEmpty()) {
            return null;
        }
        String rootPath = this.servletContext.getRealPath("/resources/images");
        String finalName = "";
        try {

            byte[] bytes = file.getBytes();

            File dir = new File(rootPath + File.separator + targetFodel);
            if (!dir.exists())
                dir.mkdirs();
            // Create the file on server
            finalName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return finalName;
    }

    public String handleSaveUploadListFile(MultipartFile[] files, String targetFodel) {
        if (files == null) {
            return null;
        }
        String rootPath = this.servletContext.getRealPath("/resources/images");
        String finalName = "";
        String finalListName = "";
        try {
            for (MultipartFile multipartFile : files) {
                byte[] bytes = multipartFile.getBytes();

                File dir = new File(rootPath + File.separator + targetFodel);
                if (!dir.exists())
                    dir.mkdirs();
                // Create the file on server
                finalName = System.currentTimeMillis() + "-" + multipartFile.getOriginalFilename();
                finalListName += System.currentTimeMillis() + "-" + multipartFile.getOriginalFilename() + ";";
                File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);
                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return finalListName;
    }
}
