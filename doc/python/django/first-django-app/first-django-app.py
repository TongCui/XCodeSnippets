# [Writing your first Django app](https://docs.djangoproject.com/en/1.10/intro/tutorial01/)

source ~/myenv/bin/active

python -c "print('hello')"
python -m django --version # 1.9.4

python --version # Python 3.5.1
django --version # 1.9.4
python -m django --version

# Creating a project
django-admin startproject mysite

python manage.py runserver 8000
python manage.py runserver 0.0.0.0:8000

# Creating the Polls app
python manage.py startapp polls

# First View
def index(request):
  return HttpResponse("Hello, world")

# Some of there applications make use of at least one database 
python manage.py migrate

# Models
class Question(models.Model):
  question_text = models.CharField(max_length=200)
  pub_date = models.DateTimeField('date published')

# INSTALLED_APPS
 The PollsConfig class is in the polls/apps.py file, so its dotted path is 'polls.apps.PollsConfig'

 'polls.apps.PollsConfig'

# make migrations
python manage.py makemigrations polls

# sql migrate
python manage.py sqlmigrate polls 0001

# check
python manage.py check

# migrate
python manage.py migrate

# shell
python manage.py shell

>>> Question.objects.all()
>>> q = Question(question_text="What's new?", pub_date=timezone.now())
# Save the object into the database. You have to call save() explicitly.
>>> q.save()

>>> Question.objects.get(pk=1)
>>> q = Question.objects.get(id=1)
>>> c = q.choice_set.filter(choice_text__startswith='Just hacking')
>>> c.delete()

# creating an admin user

python manage.py createsuperuser


# edit
# polls/admin.py

admin.site.register(Question)


# More views

urlpatterns = [
  url(r'^$', views.index, name='index'),
  url(r'^(?P<question_id>[0-9]+)/$', views.detail, name='detail'),
  url(r'^(?P<question_id>[0-9]+)/results/$', views.results, name='results'),
  url(r'^(?P<question_id>[0-9]+)/vote/$', views.vote, name='vote'),
]

def index(request):
  latest_question_list = Question.objects.order_by('-pub_date')[:5]
  return render(request, 'polls/index.html', {'latest_question_list':latest_question_list})

# Raising a 404 error

# url
# polls/urls.py
app_name = 'polls'

<li><a href="{% url 'polls:detail' question.id %}">{{ question.question_text }}

# Use generic views: Less code is better


urlpatterns = [
  url(r'^$', views.IndexView.as_view(), name='index'),
  url(r'^(?P<pk>[0-9]+)/$', views.DetailView.as_view(), name='detail'),
  url(r'^(?P<pk>[0-9]+)/results/$', views.ResultsView.as_view(), name='results'),
  url(r'^(?P<question_id>[0-9]+)/vote/$', views.vote, name='vote'),
]


class IndexView(generic.ListView):
  template_name = 'polls/index.html'
  context_object_name = 'latest_question_list'

  def get_queryset(self):
    """Return the last five published questions."""
    return Question.objects.order_by('-pub_date')[:5]


class DetailView(generic.DetailView):
  model = Question
  template_name = 'polls/detail.html'


class ResultsView(generic.DetailView):
  model = Question
  template_name = 'polls/results.html'

# Test

python manage.py test polls

# CSS
# polls/static/polls/style.css

{% load static %}
<link rel="stylesheet" type="text/css" href="{% static 'polls/style.css' %}" />

# Images
# polls/static/polls/images/xxx.xx







