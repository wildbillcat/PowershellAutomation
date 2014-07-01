Configuration SignageClients
{
   # This Configuration block contains a configuration Node for each Signage Client
   Node "ARCH-SIGNAGE-01"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-01.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-01.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-02"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-02.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-02.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-03"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-03.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-03.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-04"
   {
      # This Copys the Config File over to the Machine
      # Arch-Signage-04 is a Server 2012 Computer with a Fax Server installed, as opposed to the other signage clients running Windows 7.
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-04.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-04.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-05"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-05.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-05.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-06"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-06.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-06.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-07"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-07.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-07.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-08"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-08.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-08.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-09"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-09.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-09.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-10"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-10.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-10.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-11"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-11.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-11.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-12"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-12.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-12.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-13"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-13.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-13.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-14"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-14.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-14.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-15"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-15.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-15.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-16"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-16.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-16.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-17"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-17.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-17.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-18"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-18.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-18.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-19"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-19.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-19.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-20"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-20.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-20.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-21"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-21.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-21.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-22"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-22.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-22.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-23"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-23.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-23.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
   Node "ARCH-SIGNAGE-24"
   {
      # This Copys the Config File over to the Machine
      File XiboConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-24.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Program Files (x86)\Xibo Player\XiboClient.exe.config" # The path where the config file should be installed
      }
      # This Copys the Config File over to the Machine
      File XiboUserConfigurationFile
      {
         Checksum = "ModifiedDate" #Ensure Config File is Latest Revision
         Ensure = "Present"  # Ensure Config File Exists"
         SourcePath = "\\arch-cfgmgr\PowershellDCSResources\Signage\ARCH-SIGNAGE-24.user.config" # This is a path of the Updated Config File
         DestinationPath = "C:\Users\signage\AppData\Local\Xibo\XiboClient.exe_Url_zclrehyrcix2bbdpnuvq15j31b1kejhn\2.0.0.0\user.config" # The path where the user config file should be installed
      }
   }
} 