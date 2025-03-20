package com.example.restservice;

public class Dog {
    private long id;
    private String name;
    private String breed;

    public Dog(long id, String name, String breed) {
        this.id = id;
        this.name = name;
        this.breed = breed;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getBreed() {
        return breed;
    }
}
