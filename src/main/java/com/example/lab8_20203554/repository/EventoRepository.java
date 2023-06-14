package com.example.lab8_20203554.repository;

import com.example.lab8_20203554.entity.Evento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EventoRepository  extends JpaRepository<Evento, Integer> {
    Optional<Evento> findById(int id);


}
