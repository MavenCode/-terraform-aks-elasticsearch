# ELK (ElasticSearch, Logstash, Kibana) Stack Terraform Module  
Terraform is used to deploy the complete ELK stack to an Azure server.  
  
## Requirements  
Terraform
  
## Components of the Terraform Module  
The terraform scripts configures an Azure VM (virtual machine) server, connects to the server, deploys the ELK stack and configures the stack.  

The following files are used to define the states of the resources provisioned by terraform:  
1. main.tf  
2. variables.tf  
3. var.tfvars  
4. provider.tf  
5. outputs.tf  
6. elasticsearch.yml  
7. kibana.yml  
  
**main.tf**: The required resources are defined in the `main.tf` file. The resources provisioned include the Azure VM server and all other resources required to login into the server and deploy the ELK stack.  
  
**variables.tf**: The variables used to parameterize the provisioned resources are declared in this file.  
  
**var.tfvars**: The values of the variables declared in the `variables.tf` file are defined in this file.  
  
**provider.tf**: The Azure provider is defined in this file, with the credentials required to connect to the Azure subscription.  
  
**outputs.tf**: The outputs of the provisioned data are defined in this script.  
  
**elasticsearch.yml**: The configuration of the elasticsearch resource is defined in this script.  
  
**kibana.yml**: The configuration of the kibana resource is defined in this script.  
  
## Running the scripts  
  
- **Edit the `var.tfvars` script**:  
To deploy the resources with terraform, there is need to update the `var.tfvars` script. This is to customize the deployment.  
  
  ```  
  virtual_network_name = "<virtual_network_name>"  
  
  resource_group_name = "<resource_group_name>"  
  
  resource_group_location = "<resource_group_location>"  
  
  subnet_name = "<subnet_name>"  
  
  publics_ip_name = "<public_ip_name>"  
  
  domain_name_label = "<domain_name_label>"  
  
  environment = "<environment>"  
  
  network_interface_name = "<network_interface_name>"  
  
  storage_account_name = "<storage_account_name>"  
  
  storage_container_name = "<container_name>"  
  
  vm_name = "<virtual_machine_name>"  
  
  disk_name = "<disk_name>"  
  
  computer_name = "<computer_name>"  
  
  admin_username = "<admin_username>"  
  
  azure_subscription_id = "<subscription_id>"  
  
  azure_client_id = "<client_id>"  
  
  azure_client_secret = "<client_secret>"  
  
  azure_tenant_id = "<tenant_id>"  
  
  security_group_name = "<security_group_name>"  
  ```  
  
  For the Azure credentials, you run the command below with the Azure CLI.  
  
  ```  
  az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"  
  ```  
  
  The above command outputs the following parameters.  
  
  ```  
  {
    "appId": "00000000-0000-0000-0000-000000000000",
    "displayName": "azure-cli-2017-06-05-10-41-15",
    "name": "http://azure-cli-2017-06-05-10-41-15",
    "password": "0000-0000-0000-0000-000000000000",
    "tenant": "00000000-0000-0000-0000-000000000000"
  }  
  ```  

  ```  
  appId = ARM_CLIENT_ID

  password = ARM_CLIENT_SECRET

  tenant = ARM_TENANT_ID

  SUBSCRIPTION_ID = ARM_SUBSCRIPTION_ID  
  ```  
  
- **Initialize the terraform providers and backend**: Once the variables are set, you initialize the terraform job by running the following command. 
   
  ```  
  terraform init  
  ```  
  
- **Plan the configuration**: Terraform plan enables us to view the resources to be provisioned. You achieve this by running the following command.  
  
  ```  
  terraform plan --var-file=var.tfvars  
  ```  
  
- **Deploy the resources to Azure**: Terraform apply is used to apply the state of the resources configured within the `main.tf` script. To deploy the resources, run the following command.  
  
  ```  
  terraform apply --var-file=var.tfvars  
  ```  