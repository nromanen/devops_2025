/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ (() => {

eval("const dogs = [\n  {\n    id: 1,\n    name: \"Buddy\",\n    breed: \"Golden Retriever\",\n    imageUrl: \"/img/buddy.jpg\"\n  },\n  {\n    id: 2,\n    name: \"Charlie\",\n    breed: \"Labrador Retriever\",\n    imageUrl: \"/img/charlie.jpg\"\n  },\n  {\n    id: 3,\n    name: \"Max\",\n    breed: \"German Shepherd\",\n    imageUrl: \"/img/max.jpg\"\n  },\n  {\n    id: 4,\n    name: \"Bella\",\n    breed: \"Poodle\",\n    imageUrl: \"/img/bella.jpg\"\n  },\n  {\n    id: 5,\n    name: \"Luna\",\n    breed: \"Bulldog\",\n    imageUrl: \"/img/luna.jpg\"\n  }\n];\n\nconst container = document.getElementById(\"dog-list\");\n\ndogs.forEach(dog => {\n  const card = document.createElement(\"div\");\n  card.innerHTML = `\n    <h2>${dog.name}</h2>\n    <p>Breed: ${dog.breed}</p>\n    <img src=\"${dog.imageUrl}\" alt=\"${dog.name}\" width=\"200\"/>\n  `;\n  container.appendChild(card);\n});\n\n\n//# sourceURL=webpack://ui/./src/index.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/index.js"]();
/******/ 	
/******/ })()
;