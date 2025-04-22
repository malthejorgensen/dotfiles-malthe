
### Good guides on setting up

- [AWS Startup Security Baseline](https://docs.aws.amazon.com/prescriptive-guidance/latest/aws-startup-security-baseline/welcome.html)
- [SST v2 AWS guide](https://v2.sst.dev/setting-up-aws)

Note that for my personal account I don't actually use any of these.
I use 2FA for the root account, and then I use an IAM User under that for my
day-to-day use.

### Notes
AWS CLI (both v1 and v2) use the credentials stored in `~/.aws/credentials` by default.
I use a symbolic link to point to various other credential files in this directory, to allow easily switching between different users or AWS accounts.

Furthermore, I've put comments `; user = aws-admin` in the various credential
files to indicate what user IAM User the Access Key belongs to in the specific AWS Account.

If you're in doubt you can use either of the following commands to see what user
you're current authenticated as (which user the Access Key in `~/.aws/credentials` belongs to):

    aws iam get-user

    aws sts get-caller-identity

### Automatic use of MFA tokens
Running

    python ~/.aws/get-mfa-credentials.py

and following the instructions will automatically set `~/.aws/credentials` to
point (via symlink) to a valid MFA-authenticated session.

### Manual use of MFA tokens
If you want to do the manual process that `get-mfa-credentials.py` does automatically
you need to do the following:

    SERIAL_NUMBER="$(aws iam list-mfa-devices | jq '.SerialNumber')"
    # Then use the "SerialNumber" from the output in the command, and the one-time code from 1Password:
    aws sts get-session-token --serial-number <SERIAL_NUMBER> --token-code <CODE_FROM_1PASSWORD>
    # You can then use the output from that command to and plug it into ~/.aws/credentials
    # or do the further symlink magic that `get-mfa-credentials.py` does.


