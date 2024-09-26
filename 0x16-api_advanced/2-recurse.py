#!/usr/bin/python3
"""
Reddit API:
"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    Recursively queries the Reddit API and returns a list of titles of all hot
    articles for a given subreddit.
    If the subreddit is invalid or no articles are found, return None
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-agent": "reddit-api-agent"}
    params = {"after": after}
    response = requests.get(
            url,
            headers=headers,
            params=params,
            allow_redirects=False
            )
    if response.status_code != 200:
        return None
    data = response.json().get("data", {})
    children = data.get("children", [])
    for child in children:
        hot_list.append(child.get("data", {}).get("title"))
    after = data.get("after")
    if after:
        return recurse(subreddit, hot_list, after)
    return hot_list if hot_list else None
