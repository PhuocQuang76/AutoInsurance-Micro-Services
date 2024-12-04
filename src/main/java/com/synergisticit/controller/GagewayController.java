package com.synergisticit.controller;

import com.synergisticit.domain.User;
import com.synergisticit.service.RoleService;
import com.synergisticit.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
public class GagewayController {
    @Autowired
    UserService userService;

    @Autowired
    RoleService roleService;
    @RequestMapping("/userForm")
    public String userForm(@ModelAttribute User user, Model model, Principal principal){
        model.addAttribute("users", userService.findAll());
        model.addAttribute("roles", roleService.findAll());

//        if(principal != null) {
//            model.addAttribute("loggedInUser", principal.getName());
//            User userDB = userService.findUserByUserName(principal.getName());
//            System.out.println(userDB.getUserId());
//            List<Role> rolesDB = userDB.getRoles();
//            model.addAttribute("roles", rolesDB);
//        }
        return "userForm";
    }

    @RequestMapping("saveUser")
    public String saveUser(@Valid @ModelAttribute User user, BindingResult br, Model model){
        if(br.hasErrors()){
            model.addAttribute("users", userService.findAll());
            model.addAttribute("roles", roleService.findAll());
            model.addAttribute("hasErrors", true);
            return "userForm";
        }else{

            model.addAttribute("users", userService.findAll());
            model.addAttribute("roles", roleService.findAll());
            userService.save(user);
            return "redirect:userForm";
        }
    }

    @RequestMapping("/updateUser")
    public String updateUser(@ModelAttribute User user, Model model) {
        user = userService.findById(user.getUserId());
        user.setPassword("");
        model.addAttribute("user", user);
        model.addAttribute("retrievedRole", user.getRoles());
        model.addAttribute("users", userService.findAll());
        model.addAttribute("roles", roleService.findAll());

        return "userForm";
    }

    //delete?userId=1
    @RequestMapping("/deleteUser")
    public String deleteUser(@ModelAttribute User user, Model model) {
        userService.deleteById(user.getUserId());
        return "redirect:userForm";
    }




}
