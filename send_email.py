
# import json
# import boto3
# import os
# client = boto3.client('ses', region_name='us-east-1')

# def send_email(event, context):
#     sender_email = 'mohamed.yehia3331@gmail.com'
#     recipient_email = 'mohamed.yehia3331@gmail.com'
#     response = client.send_email(
#     Destination={
#         'ToAddresses': [recipient_email]
#     },
#     Message={
#         'Body': {
#             'Text': {
#                 'Charset': 'UTF-8',
#                 'Data': 'a change has been made to your tf state file in s3 .',
#             }
#         },
#         'Subject': {
#             'Charset': 'UTF-8',
#             'Data': 'change in terraform project is made',
#         },
#     },
#     Source=sender_email
#     )
    
#     print(response)
    
#     return {
#         'statusCode': 200,
#         'body': json.dumps("Email Sent Successfully. MessageId is: " + response['MessageId'])
#     }


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