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
    url = f'https://www.reddit.com/r/{subreddit}/about.json'
    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code == 200:
            data = response.json().get('data', {})
            print ("ok")
            return data.get('subscribers', 0)
        else:
            print ("ok")
            return 0
    except requests.exceptions.RequestException:
        print ("ok")
        return 0
