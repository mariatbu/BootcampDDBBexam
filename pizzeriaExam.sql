#Ejercicio 1
CREATE DATABASE pizzeria;
USE pizzeria;

CREATE TABLE Ingredients (
    id BINARY(16) PRIMARY KEY,
    ingredientname VARCHAR(255) NOT NULL,
    price DECIMAL (10, 2) NOT NULL,
    UNIQUE(ingredientname)
);

CREATE TABLE Users (
    id BINARY(16) PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    pwd VARCHAR(255) NOT NULL
);

CREATE TABLE Pizzas (
    id BINARY(16) PRIMARY KEY,
    pizzaname VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
	price DECIMAL(10, 2) NOT NULL,
    UNIQUE(pizzaname)
);

CREATE TABLE Comments (
	id BINARY(16) PRIMARY KEY,
    text_comm VARCHAR (255) NOT NULL,
    score FLOAT NOT NULL,
    date_time datetime NOT NULL,
    user_comm INT NOT NULL,
    FOREIGN KEY (user_comm) REFERENCES Users(id),
    pizza_comm INT NOT NULL,
    FOREIGN KEY (pizza_comm) REFERENCES Pizzas(id)
);

CREATE TABLE pizza_ingredients (
    id BINARY(16) PRIMARY KEY NOT NULL,
    id_pizza BINARY(16) NOT NULL,
    id_ingredient BINARY(16) NOT NULL,
    CONSTRAINT fk_pizzaid FOREIGN KEY (id_pizza) REFERENCES Pizzas(id),
    CONSTRAINT fk_ingredients FOREIGN KEY (id_ingredient) REFERENCES Ingredients(id),
    UNIQUE(id_pizza, id_ingredient)
);
CREATE INDEX IX_pizza_pizza_ingredient ON pizza_ingredient(id_pizza);
CREATE INDEX IX_ingredient_pizza_ingredient ON pizza_ingredient(id_ingredient);

#Ejercicio 2
BEGIN;
INSERT INTO ingredients (id, name, price)
VALUES (1, "Tomate", 1);
INSERT INTO ingredient(id, name, price)
VALUES (2, "Queso", 3);
INSERT INTO pizzas (id, name, url)
VALUES (1, "Carbonara", "http://www.pizzeria.com/pizza/carbonara");
INSERT INTO pizza_ingredients(id, id_pizza, id_ingredient)
VALUES (1, 1, 1);
INSERT INTO pizza_ingredients(id, id_pizza, id_ingredient)
VALUES(1, 1, 2);
COMMIT;

#Ejercicio 3
SELECT pizzas.name, SUM(ingredients.price) AS precio FROM pizzas
INNER JOIN pizza_ingredients ON pizzas.id = pizza_ingredients.id_pizza
INNER JOIN ingredients ON pizza_ingredients.id_ingredient = ingredients.id
GROUP BY pizzas.name;

#Ejercicio 4
SELECT pizzas.id as IdPizza, pizzas.name as PizzaName FROM pizzas 
LEFT JOIN pizza_ingredients on Pizza.ID = pizza_ingredients.id_pizza 
WHERE pizza_ingredients.ID_ingredient IS NULL;
