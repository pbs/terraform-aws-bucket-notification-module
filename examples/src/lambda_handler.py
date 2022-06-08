import re
import boto3

s3 = boto3.client('s3')

pattern = r'^([^\/]+)\/(([^\.]+)\.(\d+)-(\d+)-(\d+)-(\d+)\.([^\.]+)\.gz)$'

def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        m = re.match(pattern, key)
        new_key = f"partitioned-{m.group(1)}/year={m.group(4)}/month={m.group(5)}/day={m.group(6)}/hour={m.group(7)}/{m.group(2)}"

        print(f"Copying {key} to {new_key}")
        s3.copy_object(
            CopySource={
                'Bucket': bucket,
                'Key': key,
            },
            Bucket=bucket,
            Key=new_key,
        )

        print(f"Deleting {key}")
        s3.delete_object(
            Bucket=bucket,
            Key=key,
        )
