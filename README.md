# hubnspoke

### Repo for simulating a hub and spoke network architecture.

### Run the following in cloud shell to ensure your project has all the necessary services enabled:
gcloud services enable \
    cloudresourcemanager.googleapis.com \
    compute.googleapis.com \
    iam.googleapis.com \
    oslogin.googleapis.com \
    servicenetworking.googleapis.com \
    sqladmin.googleapis.com \
    storage.googleapis.com

### Set up Terraform Cloud

https://discuss.hashicorp.com/t/how-to-authenticate-to-gcp-when-using-terraform-cloud/17489/5

You need to create a service account with admin rights over the target project
You will need to add this key to terraform cloud in an environment variable called GOOGLE_CREDENTIALS, to allow TF cloud to provision the environment for you
TF Cloud will not accept new line characters in the key so you will need to minify the json
the following tool does it well
https://codebeautify.org/jsonminifier

YOu can also use the following (jq described here https://stedolan.github.io/jq/):

cat file.json | jq -c


Or just set up TF to use a cloud storage bucket for state:
https://cloud.google.com/docs/terraform/resource-management/store-state


Installing mySQL Client
https://cloud.google.com/architecture/setup-mysql#gcloud

