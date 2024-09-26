#!/usr/bin/python3
"""
0-subs.py
"""
import requests


def top_ten(subreddit):
    """Queries the Reddit API and prints the titles of
    the first 10 hot posts for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit to query.

    Returns:
        None: Prints None if the subreddit is invalid.
    """
    headers = {'User-Agent': 'my-reddit-top-ten/0.1'}
    url = f'https://www.reddit.com/r/{subreddit}/hot.json?limit=10'
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        posts = response.json().get('data', {}).get('children', [])
        for post in posts:
            print(post['data']['title'])
    else:
        print(None)
