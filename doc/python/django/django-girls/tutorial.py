# [First Django Project](https://tutorial.djangogirls.org/en/django_start_project/)

# Create project
django-admin startproject mysite .

# Change Settings

TIME_ZONE = 'Europe/Berlin'

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

# migrate

python manage.py migrate

# runserver

python manage.py runserver

# start app

python manage.py startapp blog

# Settings

INSTALLED_APPS + 'blog',


# Create a blog post model

from django.db import models
from django.utils import timezone


class Post(models.Model):
  author = models.ForeignKey('auth.User')
  title = models.CharField(max_length=200)
  text = models.TextField()
  created_date = models.DateTimeField(
          default=timezone.now)
  published_date = models.DateTimeField(
          blank=True, null=True)

  def publish(self):
    self.published_date = timezone.now()
    self.save()

  def __str__(self):
    return self.title

# Make migrations
python manage.py makemigrations blog

# migrate
python manage.py migrate blog

# admin
from .models import Post

admin.site.register(Post)

# create super user

python manage.py createsuperuser

# URL

url(r'', include('blog.urls')),

# Create Object

python manage.py shell

from django.contrib.auth.models import User
User.objects.all()

me = User.objects.get(username='tcui')

Post.objects.create(author = me, title = "Sample title", text = "Test")

Post.objects.filter(author=me)

Post.objects.filter(title__contains='title')

from django.utils import timezone

Post.objects.filter(published_date__lte=timezone.now())

Post.objects.order_by('created_date')

# Chaining QuerySets

Post.objects.filter(published_date__lte=timezone.now()).order_by('published_date')

# base.html
<body>
    <div class="page-header">
        <h1><a href="/">Django Girls Blog</a></h1>
    </div>
    <div class="content container">
        <div class="row">
            <div class="col-md-8">
            {% block content %}
            {% endblock %}
            </div>
        </div>
    </div>
</body>

# post_list.html

{% extends 'blog/base.html' %}

{% block content %}
    {% for post in posts %}
        <div class="post">
            <div class="date">
                {{ post.published_date }}
            </div>
            <h1><a href="">{{ post.title }}</a></h1>
            <p>{{ post.text|linebreaksbr }}</p>
        </div>
    {% endfor %}
{% endblock %}

# Django Forms
# blog/forms.py

from django import forms
from .models import Post

def post_new(request):
  if request.method == "POST":
    form = PostForm(request.POST)
    if form.is_valid():
      post = form.save(commit=False)
      post.author = request.user
      post.published_date = timezone.now()
      post.save()
      return redirect('post_detail', pk=post.pk)
  else:
    form = PostForm()
  return render(request, 'blog/post_edit.html', {'form': form})

# Form validation

# Security
{% if user.is_authenticated %}
    <a href="{% url 'post_new' %}" class="top-menu"><span class="glyphicon glyphicon-plus"></span></a>
{% endif %}



