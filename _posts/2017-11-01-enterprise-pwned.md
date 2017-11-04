---
layout: post
title: "Azure timer function to scan for any pwned email addresses and store pwned items in SharePoint list"
categories: "azure"
tags: ["azure"]
---
I wrote an Azure timer function that pulls email addresses from Azure AD using the Microsoft Graph API. Those email addresses are submitted to HaveIBeenPwned.com. If any results are returned, they are stored in a SharePoint list, again using the Microsoft Graph API. Finally, I created a Flow workflow on the SharePoint list to send a notification to a Microsoft Teams channel any time a new item is added to the SharePoint list.

### Visual Studio

_Ensure you have the Azure development workload install as part of Visual Studio 2017_

1.  In Visual Studio, select 'File' -> 'New' -> 'Project...'. Under 'Cloud', select Azure Functions. Name your project and click 'OK'

![visual studio new project](/assets/images/posts/2017/11/01/new-project.png "New project")

2.  The Azure Storage Emulator does not support Azure Functions locally, so a connection to an Azure Storage Account is required. To connect to an Azure Storage Account from your Azure Function, open Cloud Explorer (under the View menu or Ctrl+\, Ctrl+X). Connect to Azure, and navigate to a Storage Account. If you do not have a Storage Account, go to the Azure portal and create one ([About Azure storage accounts](https://docs.microsoft.com/en-us/azure/storage/common/storage-create-storage-account)). Click on your storage account and click on the Properties tab. There will be a property called 'Primary Connection String'. Copy the connection and paste it into the value of AzureWeJobsStorage in the local.settings.json within the project. 

![storage account](/assets/images/posts/2017/11/01/storage-acct.png "Storage account")

3.  Right click on your Project and from the context menu, select 'Add' -> 'New Item...'. Search or scroll through items to find 'Azure Function'. Enter a name for the class and click 'Add'.

![add new function](/assets/images/posts/2017/11/01/function-name.png "New Function")

4.  Add a 'Timer trigger' function. The Schedule is based on [NCrontab](https://github.com/atifaziz/NCrontab) in the 6 field format. Note: the schedule I attempted to use was every Sunday at midnight. I messed up the schedule in the image below. It should be: 0 0 0 * * 0.

![timer trigger](/assets/images/posts/2017/11/01/timer-trigger.png "Timer Trigger")

### Application

see https://github.com/dbarkwell/EnterprisePwned

The [README.md](https://github.com/dbarkwell/EnterprisePwned/blob/master/EnterprisePwned/README.md) contains the local.settings.json template to use. Enter values for the following fields:

- AzureWebJobsStorage
- Tenant
- ClientId
- ClientSecret
- SiteId
- ListId

### Register Application

1.  Navigate to https://apps.dev.microsoft.com in your browser.

2.  Click 'Add an app'.

3.  Enter your Application Name. Take note of the Application Id. This will be your Client Id.

4.  Click 'Generate New Password'. Take note of the Password. This will be your Client Secret.

5.  Click 'Add Platform'. Add a web platform. For local testing, add your localhost address.

6.  Under Microsoft Graph Permissions, click 'Add' next to Application Permissions. This will add permissions for an app as opposed to added delegated permissions to a user. Add 'Directory.Read.All', 'Sites.ReadWrite.All', and 'User.Read.All' permissions.

7.  Click 'Save'.

8.  Perform a GET request to the following address: 

https://login.microsoftonline.com/{tenant}/adminconsent?client_id={Client Id / Application Id}&redirect_uri={localhost}

Replace tenant, client id, and localhost values. This will authorize the changes you just made.

### SharePoint

1.  Create a SharePoint (Office 365) site or add a list to an existing SharePoint site.

2.  The list should contain the following fields:

![SP list](/assets/images/posts/2017/11/01/sp-list.png "SharePoint list")

3. The Key field is used to only store unique values in the list.

![SP key](/assets/images/posts/2017/11/01/sp-key.png "SharePoint list key")


### Flow
Whenever a new item gets added to a list, send a notification to a Microsoft Teams channel.

1. From the SharePoint list, click on the 'Flow' dropdown. Click 'Create a Flow'.

![SP Flow](/assets/images/posts/2017/11/01/sp-flow.png "SharePoint - Flow")

2. Click 'Show more'. Click 'See more templates'.

3. Click on 'Create a flow from blank'.

![Create Flow](/assets/images/posts/2017/11/01/create-flow.png "Create a Flow")

4. In the search box for 'Add a trigger', search for SharePoint. Select 'SharePoint - When an item is created'.

![SP trigger](/assets/images/posts/2017/11/01/sp-trigger.png "Search for trigger")

5. Enter site address if it does not appear in the drop down. Select the list name. Click on 'New step'.

![SP item created trigger](/assets/images/posts/2017/11/01/sp-item-created.png "When an item is created trigger")

6. Add a condition. Add: @not(empty(triggerBody()?['Title'])) as the condition. This will only trigger if there is an email address.

![Add condition](/assets/images/posts/2017/11/01/add-condition.png "Add condition")

7. Under 'If yes', click 'Add an action'.

![Choose action](/assets/images/posts/2017/11/01/choose-action.png "Choose an action")

8. Search for Teams. Select 'Microsoft Teams - Post message'.

9. Enter the 'Team Id', 'Channel Id', and 'Message'. For the 'Message', you can add in fields from the SharePoint list.

![Teams action](/assets/images/posts/2017/11/01/teams-setup.png "Setup Microsoft Teams action")

![Teams message](/assets/images/posts/2017/11/01/teams-message.png "Add teams message")

10. Click 'Save flow'

![Save Flow](/assets/images/posts/2017/11/01/save-flow.png "Save Flow")

### Results

![SP](/assets/images/posts/2017/11/01/sp.png "SharePoint results")

![Teams](/assets/images/posts/2017/11/01/teams.png "Teams result")

### Deployment

1. Log into the Azure Portal

2. Click 'New' to create a resource.

![New resource](/assets/images/posts/2017/11/01/new.png "New resource")

3. Search for 'function'. Click 'Function App' in the 'Web + Mobile' category.

![Function app](/assets/images/posts/2017/11/01/function-app.png "Function app in Web + Mobile")

4. Click 'Create'

![Create](/assets/images/posts/2017/11/01/create-function.png "Create Function")

5. Add 'App name', 'Subscription', 'Resource Group', 'Hosting Plan', 'Location', and 'Storage'. Click 'Create'.

![Setup Function](/assets/images/posts/2017/11/01/function-setup.png "Setup Function")

6. Once your Function App has been deployed, you can navigate to it from the Notifications, or from the left Navigation.

7. Click on + beside 'Functions' under your Function App heading.

![Function deploy](/assets/images/posts/2017/11/01/function-deploy1.png "Add function")

8. These steps will outline deploying from source control. The function could also be added directly in the Azure Portal. Click 'Start from source control'. 

![Deploy from source](/assets/images/posts/2017/11/01/function-deploy2.png "Deploy from source code")

9. Click 'Setup' to setup the deployment. Click 'Choose Source'. You can connect to serveral source control repositories or file stores. Normally I deploy from Visual Studio Team Services, but in this example I will deploy from GitHub. Click 'GitHub'

![Source control](/assets/images/posts/2017/11/01/source-control.png "Add source control repo")

10. Add 'Authorization', 'Choose project', 'Choose branch' and click 'Ok'. 

![Deploy setup](/assets/images/posts/2017/11/01/deploy-setup.png "Source control deploy setup")

11. After the Deployment has been setup, wait for the function to deploy and navigate back to the Function Apps screen. Click 'Application settings'.

![Application settings](/assets/images/posts/2017/11/01/app-settings.png "Application settings")

12. Under 'Application settings', click 'Add new setting'. This is where you will add the Environment Variables:

- Tenant
- ClientId
- ClientSecret
- SiteId
- ListId

AzureWebJobsStorage has already been populated from the Function setup, so you do not need to change that setting. Click 'Save'.

![Environment Variables](/assets/images/posts/2017/11/01/env-variables.png "Add Environment Variables")

13. Restart your function.

![Restart](/assets/images/posts/2017/11/01/restart.png "Restart function")

### Final Thoughts

At some point I will go back and change the SharePoint functionality. There should be two lists. One list would hold the breach information and the other would hold the breached addresses with a lookup to the breach information. 
