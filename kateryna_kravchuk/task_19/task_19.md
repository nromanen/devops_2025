# Task 19: CI/CD Github_Actions

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

---

## Task

### Fork

Create fork the github repository of **Python**: [repo](https://classroom.github.com/a/ClefINO7).  

### CI

Use Git Action to implement a continuous integration process with the following steps.  

#### Set the trigger on the push event

```yml
on:
  push:
```

#### Add the ability to run the script in manual mode

```yml
on:
  workflow_dispatch:  
```

#### Select an operating system

```yml
runs-on: ubuntu-latest
```

#### Install the software

```yml
- name: Setup Python
  uses: actions/setup-python@v5.5.0
  with:
    python-version: '3.12'
```

> Here and in the following steps, *output* will ge gathered from the finished pipeline, just splitted into steps, which were currently described.  

**Output:**  

```txt
Run actions/setup-python@v5.5.0
  with:
    python-version: 3.12
    check-latest: false
    token: ***
    update-environment: true
    allow-prereleases: false
    freethreaded: false
Installed versions
  Successfully set up CPython (3.12.9)
```

#### Clone the project

```yml
- name: Checkout this repo
  uses: actions/checkout@v4
- name: Verify contents
  run: ls -la
```

**Output:**  

```txt
Run actions/checkout@v4
Syncing repository: DevOps2-Fundamentals/python-app-Lians-coder
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/cbfaa7a2-897f-4f55-ad13-8e1070645429' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/python-app-Lians-coder/python-app-Lians-coder
Deleting the contents of '/home/runner/work/python-app-Lians-coder/python-app-Lians-coder'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
/usr/bin/git log -1 --format=%H
7683241aa2d572f01c94b26c6a95dcd66c1f85b7

Run ls -la
  ls -la
  shell: /usr/bin/bash -e {0}
total 36
drwxr-xr-x 4 runner docker 4096 Mar 30 15:44 .
drwxr-xr-x 3 runner docker 4096 Mar 30 15:44 ..
drwxr-xr-x 7 runner docker 4096 Mar 30 15:44 .git
drwxr-xr-x 3 runner docker 4096 Mar 30 15:44 .github
-rw-r--r-- 1 runner docker 1834 Mar 30 15:44 .gitignore
-rw-r--r-- 1 runner docker 2483 Mar 30 15:44 README.md
-rw-r--r-- 1 runner docker 3057 Mar 30 15:44 app.py
-rw-r--r-- 1 runner docker 2280 Mar 30 15:44 db.py
-rw-r--r-- 1 runner docker  221 Mar 30 15:44 requirements.txt
```

#### Download dependencies

```yml
- name: Install dependencies
  run: |
    python -m pip install --upgrade pip
    pip install -r requirements.txt
```

**Output:**  

```txt
Run python -m pip install --upgrade pip
  python -m pip install --upgrade pip
  pip install -r requirements.txt
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
Requirement already satisfied: pip in /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages (25.0.1)
Collecting aniso8601==9.0.1 (from -r requirements.txt (line 1))
  Downloading aniso8601-9.0.1-py2.py3-none-any.whl.metadata (23 kB)
Collecting click==8.1.3 (from -r requirements.txt (line 2))
  Downloading click-8.1.3-py3-none-any.whl.metadata (3.2 kB)
Collecting colorama==0.4.6 (from -r requirements.txt (line 3))
  Downloading colorama-0.4.6-py2.py3-none-any.whl.metadata (17 kB)
Collecting Flask==2.2.3 (from -r requirements.txt (line 4))
  Downloading Flask-2.2.3-py3-none-any.whl.metadata (3.9 kB)
Collecting Flask-Cors==3.0.10 (from -r requirements.txt (line 5))
  Downloading Flask_Cors-3.0.10-py2.py3-none-any.whl.metadata (5.4 kB)
Collecting Flask-RESTful==0.3.9 (from -r requirements.txt (line 6))
  Downloading Flask_RESTful-0.3.9-py2.py3-none-any.whl.metadata (912 bytes)
Collecting itsdangerous==2.1.2 (from -r requirements.txt (line 7))
  Downloading itsdangerous-2.1.2-py3-none-any.whl.metadata (2.9 kB)
Collecting Jinja2==3.1.2 (from -r requirements.txt (line 8))
  Downloading Jinja2-3.1.2-py3-none-any.whl.metadata (3.5 kB)
Collecting MarkupSafe==2.1.2 (from -r requirements.txt (line 9))
  Downloading MarkupSafe-2.1.2.tar.gz (19 kB)
  Installing build dependencies: started
  Installing build dependencies: finished with status 'done'
  Getting requirements to build wheel: started
  Getting requirements to build wheel: finished with status 'done'
  Preparing metadata (pyproject.toml): started
  Preparing metadata (pyproject.toml): finished with status 'done'
Collecting peewee==3.16.1 (from -r requirements.txt (line 10))
  Downloading peewee-3.16.1.tar.gz (868 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 869.0/869.0 kB 78.0 MB/s eta 0:00:00
  Installing build dependencies: started
  Installing build dependencies: finished with status 'done'
  Getting requirements to build wheel: started
  Getting requirements to build wheel: finished with status 'done'
  Preparing metadata (pyproject.toml): started
  Preparing metadata (pyproject.toml): finished with status 'done'
Collecting pytz==2023.3 (from -r requirements.txt (line 11))
  Downloading pytz-2023.3-py2.py3-none-any.whl.metadata (22 kB)
Collecting six==1.16.0 (from -r requirements.txt (line 12))
  Downloading six-1.16.0-py2.py3-none-any.whl.metadata (1.8 kB)
Collecting Werkzeug==2.2.3 (from -r requirements.txt (line 13))
  Downloading Werkzeug-2.2.3-py3-none-any.whl.metadata (4.4 kB)
Collecting pytest==8.3.5 (from -r requirements.txt (line 14))
  Downloading pytest-8.3.5-py3-none-any.whl.metadata (7.6 kB)
Collecting iniconfig (from pytest==8.3.5->-r requirements.txt (line 14))
  Downloading iniconfig-2.1.0-py3-none-any.whl.metadata (2.7 kB)
Collecting packaging (from pytest==8.3.5->-r requirements.txt (line 14))
  Downloading packaging-24.2-py3-none-any.whl.metadata (3.2 kB)
Collecting pluggy<2,>=1.5 (from pytest==8.3.5->-r requirements.txt (line 14))
  Downloading pluggy-1.5.0-py3-none-any.whl.metadata (4.8 kB)
Downloading aniso8601-9.0.1-py2.py3-none-any.whl (52 kB)
Downloading click-8.1.3-py3-none-any.whl (96 kB)
Downloading colorama-0.4.6-py2.py3-none-any.whl (25 kB)
Downloading Flask-2.2.3-py3-none-any.whl (101 kB)
Downloading Flask_Cors-3.0.10-py2.py3-none-any.whl (14 kB)
Downloading Flask_RESTful-0.3.9-py2.py3-none-any.whl (25 kB)
Downloading itsdangerous-2.1.2-py3-none-any.whl (15 kB)
Downloading Jinja2-3.1.2-py3-none-any.whl (133 kB)
Downloading pytz-2023.3-py2.py3-none-any.whl (502 kB)
Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Downloading Werkzeug-2.2.3-py3-none-any.whl (233 kB)
Downloading pytest-8.3.5-py3-none-any.whl (343 kB)
Downloading pluggy-1.5.0-py3-none-any.whl (20 kB)
Downloading iniconfig-2.1.0-py3-none-any.whl (6.0 kB)
Downloading packaging-24.2-py3-none-any.whl (65 kB)
Building wheels for collected packages: MarkupSafe, peewee
  Building wheel for MarkupSafe (pyproject.toml): started
  Building wheel for MarkupSafe (pyproject.toml): finished with status 'done'
  Created wheel for MarkupSafe: filename=markupsafe-2.1.2-cp312-cp312-linux_x86_64.whl size=29001 sha256=1eb13986c2cfad7e16ac9b36bf0a783fe9a284be6c274ce3a0bc59639700d7e7
  Stored in directory: /home/runner/.cache/pip/wheels/2c/40/ee/f5dc47077cc22aa7698564d653641f839cbe388a9be7a8a8e7
  Building wheel for peewee (pyproject.toml): started
  Building wheel for peewee (pyproject.toml): finished with status 'done'
  Created wheel for peewee: filename=peewee-3.16.1-py3-none-any.whl size=135087 sha256=f1d10d3819a33529e96245fa77f122eeb9609d200a7c8d7303a010ebe7452a6e
  Stored in directory: /home/runner/.cache/pip/wheels/b3/84/8c/529bf2aa12538d2402741de43d1676dde6ff591528b6a1c502
Successfully built MarkupSafe peewee
Installing collected packages: pytz, peewee, aniso8601, six, pluggy, packaging, MarkupSafe, itsdangerous, iniconfig, colorama, click, Werkzeug, pytest, Jinja2, Flask, Flask-RESTful, Flask-Cors
Successfully installed Flask-2.2.3 Flask-Cors-3.0.10 Flask-RESTful-0.3.9 Jinja2-3.1.2 MarkupSafe-2.1.2 Werkzeug-2.2.3 aniso8601-9.0.1 click-8.1.3 colorama-0.4.6 iniconfig-2.1.0 itsdangerous-2.1.2 packaging-24.2 peewee-3.16.1 pluggy-1.5.0 pytest-8.3.5 pytz-2023.3 six-1.16.0
```

#### Create a project build

```yml
# Database
- name: Create a database
run: python db.py

- name: Verify creation
run: ls -l products.db
```

**Output:**  

```txt
Run python db.py
  python db.py
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib

Run ls -l products.db
  ls -l products.db
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
-rw-r--r-- 1 runner docker 8192 Mar 30 15:44 products.db
```

```yml
# Database setup
- name: Delete all product data
run: python db.py -d

- name: Add default product data
run: python db.py -a

- name:  Print product data to the console
run: python db.py -p
```

**Output:**  

```txt
Run python db.py -d
  python db.py -d
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib

Run python db.py -a
  python db.py -a
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib

Run python db.py -p
  python db.py -p
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
(1, Sugar, 32)
(2, Sult, 19)
(3, Bread, 20)
(4, Butter, 62)
(5, Milk, 32)
```

```yml
# API
- name: Run the API
run: python app.py --host localhost --port 5000 &

- name: Wait for start
run: sleep 5
```

> `sleep` here is for safely waiting while the *Flask app* starts.  

**Output:**

```txt
Run python app.py --host localhost --port 5000 &
  python app.py --host localhost --port 5000 &
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
localhost 5000
 * Serving Flask app 'app'
 * Debug mode: on
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://localhost:5000
Press CTRL+C to quit
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 391-355-554

Run sleep 5
  sleep 5
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
```

#### Run unit tests

##### 1. Verify by `curl`

```yml
- name: Test GET /api/products
run: |
    curl -X GET http://localhost:5000/api/products
```

**Output:**  

```txt
Run curl -X GET http://localhost:5000/api/products
  curl -X GET http://localhost:5000/api/products
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
[
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100   377  100   377    0     0   121k      0 --:--:-- --:--:-- --:--:--  184k
    {
        "id": 1,
        "name": "Sugar",
        "price": 32
    },
    {
        "id": 2,
        "name": "Sult",
        "price": 19
    },
    {
        "id": 3,
        "name": "Bread",
        "price": 20
    },
    {
        "id": 4,
        "name": "Butter",
        "price": 62
    },
    {
        "id": 5,
        "name": "Milk",
        "price": 32
    }
]
```

```yml
- name: Test POST /api/products
run: |
    curl -X POST http://localhost:5000/api/products -H "Content-Type: application/json" -d '{"name": "Avocado", "price": 58}'   
```

**Output:**  

```txt
Run curl -X POST http://localhost:5000/api/products -H "Content-Type: application/json" -d '{"name": "Avocado", "price": 58}'   
  curl -X POST http://localhost:5000/api/products -H "Content-Type: application/json" -d '{"name": "Avocado", "price": 58}'   
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
{
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100   101  100    69  100    32  13284   6160 --:--:-- --:--:-- --:--:-- 20200
    "message": "Product added successfully.",
    "productId": 6
}
```

```yml
- name: Test GET /api/products/{product_id}
run: |
    curl -X GET http://localhost:5000/api/products/3
```

**Output:**  

```txt
Run curl -X GET http://localhost:5000/api/products/3
  curl -X GET http://localhost:5000/api/products/3
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
{
    "id": 3,
    "name": "Bread",
    "price": 20
}
100    54  100    54    0     0  19155      0 --:--:-- --:--:-- --:--:-- 27000
```

```yml
- name: Test PATCH /api/products/{product_id}
run: |
    curl -X PATCH http://localhost:5000/api/products/5 -H "Content-Type: application/json" -d '{"price": 67}'
```

**Output:**  

```txt
Run curl -X PATCH http://localhost:5000/api/products/5 -H "Content-Type: application/json" -d '{"price": 67}'
  curl -X PATCH http://localhost:5000/api/products/5 -H "Content-Type: application/json" -d '{"price": 67}'
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100    64  100    51  100    13  11489   2928 --:--:-- --:--:-- --:--:-- 16000
{
    "message": "Product updated successfully."
}
```

```yml
- name: Test DELETE /api/products/{product_id}
run: |
    curl -X DELETE http://localhost:5000/api/products/1
```

**Output:**  

```txt
Run curl -X DELETE http://localhost:5000/api/products/1
  curl -X DELETE http://localhost:5000/api/products/1
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100    38  100    38    0     0   7568      0 --:--:-- --:--:-- --:--:--  9500
{
    "message": "Product deleted."
}
```

##### 2. Verify by actual unit tests

To start clear:  

```yml
- name: Reset database
  run: python db.py -d
```

**Output:**  

```txt
Run python db.py -d
  python db.py -d
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
```

```yml
- name: Run unit tests
  run: pytest test_app.py
```

> [Here](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_19/Vtest_app.py) is the tests file I wrote for this step.  
> [Vagrantfile](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_19/Vagrantfile) for simulate `ubuntu-latest` runner for testing unit tests:)  

