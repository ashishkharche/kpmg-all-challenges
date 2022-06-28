#!/usr/bin/env python3

import json
import argparse


def get_object(value, pattern):
    print(f"value: {value}")
    print(f"pattern: {pattern}")

    queries = value.split("/")
    pattern = json.loads(pattern)
    for key in queries:
        pattern = pattern[key]
    return pattern


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', '--value', metavar='value', default='a/b/c', help='value to execute')
    parser.add_argument('-o', '--object', metavar='object', default='{"x": {"y": {"z": "1"}}}',
                        help='object to value')
    return vars(parser.parse_args())


def launch():
    arguments = parse_arguments()
    output = get_object(arguments["value"], arguments["object"])
    print("output is:", str(output))


if __name__ == '__main__':
    launch()
