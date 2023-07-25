package com.dockertest.sbdockerrender.controller;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorld {

    @Value("${app.message}")
    private String message;

    @GetMapping("hi")
    public String sayHi() {
        System.out.println(message);
        return message;
    }



}