**Output:**  

```txt
Run pytest test_app.py
  pytest test_app.py
  shell: /usr/bin/bash -e {0}
  env:
    pythonLocation: /opt/hostedtoolcache/Python/3.12.9/x64
    PKG_CONFIG_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib/pkgconfig
    Python_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python2_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    Python3_ROOT_DIR: /opt/hostedtoolcache/Python/3.12.9/x64
    LD_LIBRARY_PATH: /opt/hostedtoolcache/Python/3.12.9/x64/lib
============================= test session starts ==============================
platform linux -- Python 3.12.9, pytest-8.3.5, pluggy-1.5.0
rootdir: /home/runner/work/python-app-Lians-coder/python-app-Lians-coder
collected 8 items

test_app.py ........                                                     [100%]

=============================== warnings summary ===============================
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/peewee.py:245
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/peewee.py:245: DeprecationWarning: "db_table" has been deprecated in favor of "table_name" for Models.
    warnings.warn(s, DeprecationWarning)

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/pytz/tzinfo.py:27
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/pytz/tzinfo.py:27: DeprecationWarning: datetime.datetime.utcfromtimestamp() is deprecated and scheduled for removal in a future version. Use timezone-aware objects to represent datetimes in UTC: datetime.datetime.fromtimestamp(timestamp, datetime.UTC).
    _epoch = datetime.utcfromtimestamp(0)

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:751: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
    parts = parts or [ast.Str("")]

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:748: 24 warnings
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:748: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
    _convert(elem) if is_dynamic else ast.Str(s=elem)

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/ast.py:587: 24 warnings
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/ast.py:587: DeprecationWarning: Attribute s is deprecated and will be removed in Python 3.14; use value instead
    return Constant(*args, **kwargs)

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:755: 40 warnings
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:755: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
    if isinstance(p, ast.Str) and isinstance(ret[-1], ast.Str):

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:756: 36 warnings
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:756: DeprecationWarning: Attribute s is deprecated and will be removed in Python 3.14; use value instead
    ret[-1] = ast.Str(ret[-1].s + p.s)

../../../../../opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:756: 18 warnings
  /opt/hostedtoolcache/Python/3.12.9/x64/lib/python3.12/site-packages/werkzeug/routing/rules.py:756: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
    ret[-1] = ast.Str(ret[-1].s + p.s)

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
======================= 8 passed, 151 warnings in 0.25s ========================
```

