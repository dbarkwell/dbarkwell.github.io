---
layout: post
title: 'Azure Recovery Services vaults'
categories: 'azure'
tags: ["backup", "dpm"]
---
This post will guide you through the steps needed to setup a Microsoft Azure Backup Server.

### Azure Portal

Log into your Azure portal and select Recovery Services vaults. Click add to create a new vault. Add the Name, Subscription, Resource group, and Location. Once your vault is created, click on the Name of your vault. Under 'Getting Started', click on Backup. In the first step, 'Backup goal', change 'Where is your workload running?' to 'On-premises' and select 'Hyper-V Virtual Machines' as the 'What do you want to backup'. After you click 'OK' you will be presented with a download for Microsoft Azure Backup Server. Download all three items: Microsoft Azure Backup Server (there are 6 parts to the download), vault credentials, and latest updates. That is the only configuration needed within the Azure Portal. The rest of the configuration will take place on your server.

### Installation

**Before you install: Microsoft Azure Backup Server must be installed on a machine joined to a domain.**

1. Run MicrosoftAzureBackupInstaller.exe. Click 'Next'.

   ![azure recovery services setup wizard start](/assets/images/posts/2017/02/18/azurebackup1.png "Setup wizard start")

2. Select extract location. Click 'Next'.

   ![azure recovery services extract location](/assets/images/posts/2017/02/18/azurebackup2.png "Extract location")

3. Click 'Extract'.

   ![azure recovery services extract](/assets/images/posts/2017/02/18/azurebackup3.png "Extract")
   
   ![azure recovery services extract progress](/assets/images/posts/2017/02/18/azurebackup4.png "Progress")

4. Leave 'Execute setup.exe' checked. Click 'Finish'.

   ![azure recovery services run setup](/assets/images/posts/2017/02/18/azurebackup5.png "Start setup")

5. Click on 'Microsoft Azure Backup' under Install.

   ![azure recovery services install](/assets/images/posts/2017/02/18/azurebackup6.png "Install")
   
   ![azure recovery services copy temporary files](/assets/images/posts/2017/02/18/azurebackup7.png "Copy temp files")

6. Click 'Next'.

   ![azure recovery services install wizard](/assets/images/posts/2017/02/18/azurebackup8.png "Install wizard")

7. Click 'Check'.

   ![azure recovery services prerequisites check](/assets/images/posts/2017/02/18/azurebackup9.png "Prerequisites check")

8. If your machine meets the requirements to install, click 'Next'. [Microsoft Azure Backup Server requirements.](https://www.microsoft.com/en-us/download/details.aspx?id=49170)

   ![azure recovery services prerequisites ok](/assets/images/posts/2017/02/18/azurebackup10.png "Prerequisites ok")

9. Either install the database in a new SQL Server instance, or an existing instance of SQL Server. Note, the database needs to be SQL Server 2014 or higher if you want to use an existing database. Click 'Check and Install'.

   ![azure recovery services install sql](/assets/images/posts/2017/02/18/azurebackup11.png "SQL Server install")

10. If any software prerequisites are missing for SQL Server, they will be displayed. Install the prerequisites and restart the setup.

    ![azure recovery services sql prerequisites](/assets/images/posts/2017/02/18/azurebackup12.png "SQL Server prerequisites")

11. If you restarted the setup, click 'Check Again'. If all prerequisites for SQL Server are installed, click 'Next'.

    ![azure recovery services sql prerequisites check](/assets/images/posts/2017/02/18/azurebackup13.png "SQL Server prerequisites check")

12. Change any of the Microsoft Azure Backup Files locations. Click 'Next'.

    ![azure recovery services install application](/assets/images/posts/2017/02/18/azurebackup14.png "Install application")

13. Enter password used for the SQL Server and SQL Server Agent service accounts (if a new instance of SQL Server was installed). Click 'Next'. 

    ![azure recovery services sql server service account passwords](/assets/images/posts/2017/02/18/azurebackup15.png "SQL Server service account")

14. Click 'Next'. 

    ![azure recovery services microsoft updates](/assets/images/posts/2017/02/18/azurebackup16.png "Microsoft updates")

15. Click 'Install'. 

    ![azure recovery services install summary](/assets/images/posts/2017/02/18/azurebackup17.png "Install summary")

16. Add proxy settings, if a proxy is used. Click 'Next'. 

    ![azure recovery services proxy](/assets/images/posts/2017/02/18/azurebackup18.png "Proxy settings")

17. Click 'Install'. 

    ![azure recovery services confirm install](/assets/images/posts/2017/02/18/azurebackup19.png "Confirm install")

18. Click 'Next'. 

    ![azure recovery services install optional windows features](/assets/images/posts/2017/02/18/azurebackup20.png "Install location")

19. Click 'Browse'. Select the vault credentials file that you downloaded from the Azure portal. Click 'Next'. 

    ![azure recovery services vault identification](/assets/images/posts/2017/02/18/azurebackup21.png "Vault identification")

20. Confirm the imported information from the vault credentials file. Click 'Next'. 

    ![azure recovery services confirm vault identification](/assets/images/posts/2017/02/18/azurebackup22.png "Confirm vault identification")

21. Enter or generate a passphrase that will be used to encrypt your backed up data. Optionally, you can save the passphrase to disk or a USB drive. Click 'Next'. 

    ![azure recovery services encryption passphrase](/assets/images/posts/2017/02/18/azurebackup23.png "Encryption passphrase")

22. Microsoft Azure Backup server is installing.

    ![azure recovery services azure backup server install](/assets/images/posts/2017/02/18/azurebackup24.png "Microsoft Azure Backup Server install")

23. Your Microsoft Azure Backup server is installed. Click 'Close'.

    ![azure recovery services azure backup server installed](/assets/images/posts/2017/02/18/azurebackup25.png "Microsoft Azure Backup Server installed")

### Install Client

1. Copy the installer (MicrosoftAzureBackupInstaller.exe) to your virtual machine, and follow the steps above to extract the archive.

2. Click on 'DPM Protection Agent' under Install.

   ![azure recovery services install dpm protection agent](/assets/images/posts/2017/02/18/azurebackup6.png "DPM Protection Agent")

3. Once the agent has been installed, from a command prompt, run:

SetDPMServer -Add -DPMServerName {Microsoft Azure Backup Server name}

in the directory: C:\Program Files\Microsoft Data Protection Manager\DPM\bin.

### Setup Protection
1. Once the agent has been installed, in the Microsoft Azure Backup Server client application, click on 'Protection'.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup26.png "Install location")

