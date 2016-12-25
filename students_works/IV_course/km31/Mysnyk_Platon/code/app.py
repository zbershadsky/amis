# app.py
import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import functools
import os
import time
from flask import (Flask, abort, flash, Markup, redirect, render_template,
                   request, Response, session, url_for)
from flask_sqlalchemy import SQLAlchemy

APP_DIR = os.path.dirname(os.path.realpath(__file__))
DEBUG = False
SECRET_KEY = 'shhh, secret!'  # Used by Flask to encrypt session cookie.
SQLALCHEMY_DATABASE_URI = 'oracle://platon:oracle@localhost:1521/xe'
SQLALCHEMY_TRACK_MODIFICATIONS = True
SQLALCHEMY_AUTOCOMMIT = False

app = Flask(__name__)
app.config.from_object(__name__)
db = SQLAlchemy(app)

# engine = create_engine(SQLALCHEMY_DATABASE_URI, convert_unicode=True)
# db_session = scoped_session(sessionmaker(autocommit=False,
#                                          autoflush=False,
#                                          bind=engine))


# Models
class Users(db.Model):
    email = db.Column(db.String(100), primary_key=True)
    password = db.Column(db.String(255))
    name = db.Column(db.String(100))
    type = db.Column(db.String(100))

    def __init__(self, email, password, type, name):
        self.email = email
        self.password = password
        self.type = type
        self.name = name

    def __repr__(self):
        return '<User %r %r %r %r>' % (self.email, self.password, self.name, self.type)


class Sample(db.Model):
    sample_date = db.Column(db.TIMESTAMP(), primary_key=True)
    title = db.Column(db.String(100))
    text = db.Column(db.CLOB())

    def __init__(self, title, text):
        self.title = title
        self.text = text
        self.sample_date = datetime.datetime.now()

    def __repr__(self):
        return '<Sample %r %r>' % (self.title, self.sample_date)


class Compare(db.Model):
    sample_date = db.Column(db.TIMESTAMP())
    work_date = db.Column(db.TIMESTAMP())
    compare_date = db.Column(db.TIMESTAMP(), primary_key=True)
    result = db.Column(db.Numeric())

    def __init__(self, work, sample, result):
        self.result = result
        self.work_date = work
        self.sample_date = sample
        self.compare_date = datetime.datetime.now()


class Work(db.Model):
    work_date = db.Column(db.TIMESTAMP(), primary_key=True)
    email = db.Column(db.String(100))
    text = db.Column(db.CLOB())

    def __init__(self, email, text):
        self.email = email
        self.text = text
        self.work_date = datetime.datetime.now()

    def __repr__(self):
        return '<Work %r %r>' % (self.title, self.work_date)


def login_required(fn):
    @functools.wraps(fn)
    def inner(*args, **kwargs):
        if session.get('logged_in'):
            return fn(*args, **kwargs)
        return redirect(url_for('login'))

    return inner


def is_admin(fn):
    @functools.wraps(fn)
    def inner(*args, **kwargs):

        if session.get('logged_in') and session.get('logged_in')['type'] == 'admin':
            return fn(*args, **kwargs)
        return redirect(url_for('check'))

    return inner


@app.route('/login/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST' and request.form.get('password'):

        password = request.form.get('password')
        email = request.form.get('email')

        user = db.session.query(Users).get(email)

        if user:
            if password == user.password:
                session['logged_in'] = {
                    'email': user.email,
                    'type': user.type
                }
                session.permanent = True  # Use cookie to store session.
                flash('You are now logged in.', 'success')
                return redirect('/check')
        else:
            flash('Incorrect email or password.', 'danger')
    return render_template('login.html')


@app.route('/admin', methods=['GET', 'POST'])
@login_required
@is_admin
def admin():
    users = db.session.query(Users).all()
    samples = db.session.query(Sample).all()
    return render_template('admin.html', user=session.get('logged_in'), users=users, samples=samples)


@app.route('/create-sample', methods=['POST'])
@login_required
@is_admin
def create_sample():
    if request.method == 'POST' and request.form.get('text') and request.form.get('title'):
        sample = Sample(request.form.get('title'), request.form.get('text'))
        db.session.add(sample)
        db.session.commit()
    return redirect('/admin')


@app.route('/delete-sample', methods=['GET'])
@login_required
@is_admin
def delete_sample():
    db.session.flush()
    time = request.args.get('time')
    if time:
        sample = db.session.query(Sample).get(datetime.datetime.strptime(time, "%Y-%m-%d %H:%M:%S.%f"))
        print(sample)
        if sample is not None:
            db.session.delete(sample)
            db.session.commit()
    return redirect('/admin')


@app.route('/create-user', methods=['POST'])
@login_required
@is_admin
def create_user():
    if request.method == 'POST' and request.form.get('email') and request.form.get('password') and request.form.get('name'):
        user = Users(request.form.get('email'), request.form.get('password'), 'user', request.form.get('name') or 'Noname')
        db.session.add(user)
        db.session.commit()
    return redirect('/admin')


@app.route('/delete-user', methods=['GET'])
@login_required
@is_admin
def delete_user():
    db.session.flush()
    email = request.args.get('email')
    if email:
        user = db.session.query(Users).get(email)
        if user is not None:
            db.session.delete(user)
            db.session.commit()
    return redirect('/admin')


@app.route('/logout/', methods=['GET', 'POST'])
def logout():
    session.clear()
    return redirect(url_for('login'))


@app.route('/check', methods=['GET', 'POST'])
@login_required
def check():

    if request.method == 'POST' and request.form.get('text'):
        plagiat = 0

        text = request.form.get('text')
        samples = db.session.query(Sample).all()
        for sample in samples:
            similarity = jaccard_similarity(sample.text, text)
            print(similarity)
            if similarity >= 0.5:
                plagiat = similarity
                work = Work(session['logged_in']['email'], text)
                db.session.add(work)
                db.session.commit()
                compare = Compare(work.work_date, sample.sample_date, similarity)
                db.session.add(compare)
                db.session.commit()
            break

        return render_template('check.html', user=session.get('logged_in'), plagiat=plagiat, text=text)
    return render_template('check.html', user=session.get('logged_in'))


def jaccard_similarity(doc1, doc2):
    a = set(doc1.split())
    b = set(doc2.split())
    similarity = float(len(a.intersection(b))*1.0/len(a.union(b))) #similarity belongs to [0,1] 1 means its exact replica.
    return similarity