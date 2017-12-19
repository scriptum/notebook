from celery.schedules import crontab

# broker_url = 'pyamqp://'
broker_url = 'redis://localhost//'
# broker_url = 'redis://redis//'
result_backend = 'redis'

imports = ("mytasks", "periodic")
timezone = "Europe/Moscow"

# http://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html
beat_schedule = {
    'task-periodic1': {
        'task': 'periodic.test',
        'schedule': 10,  # every 10s
        'args': ['world']
    },
    'task-periodic2': {
        'task': 'periodic.test',
        'schedule': 20
    },
    'task-crontab': {
        'task': 'periodic.test',
        'schedule': crontab(minute=0, hour='*/3,10-19')
    }
}

# task_serializer = 'json'
# result_serializer = 'json'
# accept_content = ['json']
# enable_utc = True
# broker_pool_limit = 500
# celeryd_prefetch_multiplier = 0
# celeryd_max_tasks_per_child = 100
# celery_acks_late = False
# celery_disable_rate_limits = True
# celery_ignore_result = True
