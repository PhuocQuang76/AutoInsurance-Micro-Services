package com.synergisticit.controller;


import com.synergisticit.domain.User;
import com.synergisticit.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController {
    @Autowired
    UserService userService;


    @RequestMapping("/user/{username}")
    public User findUserByUserName(@PathVariable String username){
        return userService.findUserByUserName(username);
    }

    @RequestMapping("/users")
    public List<User> getUsers(){
        return userService.findAll();

    }
}
