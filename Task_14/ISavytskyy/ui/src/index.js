const dogs = [
  {
    id: 1,
    name: "Buddy",
    breed: "Golden Retriever",
    imageUrl: "/img/buddy.jpg"
  },
  {
    id: 2,
    name: "Charlie",
    breed: "Labrador Retriever",
    imageUrl: "/img/charlie.jpg"
  },
  {
    id: 3,
    name: "Max",
    breed: "German Shepherd",
    imageUrl: "/img/max.jpg"
  },
  {
    id: 4,
    name: "Bella",
    breed: "Poodle",
    imageUrl: "/img/bella.jpg"
  },
  {
    id: 5,
    name: "Luna",
    breed: "Bulldog",
    imageUrl: "/img/luna.jpg"
  }
];

const container = document.getElementById("dog-list");

dogs.forEach(dog => {
  const card = document.createElement("div");
  card.innerHTML = `
    <h2>${dog.name}</h2>
    <p>Breed: ${dog.breed}</p>
    <img src="${dog.imageUrl}" alt="${dog.name}" width="200"/>
  `;
  container.appendChild(card);
});
