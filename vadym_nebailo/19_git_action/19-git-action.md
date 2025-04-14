## Task (70 points)

#### 1. CI process (ci.yml)
```yml
name: Java CI with Maven

on:
  push:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '11'

      - name: Build with Maven
        run: mvn clean package

      - name: Archive WAR file
        if: success()
        uses: actions/upload-artifact@v4
        with:
          name: dev-war
          path: target/dev.war
```

#### 2. Screenshot
- https://drive.google.com/file/d/1YyCbm9rvRNvQgzS8t9nxliirPP9IJGJA/view?usp=sharing

#### 3. Link to repository
- https://github.com/vadimN/devops-cicd 


## \*Task (90 points)
#### #### 1. CI process (ci.yml)
```yml
name: Node.js CI Pipeline

on:
  push:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Build project
        run: |
          if [ -f package.json ] && grep -q "\"build\"" package.json; then
            npm run build
          else
            echo "No build script found. Skipping..."
          fi

      - name: Run tests
        run: |
          if [ -f package.json ] && grep -q "\"test\"" package.json; then
            npm test
          else
            echo "No test script found. Skipping..."
          fi

      - name: Upload dist/ folder
        if: success()
        run: |
          if [ -d dist ]; then
            echo "Uploading dist/"
            zip -r dist.zip dist
          else
            echo "No dist/ folder found. Skipping upload."
          fi
```

#### 2. Screenshot 
- https://drive.google.com/file/d/1GNGHYcZQ_pK1TYJfR0WQsCkr1DhJ3_ax/view?usp=sharing
  
#### 3. Link to repository
https://github.com/DevOps2-Fundamentals/node-app-vadimN


## \*\*Advanced Task (100 points)
#### 1. Repository
- https://github.com/DevOps2-Fundamentals/node-app-vadimN

#### 2. Screenshot
- https://drive.google.com/file/d/18pHcMsACysc6QEceLpoPDDXrEBWq3B3w/view?usp=sharing