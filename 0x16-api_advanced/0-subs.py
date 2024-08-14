import requests
import sys


def number_of_subscribers(subreddit):
    if not (isinstance(subreddit, str) or subreddit.startswitch('/r/')):
        return 0
    else:
       user_url = f'https://www.reddit.com/r/{subreddit}/about.json'
       headers = {'User-Agent': 'python:subscriber_count:v1.0'}
       user_response = requests.get(user_url)
    if user_response.status_code == 302:
       return 0
    elif user_response.status_code != 200:
        print ("failled")
        sys.exit()
        data = response.json()
        subscriber_count = data['data']['subscribers']
        for x in subscriber_count:
            return x
