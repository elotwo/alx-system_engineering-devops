#!/usr/bin/python3
import requests


def number_of_subscribers(subreddit):
    """
    for record
    """
    if subreddit is None or not isinstance(subreddit, str):
        return 0
    headers = {'User-Agent': 'my-reddit-subscriber-counter/0.1'}
    url = f'https://www.reddit.com/r/{subreddit}/about.json'
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json().get('data', {})
        return data.get('subscribers', 0)
    else:
        return 0
