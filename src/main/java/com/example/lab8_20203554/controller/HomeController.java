package com.example.lab8_20203554.controller;

import com.example.lab8_20203554.entity.Evento;
import com.example.lab8_20203554.repository.EventoRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@CrossOrigin
public class HomeController {

    final EventoRepository eventoRepository;

    public HomeController(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    @ResponseBody
    @GetMapping("/evento")
    public List<Evento> listar(){
        return eventoRepository.findAll();
    }
    @GetMapping("/evento/{id}")
    public ResponseEntity<HashMap<String,Object>> buscar(@PathVariable ("id") String id){
        HashMap<String,Object> response = new HashMap<>();
        try {
            int idNum = Integer.parseInt(id);
            if (eventoRepository.findById(idNum).isPresent()) {
                response.put("evento", eventoRepository.findById(idNum).get());
                response.put("resultado", "exitoso");
                return ResponseEntity.ok(response);
            } else {
                response.put("msg", "Evento no encontrado");
            }
        }catch (NumberFormatException e){
            response.put("msg","el ID debe ser un número entero positivo");
        }
        response.put("resultado","Falla");
        return ResponseEntity.badRequest().body(response);
    }

    @PostMapping(value = "/evento")
    public ResponseEntity<HashMap<String, Object>> crear(@RequestParam ("fetchId") String fetch,
                                                         @RequestBody Evento evento){
        HashMap<String,Object> response = new HashMap<>();
        if(fetch.equals("false")){
            if(evento.getDescripcion()!=null && evento.getFecha()!=null && evento.getNombre()!=null && evento.getLocal().getId()!=0 && evento.getLocal().getDireccion()!=null){
                eventoRepository.save(evento);
                response.put("estado", "creado");
                return ResponseEntity.ok(response);
            }else {
                response.put("msg","Debe enviar un evento completo");
                response.put("estado","error");
                return ResponseEntity.badRequest().body(response);
            }
        } else if (fetch.equals("true")) {
            if(evento.getId()!=0 && evento.getDescripcion()!=null && evento.getFecha()!=null && evento.getNombre()!=null && evento.getLocal().getId()!=0 && evento.getLocal().getDireccion()!=null){
                eventoRepository.save(evento);
                response.put("estado", "creado");
                response.put("id", evento.getId());
                return ResponseEntity.ok(response);
            }else {
                response.put("msg","Debe enviar un evento");
                response.put("estado","error");
                return ResponseEntity.badRequest().body(response);
            }
        } else {
            response.put("msg","Error en el valor de fetchId");
            response.put("estado","error");
            return ResponseEntity.badRequest().body(response);
        }
    }

    @GetMapping("/eventoConTipoDeTicket/{id}")
    public ResponseEntity<HashMap<String,Object>> obtenerEvento(@PathVariable ("id") String id){
        HashMap<String,Object> response = new HashMap<>();
        try {
            int idNum = Integer.parseInt(id);
            if (eventoRepository.findById(idNum).isPresent()) {
                response.put("evento", eventoRepository.findById(idNum).get());
                response.put("resultado", "exitoso");
                return ResponseEntity.ok(response);
            } else {
                response.put("msg", "Evento no encontrado");
            }
        }catch (NumberFormatException e){
            response.put("msg","el ID debe ser un número entero positivo");
        }
        response.put("resultado","Falla");
        return ResponseEntity.badRequest().body(response);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<HashMap<String, String>> gestionCrear(HttpServletRequest request){
        HashMap<String, String> responseMap = new HashMap<>();
        if (request.getMethod().equals("POST")){
            responseMap.put("estado", "error");
        }
        return ResponseEntity.badRequest().body(responseMap);
    }
}
