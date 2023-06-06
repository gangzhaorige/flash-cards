package com.flashcards.server.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.flashcards.server.entity.Choice;

@Repository
public interface ChoiceRepository extends JpaRepository<Choice, Long> {
}