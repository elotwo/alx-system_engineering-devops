#!/usr/bin/python3
"""
this script is about retriving data from API end point
"""
import csv
import requests
import sys


def fetch(employee_id):
    user_url = f'https://jsonplaceholder.typicode.com/users/{employee_id}'
    user_response = requests.get(user_url)

    if user_response.status_code != 200:
        print("Failed to retrieve user data")
        sys.exit(1)

    user_data = user_response.json()
    user_id = user_data.get('id')
    username = user_data.get('username')
    todos_url = f'https://jsonplaceholder.typicode.com/users/'
    f'{employee_id}/todos'
    todos_response = requests.get(todos_url)

    if todos_response.status_code != 200:
        print("Failed to retrieve TODO data")
        sys.exit(1)

    todos = todos_response.json()
    csv_filename = f'{user_id}.csv'
    with open('USER_ID.csv', 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)

        for todo in todos:
            task_completed_status = todo.get('completed')
            task_title = todo.get('title')
            writer.writerow([
                user_id,
                username,
                str(task_completed_status),
                task_title
            ])

    print(f"Data successfully written to {csv_filename}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 script.py <employee_id>")
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
    except ValueError:
        print("Employee ID must be an integer.")
        sys.exit(1)

    fetch(employee_id)
