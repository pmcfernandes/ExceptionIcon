USE [master]
GO
/****** Object:  Database [ExceptionIcon]    Script Date: 2020-04-12 20:59:58 ******/
CREATE DATABASE [ExceptionIcon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExceptionIcon', FILENAME = N'D:\Microsoft SQL Server\Data\ExceptionIcon.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ExceptionIcon_log', FILENAME = N'D:\Microsoft SQL Server\Data\ExceptionIcon_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ExceptionIcon] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExceptionIcon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExceptionIcon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExceptionIcon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExceptionIcon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExceptionIcon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExceptionIcon] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExceptionIcon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExceptionIcon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExceptionIcon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExceptionIcon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExceptionIcon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExceptionIcon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExceptionIcon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExceptionIcon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExceptionIcon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExceptionIcon] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ExceptionIcon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExceptionIcon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExceptionIcon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExceptionIcon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExceptionIcon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExceptionIcon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExceptionIcon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExceptionIcon] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ExceptionIcon] SET  MULTI_USER 
GO
ALTER DATABASE [ExceptionIcon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExceptionIcon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExceptionIcon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExceptionIcon] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ExceptionIcon] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ExceptionIcon]
GO
/****** Object:  Table [dbo].[IssueEnvironmentVariables]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IssueEnvironmentVariables](
	[IssueUUID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_IssueEnvironmentVariables] PRIMARY KEY CLUSTERED 
(
	[IssueUUID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IssueHttpContext]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IssueHttpContext](
	[IssueUUID] [uniqueidentifier] NOT NULL,
	[Host] [varchar](50) NOT NULL,
	[Schema] [varchar](50) NOT NULL,
	[Method] [varchar](50) NOT NULL,
	[Protocol] [varchar](50) NOT NULL,
	[Path] [varchar](1024) NOT NULL,
	[QueryString] [varchar](1024) NOT NULL,
	[Query] [varchar](max) NULL,
	[Cookies] [varchar](max) NULL,
	[Headers] [varchar](max) NULL,
	[Session] [varchar](max) NULL,
 CONSTRAINT [PK_IssueHttpContext] PRIMARY KEY CLUSTERED 
(
	[IssueUUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Issues]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Issues](
	[UUID] [uniqueidentifier] NOT NULL,
	[ProjectUUID] [uniqueidentifier] NOT NULL,
	[Number] [int] NOT NULL,
	[ExceptionType] [varchar](50) NULL,
	[Source] [varchar](50) NULL,
	[Message] [varchar](500) NULL,
	[StackTrace] [varchar](max) NULL,
	[Type] [varchar](50) NULL,
	[FullyQualifiedType] [varchar](512) NULL,
	[DeclaringTypeFullName] [varchar](512) NULL,
	[DeclaringTypeName] [varchar](50) NULL,
	[MemberType] [varchar](50) NULL,
	[TargetSite] [varchar](50) NULL,
	[CurrentDirectory] [varchar](2048) NULL,
	[DateOccurred] [smalldatetime] NOT NULL CONSTRAINT [DF_Table_1_Date]  DEFAULT (getdate()),
	[IsResolved] [bit] NOT NULL CONSTRAINT [DF_Issues_IsResolved]  DEFAULT ((0)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Issues_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Issues] PRIMARY KEY CLUSTERED 
(
	[UUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Projects](
	[UUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Projects_UUID]  DEFAULT (newid()),
	[Name] [varchar](50) NOT NULL,
	[ApiKey] [varchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[UUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProjectUser]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectUser](
	[ProjectUUID] [uniqueidentifier] NOT NULL,
	[IDUser] [int] NOT NULL,
 CONSTRAINT [PK_ProjectUser] PRIMARY KEY CLUSTERED 
(
	[ProjectUUID] ASC,
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[IDUser] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Name] [varchar](120) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)),
	[UUID] [varchar](50) NOT NULL CONSTRAINT [DF_User_UUID]  DEFAULT (newid()),
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'cbe5414c-ae26-4bc6-add0-087fee054124', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3c124f73-53a7-46f9-a3d6-17607c5cb0a1', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'3d72087a-01a7-4736-b220-2b7a3864e4f0', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'9b48d848-00a3-419a-8573-31702a85c44c', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IN_DEBUG_MODE', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IN_DEBUG_MODE', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'ae67b48e-fcc1-48f6-863e-5beba0287d8d', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'6b9a4aba-7917-4c9d-9f41-7254c27dfdfe', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ServiceHubLogSessionKey', N'2F1D7F18')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1071a9ad-a324-4dce-b659-9c1713cc23b8', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'37682cb4-bd00-49ba-b591-9f5f801f9087', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'2d21828d-1da8-48f9-bb6f-a877351c6359', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PROCESSOR_REVISION', N'8e09')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ANT_HOME', N'C:\apache-ant-1.10.5')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'525462db-1b6e-4895-a34a-e2b488addae9', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'_JAVA_OPTIONS', N'-Xmx512M')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'_NO_DEBUG_HEAP', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ALLUSERSPROFILE', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ANDROID_HOME', N'C:\android_sdk')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ANT_HOME', N'C:\apache-ant-1.10.5')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'APP_POOL_CONFIG', N'C:\Projectos\expceptionicon\.vs\ExceptionIcon.Server\config\applicationhost.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'APP_POOL_ID', N'Clr4IntegratedAppPool')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'APPDATA', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'CommonProgramFiles', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'CommonProgramFiles(x86)', N'C:\Program Files (x86)\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'CommonProgramW6432', N'C:\Program Files\Common Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'COMPUTERNAME', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ComSpec', N'C:\WINDOWS\system32\cmd.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'CYGWIN', N'nodosfilewarning')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'DEV_ENVIRONMENT', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'DriverData', N'C:\Windows\System32\Drivers\DriverData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ENABLE_XAML_DIAGNOSTICS_SOURCE_INFO', N'1')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ESET_OPTIONS', N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'FPS_BROWSER_APP_PROFILE_STRING', N'Internet Explorer')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'FPS_BROWSER_USER_PROFILE_STRING', N'Default')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'HOMEDRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'HOMEPATH', N'\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'IIS_BIN', N'C:\Program Files (x86)\IIS Express')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'IIS_DRIVE', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'IIS_SITES_HOME', N'C:\Users\Pedro\Documents\My Web Sites')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'IIS_USER_HOME', N'C:\Users\Pedro\Documents\IISExpress')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'IISEXPRESS_SITENAME', N'WebApplicationSample')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'IntelliJ IDEA', N'C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'JAVA_HOME', N'C:\Program Files\Java\jdk1.8.0_221')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'LOCALAPPDATA', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'LOGONSERVER', N'\\DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'MSBuildLoadMicrosoftTargetsReadOnly', N'true')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'NUMBER_OF_PROCESSORS', N'4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'OneDrive', N'C:\Users\Pedro\OneDrive')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'OS', N'Windows_NT')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'Path', N'c:\program files (x86)\microsoft visual studio\2019\professional\common7\ide\commonextensions\microsoft\teamfoundation\team explorer\NativeBinaries\x86;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Program Files\PHP\v7.2;C:\Program Files (x86)\Intel\iCLS Client\;C:\Program Files\Intel\iCLS Client\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\OpenVPN\bin;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\Tools\Binn\;C:\Program Files\Microsoft SQL Server\120\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\120\DTS\Binn\;C:\Users\Pedro\AppData\Local\Microsoft\WindowsApps;C:\Users\Pedro\AppData\Roaming\npm;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files\Microsoft\Web Platform Installer\;C:\Program Files\NVIDIA Corporation\NVIDIA NvDLISR;C:\Program Files\dotnet\;C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\dotnet\;C:\Program Files\Intel\WiFi\bin\;C:\Program Files\Common Files\Intel\WirelessCommon\;C:\Program Files\nodejs\;C:\Program Files (x86)\dotnet-core-uninstall\;C:\Program Files (x86)\Google\google_appengine\;C:\Program Files\Microsoft VS Code\bin;C:\Users\Pedro\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\Pedro\.dotnet\tools;C:\Program Files\JetBrains\IntelliJ IDEA 2018.3.1\bin;C:\apache-ant-1.10.5\bin;C:\Program Files\Git\bin;C:\Users\Pedro\AppData\Local\Programs\Azure Data Studio\bin;C:\python37;C:\python37\Scripts;C:\Projectos\expceptionicon\packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.2.0.1\tools;C:\Projectos\expceptionicon\packages\NLog.2.1.0\tools')
GO
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PATHEXT', N'.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PkgDefApplicationConfigFile', N'C:\Users\Pedro\AppData\Local\Microsoft\VisualStudio\16.0_6ca3a229\devenv.exe.config')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PROCESSOR_ARCHITECTURE', N'x86')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PROCESSOR_ARCHITEW6432', N'AMD64')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PROCESSOR_IDENTIFIER', N'Intel64 Family 6 Model 142 Stepping 9, GenuineIntel')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PROCESSOR_LEVEL', N'6')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PROCESSOR_REVISION', N'8e09')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ProgramData', N'C:\ProgramData')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ProgramFiles', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ProgramFiles(x86)', N'C:\Program Files (x86)')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ProgramW6432', N'C:\Program Files')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PSModulePath', N'C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules;C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'PUBLIC', N'C:\Users\Public')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ServiceHubLogSessionKey', N'2F1D7F18')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'SystemDrive', N'C:')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'SystemRoot', N'C:\WINDOWS')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'TEMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'ThreadedWaitDialogDpiContext', N'-4')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'TMP', N'C:\Users\Pedro\AppData\Local\Temp')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'USERDOMAIN', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'USERDOMAIN_ROAMINGPROFILE', N'DESKTOP-M0ADO8U')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'USERNAME', N'Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'USERPROFILE', N'C:\Users\Pedro')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VisualStudioDir', N'C:\Users\Pedro\Documents\Visual Studio 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VisualStudioEdition', N'Microsoft Visual Studio Professional 2019')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VisualStudioVersion', N'16.0')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VM_APPDATA_LOCAL', N'C:\Users\Pedro\AppData\Local')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VM_APPDATA_ROAMING', N'C:\Users\Pedro\AppData\Roaming')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VSAPPIDDIR', N'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VSAPPIDNAME', N'devenv.exe')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VSLANG', N'1033')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'VSSKUEDITION', N'Professional')
INSERT [dbo].[IssueEnvironmentVariables] ([IssueUUID], [Name], [Value]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'windir', N'C:\WINDOWS')
INSERT [dbo].[IssueHttpContext] ([IssueUUID], [Host], [Schema], [Method], [Protocol], [Path], [QueryString], [Query], [Cookies], [Headers], [Session]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'localhost:44338', N'https', N'', N'GET', N'/Default.aspx', N'?a=1&b=2', N'{"a":"1","b":"2"}', N'{}', N'{"Cache-Control":"no-cache","Connection":"close","Pragma":"no-cache","Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","Accept-Encoding":"br, gzip, deflate","Accept-Language":"en-US,en;q=0.9","Host":"localhost:44338","User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36 Edg/80.0.361.111","upgrade-insecure-requests":"1","sec-fetch-dest":"document","sec-fetch-site":"none","sec-fetch-mode":"navigate","sec-fetch-user":"?1"}', N'{}')
INSERT [dbo].[IssueHttpContext] ([IssueUUID], [Host], [Schema], [Method], [Protocol], [Path], [QueryString], [Query], [Cookies], [Headers], [Session]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'localhost', N'https', N'', N'GET', N'/Default.aspx', N'?a=1&b=2', NULL, NULL, NULL, NULL)
INSERT [dbo].[IssueHttpContext] ([IssueUUID], [Host], [Schema], [Method], [Protocol], [Path], [QueryString], [Query], [Cookies], [Headers], [Session]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'localhost:44338', N'https', N'', N'GET', N'/Default.aspx', N'?a=1&b=2', N'{"a":"1","b":"2"}', N'{}', N'{"Cache-Control":"no-cache","Connection":"close","Pragma":"no-cache","Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","Accept-Encoding":"br, gzip, deflate","Accept-Language":"en-US,en;q=0.9","Host":"localhost:44338","User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36 Edg/80.0.361.111","upgrade-insecure-requests":"1","sec-fetch-dest":"document","sec-fetch-site":"none","sec-fetch-mode":"navigate","sec-fetch-user":"?1"}', N'{}')
INSERT [dbo].[IssueHttpContext] ([IssueUUID], [Host], [Schema], [Method], [Protocol], [Path], [QueryString], [Query], [Cookies], [Headers], [Session]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'localhost:44338', N'https', N'', N'GET', N'/Default.aspx', N'?a=1&b=2', N'{"a":"1","b":"2"}', N'{}', N'{"Cache-Control":"no-cache","Connection":"close","Pragma":"no-cache","Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","Accept-Encoding":"br, gzip, deflate","Accept-Language":"en-US,en;q=0.9","Host":"localhost:44338","User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36 Edg/80.0.361.111","upgrade-insecure-requests":"1","sec-fetch-dest":"document","sec-fetch-site":"none","sec-fetch-mode":"navigate","sec-fetch-user":"?1"}', N'{}')
INSERT [dbo].[IssueHttpContext] ([IssueUUID], [Host], [Schema], [Method], [Protocol], [Path], [QueryString], [Query], [Cookies], [Headers], [Session]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'localhost', N'https', N'', N'GET', N'/Default.aspx', N'?a=1&b=2', NULL, NULL, NULL, NULL)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Source], [Message], [StackTrace], [Type], [FullyQualifiedType], [DeclaringTypeFullName], [DeclaringTypeName], [MemberType], [TargetSite], [CurrentDirectory], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'5bb2cfe1-5037-45c2-8dc9-4a6fa7866e9b', N'15da8867-45b0-426a-b6be-d1998135e0c8', 24, N'FileNotFoundException', N'mscorlib', N'Could not find file ''C:\aaa.txt''.', N'   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share)
   at System.IO.File.OpenRead(String path)
   at WebApplicationSample.Default.Page_Load(Object sender, EventArgs e) in C:\Projectos\expceptionicon\WebApplicationSample\Default.aspx.cs:line 15', N'FileNotFoundException', N'System.IO.FileNotFoundException', N'System.IO.__Error', N'__Error', N'8', N'WinIOError', N'C:\Program Files (x86)\IIS Express', CAST(N'2020-04-12 19:22:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Source], [Message], [StackTrace], [Type], [FullyQualifiedType], [DeclaringTypeFullName], [DeclaringTypeName], [MemberType], [TargetSite], [CurrentDirectory], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'559c65c2-757a-430d-a0fb-60db94c609f2', N'15da8867-45b0-426a-b6be-d1998135e0c8', 23, N'FileNotFoundException', N'mscorlib', N'Could not find file ''C:\aaa.txt''.', N'   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share)
   at System.IO.File.OpenRead(String path)
   at WebApplicationSample.Default.Page_Load(Object sender, EventArgs e) in C:\Projectos\expceptionicon\WebApplicationSample\Default.aspx.cs:line 15', N'FileNotFoundException', N'System.IO.FileNotFoundException', N'System.IO.__Error', N'__Error', N'8', N'WinIOError', N'C:\Program Files (x86)\IIS Express', CAST(N'2020-04-12 19:11:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Source], [Message], [StackTrace], [Type], [FullyQualifiedType], [DeclaringTypeFullName], [DeclaringTypeName], [MemberType], [TargetSite], [CurrentDirectory], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'882ec05c-8b3d-4838-b795-b1cd232f474e', N'15da8867-45b0-426a-b6be-d1998135e0c8', 26, N'FileNotFoundException', N'mscorlib', N'Could not find file ''C:\aaa.txt''.', N'   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share)
   at System.IO.File.OpenRead(String path)
   at WebApplicationSample.Default.Page_Load(Object sender, EventArgs e) in C:\Projectos\expceptionicon\WebApplicationSample\Default.aspx.cs:line 15', N'FileNotFoundException', N'System.IO.FileNotFoundException', N'System.IO.__Error', N'__Error', N'8', N'WinIOError', N'C:\Program Files (x86)\IIS Express', CAST(N'2020-04-12 19:37:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Source], [Message], [StackTrace], [Type], [FullyQualifiedType], [DeclaringTypeFullName], [DeclaringTypeName], [MemberType], [TargetSite], [CurrentDirectory], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'b4811249-70b4-4601-906f-c1c66c262122', N'15da8867-45b0-426a-b6be-d1998135e0c8', 25, N'FileNotFoundException', N'mscorlib', N'Could not find file ''C:\aaa.txt''.', N'   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share)
   at System.IO.File.OpenRead(String path)
   at WebApplicationSample.Default.Page_Load(Object sender, EventArgs e) in C:\Projectos\expceptionicon\WebApplicationSample\Default.aspx.cs:line 15', N'FileNotFoundException', N'System.IO.FileNotFoundException', N'System.IO.__Error', N'__Error', N'8', N'WinIOError', N'C:\Program Files (x86)\IIS Express', CAST(N'2020-04-12 19:35:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Source], [Message], [StackTrace], [Type], [FullyQualifiedType], [DeclaringTypeFullName], [DeclaringTypeName], [MemberType], [TargetSite], [CurrentDirectory], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'1fa4d0eb-fc22-421e-b0e4-e6d39c904597', N'15da8867-45b0-426a-b6be-d1998135e0c8', 22, N'FileNotFoundException', N'mscorlib', N'Could not find file ''C:\aaa.txt''.', N'   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share)
   at System.IO.File.OpenRead(String path)
   at WebApplicationSample.Default.Page_Load(Object sender, EventArgs e) in C:\Projectos\expceptionicon\WebApplicationSample\Default.aspx.cs:line 15', N'FileNotFoundException', N'System.IO.FileNotFoundException', N'System.IO.__Error', N'__Error', N'8', N'WinIOError', N'C:\Program Files (x86)\IIS Express', CAST(N'2020-04-12 19:10:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'a63db08e-736c-4541-84ed-237579e64b5e', N'teste2111', N'51417717BE6134C1EC454937F01AAF64', 1)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'494c37ea-d475-445f-89d6-6f6dc4e1b1db', N'aaa', N'0F078B7B8AE8A98E98A713FD4AA3F2A0', 1)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'f694e792-83e4-462d-9090-7d67888bb80b', N'aaa', N'8D3082E25DADA9E7258D143B0FF183CE', 1)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'5d61bdc0-b044-4115-9e4a-a3c6a7120a61', N'bbb', N'72B61269351577D097809B76A5288654', 1)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'70448445-ec66-418d-9b09-a8ec02f91f0c', N'xxx', N'6698B95C808A31F86FFB92073E87C9468EF91ECA', 1)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'cf06983e-5f02-4a72-aad6-c92aace9b4d1', N'demoxxx', N'47B6AD8FCB1C3B41D43DF6B2994CEC7B', 1)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'15da8867-45b0-426a-b6be-d1998135e0c8', N'demo2', N'41820912D5B29DD5FF6072DEDE5956B2EBB8CC56', 0)
INSERT [dbo].[Projects] ([UUID], [Name], [ApiKey], [IsDeleted]) VALUES (N'43c23e96-a73a-45ea-bbce-ec3234843f5b', N'teste', N'937D8FDA9FCBB4A8973C3AF34A41F7ED', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'a63db08e-736c-4541-84ed-237579e64b5e', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'494c37ea-d475-445f-89d6-6f6dc4e1b1db', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'f694e792-83e4-462d-9090-7d67888bb80b', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'5d61bdc0-b044-4115-9e4a-a3c6a7120a61', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'70448445-ec66-418d-9b09-a8ec02f91f0c', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'cf06983e-5f02-4a72-aad6-c92aace9b4d1', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'15da8867-45b0-426a-b6be-d1998135e0c8', 1)
INSERT [dbo].[ProjectUser] ([ProjectUUID], [IDUser]) VALUES (N'43c23e96-a73a-45ea-bbce-ec3234843f5b', 1)
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([IDUser], [Username], [Password], [Name], [Email], [IsDeleted], [UUID]) VALUES (1, N'pedro', N'C6CC8094C2DC07B700FFCC36D64E2138', N'Pedro', N'pmcfernandes@gmail.com', 0, N'B1903F8F-BFB9-4F7A-BB71-55905849C911')
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  StoredProcedure [dbo].[sp_DeleteProject]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteProject]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Projects
	SET IsDeleted = 1
	WHERE UUID = @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetIssue]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetIssue]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT i.UUID, p.Name AS ProjectName, 
		   i.Number, 
		   i.Source, 
		   i.ExceptionType, 
		   i.[Message], 
		   i.StackTrace, 
		   i.[Type], 
		   i.FullyQualifiedType,
		   i.DeclaringTypeFullName, 
		   i.DeclaringTypeName, 
		   i.MemberType, 
		   i.TargetSite, 
		   i.CurrentDirectory, 
		   i.DateOccurred, 
		   i.IsResolved
	FROM Issues i
		INNER JOIN Projects p ON p.UUID = i.ProjectUUID
	WHERE i.UUID = @UUID

	SELECT Name, Value
	FROM IssueEnvironmentVariables
	WHERE IssueUUID = @UUID

	SELECT *
	FROM IssueHttpContext
	WHERE IssueUUID = @UUID

END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetIssuesByProject]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetIssuesByProject] -- sp_GetIssuesByProject '15da8867-45b0-426a-b6be-d1998135e0c8', 1
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@IncludeResolved BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT COUNT(i.UUID) AS Total, d.UUID AS LastUUID, MAX(i.DateOccurred) AS LastOccurred, d.ExceptionType, d.[Message], ISNULL(s.TotalActive, 0) AS TotalActive
	FROM Issues i
		INNER JOIN (
			SELECT ROW_NUMBER() OVER (PARTITION BY ExceptionType + '_' + [Message] ORDER BY DateOccurred DESC) AS ROW, UUID, ExceptionType, [Message]
			FROM Issues
			WHERE IsDeleted = 0 AND ((@IncludeResolved = 0 AND IsResolved = 0) OR @IncludeResolved = 1)
		) d ON d.ROW = 1 AND d.ExceptionType = i.ExceptionType AND d.[Message] = i.[Message]
		LEFT JOIN (
			SELECT COUNT(UUID) AS TotalActive, ExceptionType, [Message]
			FROM Issues
			WHERE IsDeleted = 0 AND IsResolved = 0
			GROUP BY ExceptionType, [Message]
		) s ON s.ExceptionType = i.ExceptionType AND s.[Message] = i.[Message]
	WHERE i.IsDeleted = 0 AND i.ProjectUUID = @UUID		
	GROUP BY i.ExceptionType, d.ExceptionType, i.[Message], d.[Message], d.UUID, s.TotalActive
	HAVING  ((@IncludeResolved = 0 AND  ISNULL(s.TotalActive, 0) <> 0) OR @IncludeResolved = 1 )
	ORDER BY MAX(i.DateOccurred) DESC
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetIssuesRelatedWithUUID]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetIssuesRelatedWithUUID] -- sp_GetIssuesRelatedWithUUID '2e5d904c-433e-4d7e-9feb-0c0345aa0178', 0
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@IsActive BIT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @ProjectUUID uniqueidentifier
	DECLARE @ID VARCHAR(MAX)

	SELECT @ProjectUUID = i.ProjectUUID,
		   @ID = i.ExceptionType + '_' + i.[Message]
	FROM Issues i
	WHERE i.UUID = @UUID

	
	SELECT i.UUID,
		   i.ProjectUUID,
		   i.Number,
		   i.ExceptionType,
		   i.[Message],
		   i.StackTrace,
		   i.DateOccurred,
		   i.IsResolved
	FROM Issues i
	WHERE i.ProjectUUID = @ProjectUUID 
		AND i.IsDeleted = 0 
		AND (i.ExceptionType + '_' + i.[Message] = @ID)
		AND ((i.IsResolved <> @IsActive AND @IsActive = 1) OR @IsActive = 0)

	ORDER BY i.DateOccurred
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetProfile]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProfile]
	-- Add the parameters for the stored procedure here
	@IDUser INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Username, Name, Email
	FROM [User]
	WHERE IDUser = @IDUser
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetProject]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProject] -- sp_GetProject '15da8867-45b0-426a-b6be-d1998135e0c8'
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UUID, Name, ApiKey
	FROM Projects
	WHERE UUID = @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectByAPIKey]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectByAPIKey]
	-- Add the parameters for the stored procedure here
	@APIKey VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UUID
	FROM Projects
	WHERE ApiKey = @ApiKey
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectsByUser]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectsByUser] -- sp_GetProjectsByUser 1
	-- Add the parameters for the stored procedure here
	@IDUser INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DECLARE @LastestIssues TABLE 
	(
		ProjectUUID uniqueidentifier,
		UUID uniqueidentifier		
	)

	DECLARE @Stats TABLE 
	(
		ProjectUUID uniqueidentifier,
		TotalActive INT,
		Total INT
	)		

	INSERT INTO @LastestIssues (ProjectUUID, UUID)
		SELECT d.ProjectUUID, d.UUID
		FROM (
			SELECT ROW_NUMBER() OVER (PARTITION BY ProjectUUID ORDER BY DateOccurred DESC) AS ROW, ProjectUUID, UUID
			FROM Issues
			WHERE IsDeleted = 0
		) d WHERE d.ROW = 1

	INSERT INTO @Stats(ProjectUUID, Total, TotalActive)
		SELECT i.ProjectUUID, COUNT(i.UUID) AS Total, d.TotalActive
		FROM Issues i
			INNER JOIN (
				SELECT ProjectUUID, COUNT(UUID) AS TotalActive
				FROM Issues
				WHERE IsDeleted = 0 AND IsResolved = 0
				GROUP BY ProjectUUID
			) d ON i.ProjectUUID = d.ProjectUUID
		WHERE IsDeleted = 0
		GROUP BY i.ProjectUUID, d.TotalActive

	SELECT *
	FROM (
		SELECT p.UUID, p.Name, ISNULL(i.ExceptionType, 'None') AS LastError, ISNULL(i.DateOccurred, GETDATE()) AS LastTimeOccurred, s.TotalActive, s.Total, (s.Total / s.TotalActive)  AS [Avg]
		FROM Projects p
			LEFT JOIN ProjectUser pu ON p.UUID = pu.ProjectUUID
			LEFT JOIN @LastestIssues li ON li.ProjectUUID = p.UUID
			LEFT JOIN @Stats s ON li.ProjectUUID = p.UUID
			LEFT JOIN Issues i ON i.UUID = li.UUID
		WHERE (pu.IDUser = @IDUser) AND p.IsDeleted = 0	
	) d
	ORDER BY d.LastTimeOccurred
END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserByUUID]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserByUUID]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT IDUser FROM [User] WHERE UUID = @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertIssue]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertIssue]
	-- Add the parameters for the stored procedure here
	@ProjectUUID uniqueidentifier,
	@ExceptionType VARCHAR(50),
	@Source VARCHAR(50),
	@Message VARCHAR(500),
	@StackTrace VARCHAR(max),
	@Type VARCHAR(50) = NULL,
	@FullyQualifiedType VARCHAR(512) = NULL,
	@DeclaringTypeFullName VARCHAR(512) = NULL,
	@DeclaringTypeName VARCHAR(50) = NULL,
	@MemberType VARCHAR(50) = NULL,
	@TargetSite VARCHAR(50) = NULL,
	@CurrentDirectory VARCHAR(2048) = NULL,
	@DateOccurred SMALLDATETIME = GETDATE,
	@IsResolved BIT = 0,
	@IsDeleted BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UUID uniqueidentifier
	SET @UUID = NEWID()

    -- Insert statements for procedure here
	INSERT INTO Issues (UUID, ProjectUUID, Number, ExceptionType, Source, [Message], StackTrace, [Type], FullyQualifiedType, DeclaringTypeFullName, DeclaringTypeName, MemberType, TargetSite, CurrentDirectory, DateOccurred, IsResolved, IsDeleted)
		VALUES(@UUID, @ProjectUUID, 0, @ExceptionType, @Source, @Message, @StackTrace, @Type, @FullyQualifiedType, @DeclaringTypeFullName, @DeclaringTypeName, @MemberType, @TargetSite, @CurrentDirectory, @DateOccurred, @IsResolved, @IsDeleted)

	SELECT @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertIssueEnvironmentVariables]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertIssueEnvironmentVariables]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@Name VARCHAR(50),
	@Value VARCHAR(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO IssueEnvironmentVariables (IssueUUID, Name, Value)
		VALUES (@UUID, @Name, @Value)

END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertIssueHttpContext]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertIssueHttpContext]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@Host VARCHAR(50),
	@Schema VARCHAR(50),
	@Method VARCHAR(50) = '',
	@Protocol VARCHAR(50),
	@Path  VARCHAR(1024),
	@QueryString  VARCHAR(1024),
	@Query VARCHAR(max) = NULL,
	@Cookies VARCHAR(max) = NULL,
	@Headers VARCHAR(max) = NULL,
	@Session VARCHAR(max) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO IssueHttpContext (IssueUUID, Host, [Schema], Method, Protocol, [Path], QueryString, [Query], Cookies, Headers, [Session])
		VALUES(@UUID, @Host, @Schema, ISNULL(@Method, ''), @Protocol, @Path, @QueryString, @Query, @Cookies, @Headers, @Session)
		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProject]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertProject]
	-- Add the parameters for the stored procedure here
	@Name VARCHAR(50),
	@IDUser INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @API_KEY AS VARCHAR(50)
	DECLARE @UUID uniqueidentifier

	SET @UUID = NEWID();
	SET @API_KEY = CONVERT(VARCHAR(32), HashBytes('SHA1',  CAST(NEWID() AS VARCHAR(50))) , 2)
	
    -- Insert statements for procedure here
	INSERT INTO Projects(UUID, Name, ApiKey, IsDeleted)
		VALUES (@UUID, @Name, @API_KEY, 0)

	INSERT INTO ProjectUser(ProjectUUID, IDUser)
		VALUES (@UUID, @IDUser)

	SELECT @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Login]
	-- Add the parameters for the stored procedure here
	@Username VARCHAR(30),
	@Password VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT UUID, Username
	FROM [User]
	WHERE IsDeleted = 0 AND Username = @Username AND [Password] = @Password
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateMarkIssues]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateMarkIssues] -- sp_UpdateMarkIssues '2e5d904c-433e-4d7e-9feb-0c0345aa0178', 0, 0
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@MarkAsResolved BIT,
	@MarkAll BIT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Table1 AS TABLE
	( 
		UUID uniqueidentifier,
		ProjectUUID uniqueidentifier,
		Number INT,
		ExceptionType VARCHAR(120),
		[Message] VARCHAR(500),
		StackTrace VARCHAR(max),
		DateOccurred SMALLDATETIME,
		IsResolved BIT
	)

	IF @MarkAll = 1
	BEGIN
		INSERT INTO @Table1 EXEC sp_GetIssuesRelatedWithUUID @UUID, 0
	END

	IF @MarkAll = 0
	BEGIN
		INSERT INTO @Table1 (UUID) VALUES (@UUID)
	END

	UPDATE Issues	
		SET IsResolved = @MarkAsResolved
	WHERE UUID IN (SELECT UUID FROM @Table1) AND IsDeleted = 0		
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateMarkIssuesByProject]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateMarkIssuesByProject]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@MarkAsResolved BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Issues	
		SET IsResolved = @MarkAsResolved
	WHERE ProjectUUID = @UUID AND IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProfile]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateProfile]
	-- Add the parameters for the stored procedure here
	@IDUser INT,
	@Name VARCHAR(120),
	@Email VARCHAR(255),
	@Password VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [User]
		SET [Name] = @Name,
			[Email] = @Email,
			[Password] = ISNULL(@Password, [Password])
	WHERE IDUser = @IDUser

	SELECT Username, Name, Email FROM [User] WHERE IDUser = @IDUser
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProject]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateProject]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@Name VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Projects
	SET Name = @Name
	WHERE UUID = @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProjectApiKey]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateProjectApiKey]
	-- Add the parameters for the stored procedure here
	@UUID uniqueidentifier,
	@ApiKey VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Projects
		SET ApiKey = @ApiKey
	WHERE UUID = @UUID
END

GO
/****** Object:  Trigger [dbo].[trg_InsertIssueNumber]    Script Date: 2020-04-12 20:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_InsertIssueNumber]
ON [dbo].[Issues]
AFTER INSERT
AS

	DECLARE @ProjectUUID uniqueidentifier
	DECLARE @UUID uniqueidentifier
	DECLARE @Number INT

	SELECT @ProjectUUID = ProjectUUID,
		   @UUID = UUID
	FROM inserted

	SELECT @Number = MAX(ISNULL(Number, 0)) + 1
	FROM Issues
	WHERE ProjectUUID = @ProjectUUID

	UPDATE Issues
		SET Number = @Number
	WHERE UUID = @UUID

GO
USE [master]
GO
ALTER DATABASE [ExceptionIcon] SET  READ_WRITE 
GO
