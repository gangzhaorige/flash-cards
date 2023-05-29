package com.flashcards.server.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.flashcards.server.entity.Role;
import com.flashcards.server.entity.User;
import com.flashcards.server.payload.responses.MessageResponse;
import com.flashcards.server.payload.responses.UserInfoResponse;
import com.flashcards.server.repositories.UserRepository;

@RestController
@RequestMapping("/users")
public class UserController {
    
    @Autowired
    UserRepository userRepository;

    @GetMapping("")
    public ResponseEntity<?> getAllUsers() {
        Iterable<User> users = userRepository.findAll();
        List<UserInfoResponse> list = new ArrayList<>();
        for(User user : users) {
            Set<Role> set = user.getRoles();
            List<String> lStrings = new ArrayList<>();
            for(Role role : set) {
                lStrings.add(role.getName().toString());
            }
            list.add(new UserInfoResponse(user.getId(), user.getEmail(), user.getUsername(), lStrings));
        }
        return ResponseEntity.ok().body(list);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUser(@PathVariable Long id) {
        if(userRepository.existsById(id)) {
            Optional<User> user = userRepository.findById(id);
            User userInfo = user.get();
            Set<Role> set = userInfo.getRoles();
            List<String> lStrings = new ArrayList<>();
            for(Role role : set) {
                lStrings.add(role.getName().toString());
            }
            return ResponseEntity.ok().body(new UserInfoResponse(userInfo.getId(), userInfo.getEmail(), userInfo.getUsername(), lStrings));
        }
        return ResponseEntity.ok().body(new MessageResponse("ID not found!"));
    }
}
