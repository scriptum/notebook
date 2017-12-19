from __future__ import print_function
from celery.decorators import task

# http://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html


@task
def test(s=""):
    print("Hello", s)
