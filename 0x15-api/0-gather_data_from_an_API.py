#!/usr/bin/python3
"""
this script is about retriving data from API end point
"""
import requests
import sys


def fetch(employee_id):
    user_url = f'https://jsonplaceholder.typicode.com/users/{employee_id}'
    user_response = requests.get(user_url)

    if user_response.status_code != 200:
        print("Failed to retrieve user data")
        sys.exit(1)

    user_data = user_response.json()
    employee_name = user_data.get('name')
    todos_url =
    f'https://jsonplaceholder.typicode.com/users/{employee_id}/todos'
    todos_response = requests.get(todos_url)

    if todos_response.status_code != 200:
        print("Failed to retrieve TODO data")
        sys.exit(1)

    todos = todos_response.json()
    total_tasks = len(todos) if todos else 0
    done_tasks = [todo for todo in todos if todo.get('completed')]
    print(
            f"Employee {employee_name} is done with tasks("
            f"{len(done_tasks)}/{total_tasks}):"
    )
    for task in done_tasks:
        print(f"\t {task.get('title')}")


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
