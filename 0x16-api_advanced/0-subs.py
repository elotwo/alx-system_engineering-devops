#!/usr/bin/python3
"""
Reddit API: subscriber counter
"""
import requests


def number_of_subscribers(subreddit):
    """
    for record
    """
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {
            "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/bdov_)"
            }
    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        response.raise_for_status()
        results = response.json().get("data")
        if results:
            return results.get("subscribers", 0)
        else:
            return 0
    except requests.exceptions.HTTPError as http_err:
        print(f"HTTP error occurred: {http_err}")
        return 0
    except requests.exceptions.RequestException as req_err:
        print(f"Error occurred: {req_err}")
        return 0
