#!/usr/bin/python3
import requests
import sys
def fetch(employe_id):
    usr_url = f'https://jsonplaceholder.typicode.com/todos/{employe_id}'
    response = requests.get(usr_url)
    if response.status_code == 200:
        data = response.json()
        EMPLOYEE_NAME = data.get('name')
        NUMBER_OF_DONE_TASKS = data.get('done_task')
        total_task = data.get('total_task')
        print (f"Employee {EMPLOYEE_NAME} is done with tasks({len(NUMBER_OF_DONE_TASKS)}/{total_task}):")
        for task in NUMBER_OF_DONE_TASKS:
            print (f"\t{task['title']}")
    else:
        print("failed to retrived data")

if __name__ == "__main__":
    if len (sys.argv) != 2:
        print("ERROR NO id")
        sys.exit(1)
    employe_id = sys.argv[1]
    fetch(employe_id)       
