package com.flashcards.server.controllers;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.flashcards.server.entity.Choice;
import com.flashcards.server.payload.responses.ChoiceInfoResponse;
import com.flashcards.server.repositories.CardRepository;
import com.flashcards.server.repositories.ChoiceRepository;

@RestController
@RequestMapping("/choices")
public class ChoiceController {

    @Autowired
    ChoiceRepository ChoiceRepository;
    @Autowired
    CardRepository cardRepository;

    @GetMapping("")
    public ResponseEntity<?> getAllChoices() {
        Map<String, Object> json = new HashMap<String, Object>();
        Iterable<Choice> choices = ChoiceRepository.findAll();
        List<ChoiceInfoResponse> list = new ArrayList<>();

        for(Choice choice : choices) {
            ChoiceInfoResponse response = new ChoiceInfoResponse(choice.getId(), choice.getAnswerText(), choice.getCard().getId());
            list.add(response);
        }
        json.put("choices", list);
        return ResponseEntity.ok().body(json);
    }
}