## Docker image with Crane + ECR-Login + Vault

A docker image built to use Crane with ECR and the Vault.

You can find this image on DockerHub under https://hub.docker.com/r/evk02/crane-ecr-vault

Use it as:
```
$ mkdir -p /root/.docker
$ echo "{\"credsStore\":\"ecr-login\"}" > /root/.docker/config.json

# if needed, then build the AWS creds file:
$ mkdir -p /root/.aws
$  echo "[default]
aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
aws_session_token=${AWS_SESSION_TOKEN}" > /root/.aws/credentials

# test
$ crane ls ${{ env.AWS_ACCOUNT }}.dkr.ecr.${{ env.AWS_REGION }}.amazonaws.com/go-containerregistry-test
```