2. Click 'New' from the ribbon.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup27.png "Install location")

3. Click 'Next'.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup28.png "Install location")

4. Select 'Servers' and click 'Next'. As indicted, the DPM protection agent needs to be installed prior to this step.

    _Although this guide doesn't cover Client backups (desktops and laptops), these backups can also be performed by Microsoft Azure Backup Server_

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup29.png "Install location")

5. Select the VM that you would like to backup. You could also select only directories within those VM's to backup. Click 'Next'.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup30.png "Install location")

6. Give your Protection group a name. Select both protection methods. This will create a backup on your local disk as well as store a backup in your Recovery Services vault in Azure. Click 'Next'.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup31.png "Install location")

7. Specify your recovery goals for your local backups.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup32.png "Install location")

8. Review your disk allocation. If under storage details, both 'Total disk space allocated' and 'Disk space remaining' are 0 KB, you need to allocate disk space for your backups. Follow the steps below to allocate disk space.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup33.png "Install location")

9. Click 'Management'.

   ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup34.png "Install location")

10. Click 'Add' from the ribbon.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup35.png "Install location")

11. Add a disk. The only disk you can add is an unallocated disk (disk with no drive letter). If your disks are allocated, open 'Disk Management'. Select the disk you want to unallocate, and select Delete volume. The drive should now be unallocated space. Run the setup again, and continue.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup36.png "Install location")

12. Click 'Next'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup37.png "Install location")

13. Choose a replica creation method. Click 'Next'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup38.png "Install location")

14. Select consistency check options. Click 'Next'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup39.png "Install location")

15. Select what you would like to backup to your Recovery Services vault. Click 'Next'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup40.png "Install location")

16. Specify a schedule to backup to your Recovery Services vault. Click 'Next'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup41.png "Install location")

17. Specify a retention strategy for your backups in your Recovery Services vault. Click 'Next'. 

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup42.png "Install location")

18. Choose how you want to perform your first backup. You can select 'Automatically over the network' or 'Offline Backup'. 'Offline Backup' involves transferring data to Azure by disk. You can read more about 'Offline Backup' [here](https://docs.microsoft.com/en-us/azure/backup/backup-azure-backup-import-export). Click 'Next'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup43.png "Install location")

19. Click 'Create Group'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup44.png "Install location")

20. Your protection group is created and your backup server is enabled. Click 'Close'.

    ![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup45.png "Install location")

To review any issues, click 'Monitoring' and review the 'Alerts'. Also, in Event Viewer under: 'Applications and Services' there are events under 'CloudBackup', 'DPM Alerts', and 'DPM Backup Events'.