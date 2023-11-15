import boto3
import json

def get_ami_info(ec2, ami_id):
    try:
        response = ec2.describe_images(ImageIds=[ami_id])
        if response['Images']:
            image = response['Images'][0]
            return {
                "ImageDescription": image.get('Description'),
                "ImageName": image.get('Name'),
                "ImageLocation": image.get('ImageLocation'),
                "OwnerId": image.get('OwnerId')
            }
    except Exception as e:
        print(f"Error fetching AMI details: {e}")
    return {"ImageDescription": None, "ImageName": None, "ImageLocation": None, "OwnerId": None}

def main():
    ec2 = boto3.client('ec2')
    instances = ec2.describe_instances()
    ami_instance_map = {}

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            ami_id = instance['ImageId']
            if ami_id not in ami_instance_map:
                ami_info = get_ami_info(ec2, ami_id)
                ami_instance_map[ami_id] = ami_info
                ami_instance_map[ami_id]['InstanceIds'] = []
            ami_instance_map[ami_id]['InstanceIds'].append(instance['InstanceId'])

    print(json.dumps(ami_instance_map, indent=2))

if __name__ == "__main__":
    main()
