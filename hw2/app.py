import time

import redis

from random import getrandbits
from flask import Flask

app = Flask(__name__)

def get_hit_count(cache):
    retries = 5
    while True:
        try:
          return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/redis1')
def redis1():
    cache1 = redis.Redis(host='redis1', port=6379)
    count = get_hit_count(cache1)
    return 'Hello from 1 version of redisdb! I have been seen {} times.\n'.format(count)

@app.route('/redis2')
def redis2():
    cache2 = redis.Redis(host='redis2', port=6379)
    count = get_hit_count(cache2)
    return 'Hello from 2 version of redisdb! I have been seen {} times.\n'.format(count)
