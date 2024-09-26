#!/usr/bin/python3
"""
Reddit API: subscriber counter
"""
import requests


def number_of_subscribers(subreddit):
    """
    for record
    """
    headers = {'User-Agent': 'Mozilla/5.0'}
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        subscribers = data['data']['subscribers']
        return subscribers
    else:
        return 0
