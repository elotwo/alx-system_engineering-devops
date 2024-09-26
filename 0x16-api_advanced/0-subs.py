#!/usr/bin/python3
"""
Reddit API: subscriber counter
"""
import requests


def number_of_subscribers(subreddit):
    """
    for record
    """
    url = f'https://www.reddit.com/r/{subreddit}/about.json'
    headers = {"User-agent": "my-reddit-subscriber-counter/0.1"}
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json().get("data", {})
        return data.get("subscribers", 0)
        
    return 0
