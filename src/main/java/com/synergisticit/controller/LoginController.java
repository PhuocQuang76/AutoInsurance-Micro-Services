package com.synergisticit.controller;


import com.synergisticit.domain.User;
import com.synergisticit.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
public class LoginController {
    @Autowired
    UserService userService;
    @RequestMapping("/login")
    public String login(@RequestParam(value="logout", required= false) String logout,
                        @RequestParam(value="error", required = false) String error,
                        HttpServletRequest req,
                        HttpServletResponse res,
                        Model model
    ){
        System.out.println("loginToApp()...");


        String message = null;


        if(logout != null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if(auth != null) {
                new SecurityContextLogoutHandler().logout(req, res, auth);
                message="You are logged out.";
            }
        }

        if(error != null) {
            message="Either username or password is incorrect.";
        }

        model.addAttribute("message", message);
        return "loginForm";
    }


    @RequestMapping({"/","/home"})
    public String home(Model model, Principal principal) {
        if(principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);
            if(user != null){
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "home";
    }

    @RequestMapping({"/autoPlan"})
    public String autoPlan(Model model, Principal principal){
        if(principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);
            if(user != null){
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "autoPlan";
    }


    @RequestMapping("accessDenied")
    public String accessDenied() {

        return "accessDenied";
    }

    @RequestMapping("/driverForm")
    public String driverForm(Model model, Principal principal){
        if(principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);
            if (user != null) {
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "driverForm";
    }

    @RequestMapping("/yourQuoteForm")
    public String yourQuote(Model model, Principal principal){
        if(principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);
            if(user != null){
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "yourQuoteForm";
    }


    @RequestMapping("/card")
    public String card(@RequestParam String username, @RequestParam String email, @RequestParam String amount){

        return "card";
    }

    @RequestMapping("/success")
    public String success(@RequestParam String payment_intent_client_secret){

        return "success";
    }


    @RequestMapping("/documentForm")
    public String documentForm(Model model, Principal principal){
        if(principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);
            if(user != null){
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "documentForm";
    }

    @RequestMapping("/claimForm")
    public String claimForm(Model model, Principal principal) {
        if (principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);

            if (user != null) {
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "claimForm";
    }

    @RequestMapping("/chatGptForm")
    public String chatForm(Model model, Principal principal) {
        if (principal != null) {
            String userName = principal.getName();
            User user = userService.findUserByUserName(userName);

            if (user != null) {
                model.addAttribute("loggedInUserEmail", user.getEmail());
            }
            model.addAttribute("loggedInUserName", principal.getName());
        }
        return "chatGptForm";
    }


}


