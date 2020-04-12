USE [ExceptionIcon]
GO
/****** Object:  Table [dbo].[Issues]    Script Date: 2020-04-12 01:10:58 ******/
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
	[Message] [varchar](500) NULL,
	[StackTrace] [varchar](max) NULL,
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
/****** Object:  Table [dbo].[Projects]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  Table [dbo].[ProjectUser]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 2020-04-12 01:10:58 ******/
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
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Message], [StackTrace], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'2e5d904c-433e-4d7e-9feb-0c0345aa0178', N'15da8867-45b0-426a-b6be-d1998135e0c8', 3, N'FormatException', N'Input string was not in a correct format.', NULL, CAST(N'2020-04-11 00:10:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Message], [StackTrace], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'd7943d74-11fc-4609-9ebd-1a473a4748e7', N'15da8867-45b0-426a-b6be-d1998135e0c8', 1, N'FormatException', N'Input string was not in a correct format.', NULL, CAST(N'2020-04-11 00:05:00' AS SmallDateTime), 0, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Message], [StackTrace], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'fbdf655d-b178-48fd-ac99-749ce8a637fe', N'15da8867-45b0-426a-b6be-d1998135e0c8', 5, N'FormatException', N'Input string was not in a correct format.', N'at ()', CAST(N'2020-04-11 00:15:00' AS SmallDateTime), 1, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Message], [StackTrace], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'f95e2ade-3a1d-4087-ac97-d73fc7f9955a', N'15da8867-45b0-426a-b6be-d1998135e0c8', 2, N'FileNotFoundException ', N'My test exception.
', NULL, CAST(N'2020-04-11 00:06:00' AS SmallDateTime), 1, 0)
INSERT [dbo].[Issues] ([UUID], [ProjectUUID], [Number], [ExceptionType], [Message], [StackTrace], [DateOccurred], [IsResolved], [IsDeleted]) VALUES (N'2cb17987-e79f-4099-a3c7-f5f6aa4ea87d', N'15da8867-45b0-426a-b6be-d1998135e0c8', 4, N'FormatException', N'Input string was not in a correct format.', NULL, CAST(N'2020-04-11 00:05:00' AS SmallDateTime), 0, 0)
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteProject]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetIssue]    Script Date: 2020-04-12 01:10:58 ******/
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
	SELECT i.UUID, p.Name AS ProjectName, i.Number, i.ExceptionType, i.[Message], i.StackTrace, i.DateOccurred, i.IsResolved
	FROM Issues i
		INNER JOIN Projects p ON p.UUID = i.ProjectUUID
	WHERE i.UUID = @UUID

END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetIssuesByProject]    Script Date: 2020-04-12 01:10:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetIssuesByProject] -- sp_GetIssuesByProject '15da8867-45b0-426a-b6be-d1998135e0c8', 0
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
			WHERE IsDeleted = 0 AND IsResolved = 0
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
/****** Object:  StoredProcedure [dbo].[sp_GetIssuesRelatedWithUUID]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProfile]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProject]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetProjectsByUser]    Script Date: 2020-04-12 01:10:58 ******/
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
		SELECT p.UUID, p.Name, ISNULL(i.ExceptionType, 'None') AS LastError, ISNULL(i.DateOccurred, GETDATE()) AS LastTimeOccurred, s.TotalActive, s.Total
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
/****** Object:  StoredProcedure [dbo].[sp_GetUserByUUID]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertIssue]    Script Date: 2020-04-12 01:10:58 ******/
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
	@Message VARCHAR(500),
	@StackTrace VARCHAR(max),
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
	INSERT INTO Issues (UUID, ProjectUUID, ExceptionType, [Message], StackTrace, DateOccurred, IsResolved, IsDeleted)
		VALUES(@UUID, @ProjectUUID, @ExceptionType, @Message, @StackTrace, @DateOccurred, @IsResolved, @IsDeleted)

	SELECT @UUID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProject]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateMarkIssues]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateMarkIssuesByProject]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateProfile]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateProject]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateProjectApiKey]    Script Date: 2020-04-12 01:10:58 ******/
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
/****** Object:  Trigger [dbo].[trg_InsertIssueNumber]    Script Date: 2020-04-12 01:10:58 ******/
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
