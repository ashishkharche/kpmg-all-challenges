#!/usr/bin/env python3

import json
import argparse


def get_object(key, pattern):
    print(f"key: {key}")
    print(f"pattern: {pattern}")

    queries = key.split("/")
    pattern = json.loads(pattern)
    for key in queries:
        pattern = pattern[key]
    return pattern


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-k', '--key', metavar='key', default='a/b/c', help='key to execute')
    parser.add_argument('-o', '--object', metavar='object', default='{"x": {"y": {"z": "1"}}}',
                        help='object to key')
    return vars(parser.parse_args())


def launch():
    arguments = parse_arguments()
    output = get_object(arguments["key"], arguments["object"])
    print("output is:", str(output))


if __name__ == '__main__':
    launch()
