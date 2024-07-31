#!/usr/bin/python3
import requests
import sys
def fetch(employee_id):
    usr_url = f'https://jsonplaceholder.typicode.com/users/{employee_id}'
    response = requests.get(usr_url)
    if response.status_code == 200:
        data = response.json()
        EMPLOYEE_NAME = data.get('userid')
        NUMBER_OF_DONE_TASKS = [task for task in data if task.get('completed')]
        total_task = len(data)
        print (f"Employee {EMPLOYEE_NAME} is done with tasks({len(NUMBER_OF_DONE_TASKS)}/{total_task}):")
        for task in NUMBER_OF_DONE_TASKS:
            print (f"\t{task.get('title')}")
    else:
        print("failed to retrived data")

if __name__ == "__main__":
    if len (sys.argv) != 2:
        print("ERROR NO id")
        sys.exit(1)
    employee_id = sys.argv[1]
fetch(employee_id)       
