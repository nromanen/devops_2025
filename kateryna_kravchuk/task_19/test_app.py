import pytest
from db import db
from app import app, ProductModel, create_product, get_product_by_id

@pytest.fixture
def client():
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    with app.test_client() as client:
        yield client

@pytest.fixture
def setup_db():
    db.create_tables([ProductModel])
    create_product(name="Pineapple", price=40)
    create_product(name="Banana", price=12)
    yield

def test_get_products(client, setup_db):
    """ GET /api/products """
    response = client.get('/api/products')
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) > 0 

def test_post_product(client):
    """ POST /api/products """
    new_product = {
        "name": "Avocado",
        "price": 58
    }
    response = client.post('/api/products', json=new_product)
    assert response.status_code == 201
    data = response.get_json()
    assert data["message"] == "Product added successfully."
    assert "productId" in data

def test_get_product_by_id(client, setup_db):
    """ GET /api/products/{product_id} """
    product = get_product_by_id(1)
    response = client.get(f'/api/products/{product.id}')
    assert response.status_code == 200
    data = response.get_json()
    assert data["name"] == "Pineapple"
    assert data["price"] == 40

def test_get_product_not_found(client):
    """ GET /api/products/{product_id} when product is not found"""
    response = client.get('/api/products/9999')
    assert response.status_code == 404
    data = response.get_json()
    assert data["error"] == "Product not found."

def test_patch_product(client, setup_db):
    """ PATCH /api/products/{product_id} """
    product = get_product_by_id(1)
    updated_data = {
        "name": "Pineapple Gold",
        "price": 70
    }
    response = client.patch(f'/api/products/{product.id}', json=updated_data)
    assert response.status_code == 200
    data = response.get_json()
    assert data["message"] == "Product updated successfully."
    # Verify the update was successful
    updated_product = get_product_by_id(1)
    assert updated_product.name == "Pineapple Gold"
    assert updated_product.price == 70

def test_patch_product_not_found(client):
    """ PATCH /api/products/{product_id} when product is not found"""
    response = client.patch('/api/products/9999', json={"price": 0})
    assert response.status_code == 404
    data = response.get_json()
    assert data["error"] == "Product not found."

def test_delete_product(client, setup_db):
    """ DELETE /api/products/{product_id} """
    product = get_product_by_id(1)
    response = client.delete(f'/api/products/{product.id}')
    assert response.status_code == 200
    data = response.get_json()
    assert data["message"] == "Product deleted."
    # Verify that the product is deleted
    deleted_product = get_product_by_id(1)
    assert deleted_product is None

def test_delete_product_not_found(client):
    """ DELETE /api/products/{product_id} when product is not found"""
    response = client.delete('/api/products/9999')
    assert response.status_code == 404
    data = response.get_json()
    assert data["error"] == "Product not found."
