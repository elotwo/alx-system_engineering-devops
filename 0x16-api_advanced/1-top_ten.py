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
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
            "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/bdov_)"
            }
    params = {
            "limit": 10
            }
    response = requests.get(
            url,
            headers=headers,
            params=params,
            allow_redirects=False)
    if response.status_code == 404:
        print("None")
        return
    results = response.json().get("data")
    [print(c.get("data").get("title")) for c in results.get("children")]
