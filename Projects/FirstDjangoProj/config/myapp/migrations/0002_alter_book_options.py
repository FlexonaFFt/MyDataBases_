# Generated by Django 5.0.6 on 2024-06-19 09:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='book',
            options={'ordering': ['-id'], 'verbose_name': 'Книга', 'verbose_name_plural': 'Книги'},
        ),
    ]