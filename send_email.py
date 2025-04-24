import os
import boto3

def send_email(event, context):
    ses = boto3.client('ses')
    
    response = ses.send_email(
        Source=os.environ['SENDER_EMAIL'],
        Destination={'ToAddresses': [os.environ['RECIPIENT_EMAIL']]},
        Message={
            'Subject': {'Data': 'TFState Change Alert'},
            'Body': {'Text': {'Data': f"TFState file was modified:\n\n{event}"}}
        }
    )
    return response