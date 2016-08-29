# [Model Field](https://docs.djangoproject.com/en/1.10/ref/models/fields/)

## Types

- AutoField
- BigAutoField
- BigIntegerField
- BinaryField
- BooleanField
- CharField
  - .max_length
- CommaSeparatedIntegerField
  - .max_length
- DateField
- DateTimeField
- DecimalField
  - .max_digits
  - .decimal_places
- DurationField
- EmailField
- FileField
- FilePathField
  - .path
  - .match
  - .recursive
  - .allow_files
  - .allow_folders
- FloatField
- ImageField
- IntegerField
- GenericIPAddressField
- NullBooleanField
- PositiveIntegerField
- PositiveSmallIntegerField
- SlugField
  - .max_length
  - .allow_unicode
- SmallIntegerField
- TextField
- TimeField
- URLField
- UUIDField

## Relationship fields

- ForeignKey
```
class Car(models.Model):
    manufacturer = models.ForeignKey(
        'Manufacturer',
        on_delete=models.CASCADE,
    )
```

- ManyToManyField

```
class Person(models.Model):
    friends = models.ManyToManyField("self")
```

```
from django.db import models

class Person(models.Model):
    name = models.CharField(max_length=50)

class Group(models.Model):
    name = models.CharField(max_length=128)
    members = models.ManyToManyField(
        Person,
        through='Membership',
        through_fields=('group', 'person'),
    )

class Membership(models.Model):
    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    inviter = models.ForeignKey(
        Person,
        on_delete=models.CASCADE,
        related_name="membership_invites",
    )
    invite_reason = models.CharField(max_length=64)
```
- OneToOneField

```
from django.conf import settings
from django.db import models

class MySpecialUser(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )
    supervisor = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='supervisor_of',
    )
```