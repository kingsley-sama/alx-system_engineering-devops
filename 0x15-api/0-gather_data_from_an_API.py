#!/usr/bin/python3
"""This module fetches from the employee db"""
import json
from sys import argv
from urllib import error, request, response

r = request


def get_employee_detail(employee_id=0):
    """this module fetches employee data from and api"""

    try:
        URL = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
        with r.urlopen(URL) as result:
            user_data = json.load(result)
            _id = user_data['id']
            EMPLOYEE_NAME = user_data['name']
        with r.urlopen(f"https://jsonplaceholder.typicode.com/todos/") as todo:
            todo_data = json.load(todo)
            TOTAL_NUMBER_OF_TASKS = len(todo_data)
            NUMBER_OF_DONE_TASKS = sum(1 for task in
                                       todo_data if task['completed'])
            string = (
                f"Employee {EMPLOYEE_NAME} is done with tasks "
                f"({NUMBER_OF_DONE_TASKS} / {TOTAL_NUMBER_OF_TASKS}):"
            )
            print(string)
        for task in todo_data:
            if task['completed'] is True:
                print(f"\t {task['title']}")
    except (error):
        return


if __name__ == '__main__':
    if len(argv) > 0:
        get_employee_detail(argv[1])
