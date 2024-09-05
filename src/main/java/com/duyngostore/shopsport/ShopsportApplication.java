package com.duyngostore.shopsport;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
// @SpringBootApplication(exclude =
// org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class ShopsportApplication {

	public static void main(String[] args) throws Exception {
		SpringApplication.run(ShopsportApplication.class, args);
	}

}
