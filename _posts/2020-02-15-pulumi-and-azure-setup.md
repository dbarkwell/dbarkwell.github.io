---
layout: post
title: Pulumi and Azure Setup
categories: "azure"
tags:
next:
previous:
---
I had an idea for an application I wanted to build and deploy to Azure. This was the perfect time to try out [Pulumi](https://www.pulumi.com/){:target="_blank"} to provision the Azure resources I would need. I read the [getting started](https://www.pulumi.com/docs/get-started/azure/){:target="_blank"} guide but I found it too open. I wanted to restrict the Service Principal to a single Resource Group. After setting up the Service Principal and restricting it to the Resource Group, I ran into an issue. The account was unable to register the resource providers. I did some searching and found this [article](https://mobilefirstcloudfirst.net/2018/03/fix-error-azure-subscription-doesnt-permissions-register-resource-provider/){:target="_blank"} that explained what was happening and the solution. I deleted my setup and tried again. This is what I did...

**note: replace values indicated within the &lt;&gt;**

### Create Group 

I created a new Azure AD group called All Azure Users
```
az ad group create --display-name "All Azure Users" --mail-nickname AllAzureUsers
```
Make sure you record the object id (you can always get it with: az ad group show -g "All Azure Users") 

### Create role

I created a new role using the following json file. This role allows registering of resource providers:
```
{	  
	"Name": "Register Azure resource providers",
	"Description": "Can register Azure resource providers",	  
	"Actions": [ "*/register/action" ],	  
	"AssignableScopes": [
		"/subscriptions/<subscription_id>"
	]	
}
```
The AssignableScopes can contain multiple subscriptions. I called the role file: registerReourceProviders.json

I loaded the role file with the following command:
```
az role definition create --role-definition @registerReourceProviders.json
```

### Assign role to group

I assigned the role to the Azure AD group All Azure Users I created in the first step. 
```
az role assignment create --assignee-object-id <group_object_id> --role "Register Azure resource providers"
```

### Create Resource Group

I created the Resource Group with the following command:
```
az group create --location <resource_group_location> --name <resource_group_name>
```

### Create Service Principal

I created a Service Principal and added a scope to the Resource Group created above. This restricts the Service Principal to only that Resource Group. If required, the --scopes parameter is a space-separated list of scopes.
```
az ad sp create-for-rbac --name Pulumi --scopes /subscriptions/<subscription_id>/resourceGroups/<resource_group_name>
```
When this command is executed successfully, you will need to output to configure Pulumi. The output will look similar to:
```
{
  "appId": "",
  "displayName": "Pulumi",
  "name": "http://Pulumi",
  "password": "",
  "tenant": ""
}
```

### Add All Azure Users group to Service Principal

This command adds the Service Principal to the group All Azure Users. 
```
az ad group member add --group <group_object_id> --member-id <service_principal_id>
```

### Configure Authorization Tokens

Run the following commands to configure Pulumi. **Note the --secret on the azure:clientSecret command!**

pulumi config set azure:clientId &lt;client_id&gt;

pulumi config set azure:clientSecret &lt;client_secret&gt; --secret

pulumi config set azure:tenantId &lt;tenant_id&gt;

pulumi config set azure:subscriptionId &lt;subscription_id&gt;

### Pulumi up

Run the pulumi up command and your infrastructure should be created under your Resource Group. 

If you want the Service Principal to be scoped to another Resource Group after setup, simply create the new resource group (following steps above) and run the following command to create a new role assignment for the Service Principal:
```
az role assignment create --role "Contributor" --assignee <service_principal_object_id> --resource-group <resource_group_name>
```