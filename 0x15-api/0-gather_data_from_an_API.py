#!/usr/bin/python3
"""
this script is about retriving data from API end point
"""
import sys
import requests


def fetch(employee_id):
    user_url = f'https://jsonplaceholder.typicode.com/users/{employee_id}'
    user_response = requests.get(user_url)

    if user_response.status_code != 200:
        print("Failed to retrieve user data")
        sys.exit(1)

    user_data = user_response.json()
    EMPLOYEE_NAME = user_data.get('name')
    todos_url =
    f'https://jsonplaceholder.typicode.com/users/{employee_id}/todos'
    todos_response = requests.get(todos_url)

    if todos_response.status_code != 200:
        print("Failed to retrieve TODO data")
        sys.exit(1)

    todos = todos_response.json()
    TOTAL_NUMBER_OF_TASKS = len(todos) if todos else 0
    NUMBER_OF_DONE_TASKS = [todo for todo in todos if todo.get('completed')]
    print(
            f"Employee {EMPLOYEE_NAME} is done with tasks("
            f"{len(NUMBER_OF_DONE_TASKS)}/{TOTAL_NUMBER_OF_TASKS}):"
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
