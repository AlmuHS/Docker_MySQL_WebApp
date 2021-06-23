from flask import Flask, render_template, redirect
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

import mysql.connector 
import os

SECRET_KEY='5f352379324c22463451387a0aec5d2f'

app = Flask(__name__)
app.secret_key = SECRET_KEY

mydb = mysql.connector.connect(
  host=os.environ['MYSQL_HOST'],
  user="testusr",
  password="test",
  database="testDB"
)

class QueryForm(FlaskForm):
    username = StringField('Nombre de Usuario', validators=[DataRequired()])
    submit_buy = SubmitField('Consultar compras')
    submit_user = SubmitField('Consultar usuarios')

def add_headers(cursor):
        data = []
        headers = tuple([header[0] for header in cursor.description])
        data.insert(0, headers)
        results = [row for row in cursor.fetchall()]
        data = data + results
        
        return data

@app.route("/", methods=['GET', 'POST'])
def main():
        form = QueryForm()
        cursor = mydb.cursor()
        
        if form.submit_buy.data:
                if form.validate_on_submit():
                        query_buy = f"select PRODUCTOS.modelo, PRODUCTOS.descripcion, PRODUCTOS.precio, COMPRAS.num_unidades \
                                  from COMPRAS \
                                  inner join CLIENTES on(CLIENTES.id = COMPRAS.id_usuario) \
                                  inner join PRODUCTOS on(COMPRAS.id_producto = PRODUCTOS.id) \
                                  where usuario = \'{form.username.data}\'"
                        cursor.execute(query_buy)
                        
                        data = add_headers(cursor)
                
                        return render_template("dashboard.html", data=data)
          
        elif form.submit_user.data:
                query_users = "select usuario, nombre, apellidos from CLIENTES"
                cursor.execute(query_users)
          
                data = add_headers(cursor)

                return render_template("dashboard.html", data=data)
        
        return render_template('query.html', title='Consulta compras', form=form)
        
if __name__ == "__main__":
        #app.run(host='0.0.0.0', port=80)
        app.run(host='0.0.0.0', port=5000)

