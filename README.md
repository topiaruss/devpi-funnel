# devpi-funnel
Docker image that connects to a devpi repo with files hosted on S3.

This can be used in the context of Codeship to upload code after 
passing test suites

## Status
This is in the testing stage. Currently investigating whether 
Codeship can run the app container in privileged mode to allow a mount
which is needed by yas3fs.

## Setup a bucket

Of course, the AWS user refered below will need to have access to the bucket.  
I use a policy document like this for testing:

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "s3:*",
                "Resource": [
                    "arn:aws:s3:::some-bucket",
                    "arn:aws:s3:::some-bucket/*"
                ]
            }
        ]
    }

It's important to allow bucket and contents access in Resource.  
## Running the image locally

Setup the env

    $ export AWS_ACCESS_KEY_ID=AK...HA
    $ export AWS_SECRET_ACCESS_KEY=M6L...bWph
    $ export AWS_DEFAULT_REGION=eu-west-1
    $ export S3_PATH=some-bucket
    
    $ docker build -t foo .
    $ docker run -id --privileged foo
    $ docker exec -it <ID> bash

in the container...

    # yas3fs --nonempty s3://some-bucket /mnt
    # touch /mnt/bar
    
## To run in codeship against your own S3 bucket

Create testclient/aws_deployment.env:

    # aws_deployment.env
    AWS_ACCESS_KEY_ID=AK...HA
    AWS_SECRET_ACCESS_KEY=M6L...bWph
    AWS_DEFAULT_REGION=eu-west-1
    S3_PATH=some-bucket
    
and:

    $ jet encrypt testclient/aws_deployment.env \
      testclient/aws_deployment.env.encrypted

