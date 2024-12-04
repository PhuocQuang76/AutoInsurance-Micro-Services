package com.synergisticit.repository;

import com.synergisticit.domain.ChatGpt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChatGptRepository extends JpaRepository<ChatGpt, Long> {
}
