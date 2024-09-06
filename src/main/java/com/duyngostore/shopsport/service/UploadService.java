package com.duyngostore.shopsport.service;

import org.springframework.web.multipart.MultipartFile;

public interface UploadService {

    public String handleSaveUploadFile(MultipartFile file, String targetFodel);

    public String handleSaveUploadListFile(MultipartFile[] files, String targetFodel);
}
