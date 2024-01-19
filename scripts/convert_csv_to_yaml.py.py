import csv
import yaml
import os

# Specify the input CSV file path (provided as an environment variable by GitHub Actions)
input_csv_file = os.getenv('INPUT_CSV_FILE', 'input.csv')

# Specify the output YAML file path
output_yaml_file = './terraform/vars/temp/output.yaml'

data = {}

with open(input_csv_file, mode='r') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        if len(row) == 2:
            key, value = row
            keys = key.split('.')
            current_dict = data
            for k in keys[:-1]:
                if k not in current_dict:
                    current_dict[k] = {}
                current_dict = current_dict[k]
            current_dict[keys[-1]] = value

with open(output_yaml_file, 'w') as yaml_file:
    yaml.dump(data, yaml_file, default_flow_style=False)
