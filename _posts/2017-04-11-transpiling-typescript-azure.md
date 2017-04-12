---
layout: post
title: "Transpiling Typescript in Deployment to Azure App Service"
categories: "devops"
tags: ["typescript"]
---
I recently wrote a Node.js application that is hosted as an Azure App Service. I didn't want to check in the .js files. Instead, I wanted to generate the .js files when I deployed the application to Azure. The entire process was very easy thanks to a few people/websites. I'd like to thank [codefoster](http://www.codefoster.com/tscazure/), [jj09.net](http://jj09.net/compiling-typescript-files-on-azure-web-apps/), and [https://github.com/projectkudu/kudu/issues/1753](https://github.com/projectkudu/kudu/issues/1753]).

Steps in _italics_ are run at a command prompt.

### Install Azure-CLI

1.  _npm install -g azure-cli_

### Login into Azure

1.  _azure login_

2.  A code will be generated and printed on the screen along with a url. Navigate to the url in a browser. When prompted, enter the generated code.

3.   _azure config mode asm_

### Generate deployment script

1.  In the root directory of your project, run:  _azure site deploymentscript --node_

2.  Two files will be generated: .deployment and deploy.cmd

3.  Open deploy.cmd. Under the Deployment section, find the following code:

```
:: 1. KuduSync
IF /I "%IN_PLACE_DEPLOYMENT%" NEQ "1" (
  call :ExecuteCmd "%KUDU_SYNC_CMD%" -v 50 -f "%DEPLOYMENT_SOURCE%" -t "%DEPLOYMENT_TARGET%" -n "%NEXT_MANIFEST_PATH%" -p "%PREVIOUS_MANIFEST_PATH%" -i ".git;.hg;.deployment;deploy.cmd"
  IF !ERRORLEVEL! NEQ 0 goto error
)
```
 
4.  Above the preceeding code, enter the following code. This code will generate an empty main file to satisfy Kudu. A web.config won't be generated if the main file is missing.

```
:: 0. Create empty lib\app.js to make KuduSync happy
:: see https://github.com/projectkudu/kudu/issues/1753
IF NOT EXIST "%DEPLOYMENT_SOURCE%\dist" (
  call :ExecuteCmd mkdir "%DEPLOYMENT_SOURCE%\dist"
  call :ExecuteCmd copy NUL "%DEPLOYMENT_SOURCE%\dist\server.js"
)
```

### Finalizing settings

1.  Open package.json. Under scripts, add the following. This will install the typings (from your typings.json) and run tsc. Make sure typings is listed as a dependency in your package.json. 

```
"postinstall": "typings install && tsc"
```

Check in your files, and deploy your Azure App Service. As the project is deploying, your typescipt files will be transpiled into javascript files. Check for any errors, and check that your javascript files are complete. If you have any errors or the files aren't generated, check your typings files.

Final note...I use Visual Studio Online to host my projects. It's stupid easy to connect a project to a deployment in Azure and deploy every time you check in files in your project.
