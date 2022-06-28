import requests
import json

aws_metadata_url = 'http://169.254.169.254/latest/'


def json_check(url, path_list):
    output = {}
    for each in path_list:
        endpoint = url + each
        k = requests.get(endpoint)
        text = k.text
        if each[-1] == "/":
            list_values = k.text.splitlines()
            output[each[:-1]] = json_check(endpoint, list_values)
        elif validate_json(text):
            output[each] = json.loads(text)
        else:
            output[each] = text
    return output

def metadata_function():
    path = ["meta-data/"]
    result = json_check(aws_metadata_url, path)
    return result

def get_json():
    metadata = metadata_function()
    get_json = json.dumps(metadata, indent=4, sort_keys=True)
    return get_json

def validate_json(value):
    try:
        json.loads(value)
    except ValueError:
        return False
    return True


if __name__ == '__main__':
    print(get_json())