#### Verify the script is triggered to be executed by updating the project code in the repository

Add the following to the script, then make a pull request.  

```yml
on:
  pull_request:
    types: [opened, synchronize]
```

#### Add a link to the created workflow

[.yml](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_19/flask.yml) file in [this repo](https://github.com/nromanen/devops_2025) (because [where it was](https://github.com/DevOps2-Fundamentals/python-app-Lians-coder) tested and verifyed is a *private* fork).  
**All** [**screenshots**](https://drive.google.com/drive/folders/1fBkJtS-F7wpYOgE-DFhDE2W8qNeRuMl7?usp=drive_link) of the work done.  

---

## Advanced Task

### Add a trigger on the pull request event with types opened and synchronize

```yml
on:
  pull_request:
    types: [opened, synchronize]
```

### Update project code in a new branch

Change something in the code, then proceed.  

```sh
git checkout -b side
git add .github/workflows/flask.yml
git commit -m "Updated .yml"
git push origin side
```

### Create and accept a pull request

Do it from GtHub and see how the workflow automatically triggers.  

Trigger [on PR](https://drive.google.com/file/d/1yQtluqu-VyCO15tCt41FLH5t_7aLUrqu/view?usp=drive_link)  

---

## Results

[All of screenshots](https://drive.google.com/drive/folders/1fBkJtS-F7wpYOgE-DFhDE2W8qNeRuMl7?usp=drive_link) for the output of the executed script.  
