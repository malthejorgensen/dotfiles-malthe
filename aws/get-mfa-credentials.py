#!/usr/bin/env python
import argparse
import json
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path

'''
When forcing MFA authenticated use of the AWS API for your IAM Users, you need
to use GetSessionToken in order to obtain a session that _is_ MFA authenticated
and is thus able to use access the AWS API.

Doing this using the AWS CLI v1 was quite cumbersome, and this script allowed
an easier way to obtain the token and automatically switch to the credentials
granted by that token.

References for setting up the MFA requirement on AWS:
- https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_configure-api-require.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
'''

parser = argparse.ArgumentParser()
parser.add_argument(
    '--get-only',
    action='store_true',
    help='Simply grab new credentials, but do not symlink them in',
)
parser.add_argument(
    '-r',
    '--reset',
    action='store_true',
    help='Reset to base AWS credential file (~/.aws/credentials-base)',
)
args = parser.parse_args()

aws_credentials_file_path = os.path.join(os.path.expanduser('~'), '.aws', 'credentials')


def reset_credentials():
    assert Path(aws_credentials_file_path).is_symlink()
    os.remove(aws_credentials_file_path)
    mfa_credentials = os.path.join(os.path.expanduser('~'), '.aws', 'credentials-base')
    os.symlink(mfa_credentials, aws_credentials_file_path)


# By default, we always reset credentials
if not args.get_only:
    reset_credentials()

if args.reset:
    sys.exit(0)

# `subprocess.check_output`: Raises `CalledProcessError` if the process returns non-zero exit code. Returns the stdout of the process.
# `subprocess.check_call`:   Raises `CalledProcessError` if the process returns non-zero exit code. Prints stdout of the process.
# `subprocess.run`: Does not raise `CalledProcessError` if the process returns non-zero exit code (unless `check=True`). Prints stdout of the process (unless `capture_output=True`).

output = subprocess.check_output(['aws', 'iam', 'list-mfa-devices'])
serial_number = json.loads(output)['MFADevices'][0]['SerialNumber']
print(serial_number)

otp = input('Paste in the one-time code from 1Password: ')

output = subprocess.check_output(
    [
        'aws',
        'sts',
        'get-session-token',
        '--serial-number',
        serial_number,
        '--token-code',
        otp,
    ]
)

print(output)
print(
    'This code will last 24 hours, when it expires you can simply run this script again'
)

creds = json.loads(output)['Credentials']
key = creds['AccessKeyId']
secret = creds['SecretAccessKey']
token = creds['SessionToken']

file_content = f'''
[default]
aws_access_key_id = {key}
aws_secret_access_key = {secret}
aws_session_token = {token}'''

# By default, we always symlink in the newly grabbed credentials
if not args.get_only:
    date = datetime.now().strftime('%Y-%m-%dT%H:%M')
    filename = f'mfa-credentials-temp-{date}'
    temp_path = os.path.join(os.path.expanduser('~'), '.aws', filename)
    with open(temp_path, 'w') as f:
        f.write(file_content)

    assert Path(aws_credentials_file_path).is_symlink()
    os.remove(aws_credentials_file_path)
    os.symlink(temp_path, aws_credentials_file_path)
