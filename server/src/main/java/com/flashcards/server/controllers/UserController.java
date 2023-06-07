package com.flashcards.server.controllers;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.flashcards.server.entity.Card;
import com.flashcards.server.entity.Choice;
import com.flashcards.server.entity.Role;
import com.flashcards.server.entity.User;
import com.flashcards.server.payload.requests.CardInfoRequest;
import com.flashcards.server.payload.requests.MultipleChoiceCardInfoRequest;
import com.flashcards.server.payload.responses.MessageResponse;
import com.flashcards.server.payload.responses.UserInfoResponse;
import com.flashcards.server.repositories.CardRepository;
import com.flashcards.server.repositories.ChoiceRepository;
import com.flashcards.server.repositories.UserRepository;

@RestController
@RequestMapping("/users")
public class UserController {
    
    @Autowired
    UserRepository userRepository;
    @Autowired
    CardRepository cardRepository;
    @Autowired
    ChoiceRepository choiceRepository;

    @GetMapping("")
    public ResponseEntity<?> getAllUsers() {
        Map<String, Object> json = new HashMap<String, Object>();
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
        json.put("users", list);
        return ResponseEntity.ok().body(json);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUser(@PathVariable Long id) {
        Map<String, Object> json = new HashMap<String, Object>();
        Optional<User> result = userRepository.findById(id);
        if(result.isPresent()) {
            User user = result.get();
            Set<Role> set = user.getRoles();
            List<String> lStrings = new ArrayList<>();
            for(Role role : set) {
                lStrings.add(role.getName().toString());
            }
            UserInfoResponse userInfo = new UserInfoResponse(user.getId(), user.getEmail(), user.getUsername(), lStrings);
            json.put("user", userInfo);
            return ResponseEntity.ok().body(json);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new MessageResponse("The user does not exist."));
    }

    @PostMapping("/{id}/cards")
    public ResponseEntity<?> createCardForUser(@PathVariable Long id, @Valid @RequestBody CardInfoRequest cardInfo) {
        Optional<User> userResult = userRepository.findById(id);
        if(userResult.isPresent()) {
            Card card = new Card(cardInfo.getQuestion(), cardInfo.getIsMultipleChoice(), cardInfo.getAnswer());
            User user = userResult.get();
            card.setUser(user);
            cardRepository.save(card);
            URI uri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/cards/{id}").buildAndExpand(card.getId()).toUri();
            return ResponseEntity.created(uri).build();
        }
        Map<String, Object> json = new HashMap<String, Object>();
        json.put("message", "Validation errors in your request.");
        List<String> errors = new ArrayList<>();
        errors.add("User id does not exist.");
        json.put("errors", errors);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(json);
    }

    @PostMapping("/{id}/cards/choices")
    public ResponseEntity<?> createMultipleChoicesCard(@PathVariable Long id, @Valid @RequestBody MultipleChoiceCardInfoRequest cardInfo) {
        Optional<User> userResult = userRepository.findById(id);
        if(!userResult.isPresent()) {
            Map<String, Object> json = new HashMap<String, Object>();
            json.put("message", "Validation errors in your request.");
            List<String> errors = new ArrayList<>();
            errors.add("User id does not exist.");
            json.put("errors", errors);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(json);
        }
        Card card = new Card(cardInfo.getQuestion(), cardInfo.isIsMultipleChoice(), cardInfo.getAnswer());
        card.setUser(userResult.get());
        cardRepository.save(card);

        for(String answer : cardInfo.getChoices()) {
            Choice choice = new Choice(answer);
            choice.setCard(card);
            choiceRepository.save(choice);
        }
        return ResponseEntity.ok().body(new MessageResponse("Card created."));
    }
}
