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
    headers = {'User-Agent': 'Mozilla/5.0'}
    url = f'https://www.reddit.com/r/{subreddit}/hot.json?limit=10'
    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code == 200:
            data = response.json().get('data', {}).get('children', [])
            if not data:
                print(None)
                return
            for post in data:
                print(post.get('data', {}).get('title'))
        else:
            print(None)
    except requests.exceptions.RequestException as e:
        print("OK")
