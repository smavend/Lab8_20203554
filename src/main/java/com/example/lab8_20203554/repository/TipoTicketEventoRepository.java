package com.example.lab8_20203554.repository;

import com.example.lab8_20203554.entity.Evento;
import com.example.lab8_20203554.entity.TipoTicketEvento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TipoTicketEventoRepository extends JpaRepository<TipoTicketEvento, Integer> {
    @Query(nativeQuery = true, value = "SELECT e.*, t.* FROM evento e inner join tipo_ticket_evento t on (t.idEvento=e.id) where e.id = ?")
    List<Evento>
}
