package com.example.restservice;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/dogs")
public class DogController {

    // Повертає JSON-список собак
    @GetMapping
    public List<Dog> getDogs() {
        return List.of(
            new Dog(1, "Buddy", "Golden Retriever"),
            new Dog(2, "Charlie", "Labrador Retriever"),
            new Dog(3, "Max", "German Shepherd"),
            new Dog(4, "Bella", "Poodle"),
            new Dog(5, "Luna", "Bulldog")
        );
    }

    // Повертає список собак як звичайний текст
    @GetMapping(path = "/text", produces = "text/plain")
    public String getDogsText() {
        return """
            1. Buddy - Golden Retriever
            2. Charlie - Labrador Retriever
            3. Max - German Shepherd
            4. Bella - Poodle
            5. Luna - Bulldog
        """;
    }
}
