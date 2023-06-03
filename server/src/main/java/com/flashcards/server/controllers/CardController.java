package com.flashcards.server.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.flashcards.server.entity.Card;
import com.flashcards.server.payload.requests.CardInfoRequest;
import com.flashcards.server.payload.responses.CardInfoResponse;
import com.flashcards.server.payload.responses.MessageResponse;
import com.flashcards.server.repositories.CardRepository;

@RestController
@RequestMapping("/cards")
public class CardController {
    
    @Autowired
    CardRepository cardRepository;

    @GetMapping("")
    public ResponseEntity<?> getAllCards() {
        Iterable<Card> cards = cardRepository.findAll();
        List<CardInfoResponse> list = new ArrayList<>();
        for(Card card : cards) {
            CardInfoResponse infoResponse = new CardInfoResponse(card.getId(), card.getQuestion(), card.getIsMultipleChoice(), card.getAnswer());
            list.add(infoResponse);
        }
        return ResponseEntity.ok().body(list);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCard(@PathVariable Long id) {
        Optional<Card> result = cardRepository.findById(id);
        if(result.isPresent()) {
            Card card = result.get();
            CardInfoResponse infoResponse = new CardInfoResponse(card.getId(), card.getQuestion(), card.getIsMultipleChoice(), card.getAnswer());
            return ResponseEntity.ok().body(infoResponse);
        }
        return ResponseEntity.ok().body(new MessageResponse("Card not found!"));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCard(@PathVariable Long id) {
        Optional<Card> result = cardRepository.findById(id);
        if(result.isPresent()) {
            cardRepository.deleteById(id);
            return ResponseEntity.ok().body(new MessageResponse("Card is deleted!"));
        }
        return ResponseEntity.ok().body(new MessageResponse("Card not found!")); 
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateCard(@PathVariable Long id, @Valid @RequestBody CardInfoRequest cardInfo) {
        Optional<Card> result = cardRepository.findById(id);
        if(result.isPresent()) {
            Card card = result.get();
            card.setQuestion(cardInfo.getQuestion());
            card.setIsMultipleChoice(cardInfo.getIsMultipleChoice());
            card.setAnswer(cardInfo.getAnswer());
            cardRepository.save(card);
            CardInfoResponse infoResponse = new CardInfoResponse(card.getId(), card.getQuestion(), card.getIsMultipleChoice(), card.getAnswer());
            return ResponseEntity.ok().body(infoResponse);
        }
        return ResponseEntity.ok().body(new MessageResponse("Card not found!")); 
    }
}
