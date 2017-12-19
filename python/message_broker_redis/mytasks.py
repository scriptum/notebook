from __future__ import print_function
from celery.decorators import task


@task(default_retry_delay=300, max_retries=5)
def mytask(name):
    return "Hello, {}".format(name)
