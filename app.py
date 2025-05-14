from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    products = [
        {'name': 'Silver Ring', 'price': 1500, 'image': 'https://via.placeholder.com/200?text=Ring'},
        {'name': 'Silver Necklace', 'price': 3500, 'image': 'https://via.placeholder.com/200?text=Necklace'},
        {'name': 'Silver Earrings', 'price': 1200, 'image': 'https://via.placeholder.com/200?text=Earrings'},
        {'name': 'Silver Bracelet', 'price': 2000, 'image': 'https://via.placeholder.com/200?text=Bracelet'}
    ]
    return render_template('index.html', products=products)

if __name__ == '__main__':
    app.run(debug=True)
