# Terraform Astronomer
This project is an experiment to build a Terraform Provider using the Astro API

The goal of this project is to automate the creation of the following Astro resources:

- Workspaces
- Deployments
- Workspace Teams
- API Keys

We assume Organization-level users and teams are already created by SSO and SCIM respectively.
[Setting up SSO](https://docs.astronomer.io/astro/configure-idp)
[Setting up SCIM Provisioning](https://docs.astronomer.io/astro/set-up-scim-provisioning)

To use it for your own Organization, clone the repo locally and follow the Usage section below.

## About

This Terraform project leverages [terraform-provider-restapi](https://github.com/Mastercard/terraform-provider-restapi) to wrap the Astro API and create resources.

## Configuration
### Configuring Log Levels
See here for [Debugging Terraform](https://developer.hashicorp.com/terraform/internals/debugging)

```
export TF_LOG=1
export TF_LOG_PROVIDER="DEBUG"
```

## Usage

1. Initialize Terraform Project
    ```
    terraform init
    ```

2. Configure `locals.tf` to your needs

3. Follow these instructions to create an [Organization API Token](https://docs.astronomer.io/astro/organization-api-tokens)

4. Create a `terraform.tfvars` file in your project directory and paste the following in it.
   Copy your API Token from the previous step without including `Bearer` at the beginning of your token.
   ```
   AUTH_TOKEN = "<your token here>"
   ```

5. Plan the Terraform Resource creation
    ```
    terraform plan
    ```

6. Create the resources
    ```
    terraform apply
    ```

7. Destroy the resources
    ```
    terraform destroy
    ```

### Import Existing Resources
You can import an existing Organization resource by executing:
```
terraform import module.organization.data.restapi_object.organization /organizations/<organization_id>
```

You can import an existing Cluster resource by executing:
```
terraform import module.cluster.data.restapi_object.cluster /organizations/cli0mnyaw003201nlktnd6xg3/clusters/<cluster_id>
```

You can import an existing Workspace resource by executing:
```
terraform import module.workspace["Terraform Test Team 1"].restapi_object.workspace /organizations/cli0mnyaw003201nlktnd6xg3/workspaces/<workspace_id>
```

### Inspect a Terraform Resource
You can access the API Tokens generated for your Deployment by using the following command.
This is needed to use the API Tokens for CI/CD.
```
terraform state show 'module.api_token["<workspace_name>"].restapi_object.api_token'
```
