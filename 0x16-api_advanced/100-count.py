#!/usr/bin/python3
"""
100-count.py
"""
import requests


def count_words(subreddit, word_list, after=None, counts=None):
    """
    done
    """
    if counts is None:
        counts = {word.lower(): 0 for word in word_list}
        url = f'https://www.reddit.com/r/{subreddit}/hot.json'
        headers = {"User-agent": "reddit-api-agent"}
        params = {'after': after}
        response = requests.get(
                url,
                headers=headers,
                params=params,
                allow_redirects=False
                )
        if response.status_code != 200:
            return
        data = response.json().get('data', {})
        articles = data.get('children', [])
        after = data.get('after')
        for article in articles:
            title = article['data']['title']
            title_words = title.split()
            for word in title_words:
                normalized_word = ''.join(filter(str.isalnum, word.lower()))
                if normalized_word in counts:
                    counts[normalized_word] += 1
        if after:
            return count_words(subreddit, word_list, after, counts)
        sorted_counts = {k: v for k, v in counts.items() if v > 0}
        for word, count in sorted(
                sorted_counts.items(),
                key=lambda item: (-item[1], item[0])
                ):
            print(f"{word}: {count}")
