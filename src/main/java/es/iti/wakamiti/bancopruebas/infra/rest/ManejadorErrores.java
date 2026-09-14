package es.iti.wakamiti.bancopruebas.infra.rest;

import es.iti.wakamiti.bancopruebas.servicio.RecursoNoEncontrado;
import es.iti.wakamiti.bancopruebas.servicio.TransicionInvalida;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class ManejadorErrores {

    @ExceptionHandler(RecursoNoEncontrado.class)
    public ResponseEntity<Map<String, String>> noEncontrado(RecursoNoEncontrado e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
    }

    @ExceptionHandler(TransicionInvalida.class)
    public ResponseEntity<Map<String, String>> conflicto(TransicionInvalida e) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of("error", e.getMessage()));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> cuerpoInvalido(MethodArgumentNotValidException e) {
        return ResponseEntity.badRequest().body(Map.of("error", "Cuerpo de peticion invalido"));
    }
}
