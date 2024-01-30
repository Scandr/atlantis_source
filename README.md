# Deploy Terraform Atlantis
## Fill credentials in files
### playbooks/dockerfiles/docker-compose.yml
```
    command: atlantis server --gh-user="Scandr" --gh-token='' --gh-webhook-secret="" --repo-allowlist='github.com/Scandr/netology_devops_diploma'
```
->
```
    command: atlantis server --gh-user="Scandr" --gh-token='ghp_...' --gh-webhook-secret="some_secret" --repo-allowlist='github.com/Scandr/netology_devops_diploma'
```
There 
- gh-token is generated for my github user in account -> develop -> tokens settings
- gh-webhook-secret is a random 20 char string

### playbooks/dockerfiles/creds/.aws/credentials
```
[default]
aws_access_key_id = YCA...
aws_secret_access_key = YCN...
```
These are generated with
```
yc iam access-key create --service-account-name terraform
```
- aws_access_key_id is key_id:
- aws_secret_access_key is secret:

### playbooks/dockerfiles/creds/id_rsa.pub
This is public key paired with the privet key for base OS image user (ubuntu in my case)

### playbooks/dockerfiles/creds/key.json
Not presented in this repo, but is build-in for the custom atlantis image. This service_account_key_file that allows terraform Yandex Cloud authorization 

## Prepare installation host
Atlantis VM is ment to be deployed with terraform on Yandex Cloud therefor YC credentials must be set 
<br>
$USER/.aws/credentials - YC secrvice account creds for S3
```
[default]
aws_access_key_id = YCA...
aws_secret_access_key = YCN...
```
<br>

/opt/yandex_cloud/key.json - YC secrvice account acccess key
```
{
   "id": "aje7...82",
   "service_account_id": "aje...8tjp",
   "created_at": "2023-05-20T21:50:15.359882369Z",
   "key_algorithm": "RSA_2048",
   "public_key": "-----BEGIN PUBLIC KEY-----\nMIAB\n-----END PUBLIC KEY-----\n",
   "private_key": "-----BEGIN PRIVATE KEY-----\nMIPSWc=\n-----END PRIVATE KEY-----\n"
}
```
<br>

$USER/.terraformrc - YC provider configuration
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```


## Run Atlantis installation
Atlantis is deployed on one VM as docker container. VM is created with [terraform](./terraform), docker and atlantis are installed with [ansible playbook](./playbooks). Custom docker image is used ([Dockerfile](./playbooks/dockerfiles/Dockerfile)). If other credentials are used atlantis docker image must be rebuild and pushed to the regystry. Image is defined in [docker-compose.yml](./playbooks/dockerfiles/docker-compose.yml). <br>
docker-compose is applied with ansible shell module because the newest docker-compose v2 is not compitable with ansible module
<br>

Run from ./terraform
```
terraform init
terraform plan
terraform apply
```
In the output there should be external IP address of the created VM:
```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node00 = "51.250.72.220"
```
This IP should be in GitHub repository webhook configuration: <br>
![gh_webhook_config1](./images/gh_webhook_config1.PNG)
<br>
![gh_webhook_config2](./images/gh_webhook_config2.PNG)
<br>
After saving the webhook and creating a pull request in the target git repo atlantis should run terraform plan in pull request comments: <br>
![gh_pull_req1.PNG](./images/gh_pull_req1.PNG) <br>
![gh_pull_req2.PNG](./images/gh_pull_req2.PNG) <br>
![gh_pull_req3.PNG](./images/gh_pull_req3.PNG) <br>