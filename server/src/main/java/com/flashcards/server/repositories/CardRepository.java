package com.flashcards.server.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.flashcards.server.entity.Card;

public interface CardRepository extends JpaRepository<Card, Long> {
    
}
