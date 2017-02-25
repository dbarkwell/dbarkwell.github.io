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

Microsoft Azure Backup Server can only be installed on machines that belong to a domain.

1. Run MicrosoftAzureBackupInstaller.exe. Click 'Next'.

![azure recovery services setup wizard start](/assets/images/posts/2017/02/18/azurebackup1.png "Setup wizard start")

2. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup2.png "Install location")

3. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup3.png "Install location")

4. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup4.png "Install location")

5. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup5.png "Install location")

6. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup6.png "Install location")

7. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup7.png "Install location")

8. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup8.png "Install location")

9. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup9.png "Install location")

10. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup10.png "Install location")

11. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup11.png "Install location")

12. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup12.png "Install location")

13. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup13.png "Install location")

14. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup14.png "Install location")

15. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup15.png "Install location")

16. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup16.png "Install location")

17. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup17.png "Install location")

18. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup18.png "Install location")

19. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup19.png "Install location")

20. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup20.png "Install location")

21. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup21.png "Install location")

22. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup22.png "Install location")

23. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup23.png "Install location")

24. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup24.png "Install location")

25. Your Microsoft Azure Backup server is installed.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup25.png "Install location")

26. Install client.

27. Once the client has been installed, in the Microsoft Azure Backup Server client application, client on Protection. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup26.png "Install location")

28. Click on 'New' from the ribbon

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup27.png "Install location")

29. Click 'Next'

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup28.png "Install location")

30. Select 'Servers' and click 'Next'. As indicted, the DPM protection agent needs to be installed prior to this step. 

_Although this guide doesn't cover Client backups (desktops and laptops), these backups can also be performed by Microsoft Azure Backup Server_

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup29.png "Install location")

31. Select the VM that you would like to backup. You could also select only directories within those VM's to backup. Click on 'Next'.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup30.png "Install location")

32. Give your Protection group a name. Select both protection methods. This will create a backup on your local disk as well as store a backup in your Recovery Services vault in Azure. Click 'Next'.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup31.png "Install location")

33. Specify your recovery goals for your local backups. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup32.png "Install location")

34. Review your disk allocation. If under storage details, both Total disk space allocated and Disk space remaining are 0 KB, you need to allocate disk space for your backups. Follow the steps below to allocate disk space.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup33.png "Install location")

35. Click 'Management'.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup34.png "Install location")

36. Click 'Add' from the ribbon.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup35.png "Install location")

37. Add a disk. The only disk you can add is an unallocated disk (disk with no drive letter). If your disks are allocated, open Disk Management. Select the disk you want to unallocate, and select Delete volume. The drive should now be unallocated space. Run the setup again, and continue.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup36.png "Install location")

38. Click 'Next'

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup37.png "Install location")

39. Choose a replica creation method. Click 'Next'.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup38.png "Install location")

40. Select consistency check options. Click 'Next'.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup39.png "Install location")

41. Select what you would like to backup to your Recovery Services vault. Click 'Next'.

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup40.png "Install location")

42. Specify a schedule to backup to your Recovery Services vault. Click 'Next'.
 
![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup41.png "Install location")

43. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup42.png "Install location")

44. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup43.png "Install location")

45. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup44.png "Install location")

46. 

![azure recovery services install location](/assets/images/posts/2017/02/18/azurebackup45.png "Install location")
