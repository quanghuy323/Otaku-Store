USE [master]
GO
/****** Object:  Database [OtakuStore]    Script Date: 3/25/2018 7:25:46 PM ******/
CREATE DATABASE [OtakuStore]
GO
ALTER DATABASE [OtakuStore] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OtakuStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OtakuStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OtakuStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OtakuStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OtakuStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OtakuStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [OtakuStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OtakuStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OtakuStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OtakuStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OtakuStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OtakuStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OtakuStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OtakuStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OtakuStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OtakuStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OtakuStore] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [OtakuStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OtakuStore] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [OtakuStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OtakuStore] SET  MULTI_USER 
GO
ALTER DATABASE [OtakuStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OtakuStore] SET ENCRYPTION ON
GO
ALTER DATABASE [OtakuStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [OtakuStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [OtakuStore]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [OtakuStore]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 3/25/2018 7:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 3/25/2018 7:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 3/25/2018 7:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[UserId] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
	[WishlistID] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
	[Gender] [bit] NULL,
	[TimeCreated] [datetime] NULL,
	[Status] [int] NULL,
	[Total] [float] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Animes]    Script Date: 3/25/2018 7:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Animes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Animes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogImages]    Script Date: 3/25/2018 7:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Link] [nvarchar](max) NULL,
	[BlogID] [int] NOT NULL,
 CONSTRAINT [PK_BlogImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blogs]    Script Date: 3/25/2018 7:25:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[BlogImage] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[DateCreated] [datetime] NULL,
	[Publisher] [nvarchar](max) NULL,
	[IsHidden] [bit] NULL,
 CONSTRAINT [PK_Blogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[Rate] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[BlogID] [int] NOT NULL,
	[Type] [int] NULL,
	[dateCreate] [datetime] NOT NULL,
	[isDelete] [bit] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discounts]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discounts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Percentary] [int] NULL,
	[DateCreated] [datetime] NULL,
	[DateCount] [int] NULL,
	[ProductID] [int] NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Discounts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAQs]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAQs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[isHidden] [bit] NOT NULL,
 CONSTRAINT [PK_FAQs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Link] [nvarchar](max) NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufactors]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufactors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MessageSendings]    Script Date: 3/25/2018 7:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageSendings](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[phone] [varchar](50) NULL,
	[message] [nvarchar](max) NULL,
	[subject] [nvarchar](max) NULL,
	[time] [datetime] NULL,
 CONSTRAINT [PK_MessageSending] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CommentID] [int] NOT NULL,
	[UserID] [nvarchar](128) NOT NULL,
	[TimeReceive] [datetime] NULL,
	[Type] [int] NOT NULL,
	[SaleRate] [int] NULL,
	[StatusID] [int] NULL,
	[isView] [bit] NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProducts]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Price] [float] NOT NULL,
 CONSTRAINT [PK_OrderProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](128) NULL,
	[DateOrder] [datetime] NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Phone] [varchar](12) NOT NULL,
	[CardID] [varchar](20) NULL,
	[Status] [bit] NULL,
	[Description] [nvarchar](max) NULL,
	[Total] [float] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[ManufactorID] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [float] NULL,
	[StatusID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[_View] [int] NULL,
	[OrderCounter] [int] NULL,
	[Size] [nvarchar](max) NULL,
	[DateCreated] [datetime] NULL,
	[SaleRate] [int] NULL,
	[Rate] [int] NULL,
	[isDelete] [bit] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTags]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
 CONSTRAINT [PK_ProductTags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status_String] [nvarchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 3/25/2018 7:25:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Types]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Types](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](max) NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebsiteAttributes]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebsiteAttributes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NULL,
	[address] [nvarchar](max) NULL,
	[country] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[district] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[location] [varchar](50) NULL,
	[logo] [nvarchar](50) NULL,
	[time_open] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK_WebAttributes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WishLists]    Script Date: 3/25/2018 7:25:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishLists](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](128) NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_WishLists] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'0be5f76b-85d0-4c7b-bd3b-28b51e09e6e9', N'Hoang@fpt.edu.vn', 0, N'AGuVUWJ2ZfKwoptuzcnrk3x3NE0qctNpINybKkwP3xfN3K04YVdGQ0XBw/KtS27apw==', N'46930171-6757-480e-9f36-b026e4973c80', N'0902388104', 0, 0, 1, NULL, 0, N'Hoang@fpt.edu.vn', N'ApplicationUser', NULL, N'67/15', N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-16T21:20:29.217' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'10e64f20-7b72-45ba-b453-b059eb4036f5', N'admin@fpt.edu.vn', 0, N'AMy8Sc9cYtZEbbZp8d5blDVcXpOjbzP/A3yjTxNOzbbKrAqB+d0aHS3ioLYjo3lslw==', N'c6ce96dd-8bf1-4a89-a42a-61135973a038', NULL, 0, 0, 1, NULL, 0, N'admin@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 0, CAST(N'2018-03-16T21:43:07.603' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'1c46b98a-b14e-4ebf-b9f3-57fb1ad5ffd1', N'huydqse62353@gmail.com', 0, N'AHGgG3rPxga0qlayi9KdK5mNJV5P1SdBmi3IwW1/qbYiYxMDKxDD9deTDnsJd2IHhA==', N'6a340d05-22e5-406a-b295-1b12990ea5a8', NULL, 0, 0, 1, NULL, 0, N'huydqse62353@gmail.com', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-25T11:17:20.793' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'2a9bfb5c-0369-4530-bf79-a84c0f0db27f', N'Pakusan@gmail.com', 0, N'ABdsv6tn7V4gFRWVykLlla/7+rD4Ok5Rxa40BmBRZVy1JjAw43xJOtBRHiZBsgzPXA==', N'4e78efc9-3f53-45f4-94dc-d8aad9e0c30e', NULL, 0, 0, 1, NULL, 0, N'Pakusan@gmail.com', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-17T23:40:36.617' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'8871336d-d74f-40ac-a1a5-b326e7456171', N'Rem@fpt.edu.vn', 0, N'ACKLCU8Q3bimhKWA58yscKWpRfQQ2UCVyOLW+y3fc223lHEwChYj2JvHpCLdjBUPJQ==', N'701ab4ff-d982-4b03-a4f1-9094504856a3', NULL, 0, 0, 1, NULL, 0, N'Rem@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-17T23:12:51.280' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'd038260f-7abb-42a7-a9e6-a3caa293eadf', N'goku@fpt.edu.vn', 0, N'ACl6KZIUV5/P714ruh/KHJHVHmjB2JV/J1ybB6Nq/OEOxvgaSSS2ofxCf8ua4Qtwwg==', N'e04af5e7-d3bc-4f4e-a416-25156d2e7b2a', NULL, 0, 0, 1, NULL, 0, N'goku@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-17T23:10:36.110' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'de697c60-80d7-41f1-aedd-f79c4a4a8028', N'BuiSE@fpt.edu.vn', 0, N'AHExflsxtw9ftJe441nauWP2BGlKOCp3phRoUCbn6sVgAC1RJLiOx0/v6PHAnZn+gg==', N'46cde4c3-e9f9-4690-aebc-36e43aae49dd', NULL, 0, 0, 1, NULL, 0, N'BuiSE@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-17T23:32:35.133' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'e218021f-d3d6-42f0-a874-3d2debaa2ba3', N'Hoangdvse@gmail.com', 0, N'ADDBAOgyUfvzvz8ewEvQ1FaTkPvjwIUtsMqC3i5YTbNPckwRTs7W7BK/0FPiSEpOOA==', N'b70ae0ac-694c-454c-beb5-ada1c23d34b9', NULL, 0, 0, 1, NULL, 0, N'Hoangdvse@gmail.com', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-25T12:54:30.473' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'e92aa57e-364e-4f65-a648-4c8b20d2ca66', N'hoangabc@fpt.edu.vn', 0, N'AFomeicpvf2vDPMD7khzeqRO+BdvbbOAuYBIOOIDe0SM3oVk9cjOs7ASQFrl5RiZmw==', N'42204b5a-43f9-4f33-a409-ee8e6eaf9c7f', NULL, 0, 0, 1, NULL, 0, N'hoangabc@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-25T11:15:56.517' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'eeb5d694-1c71-456c-8439-999d822fd07d', N'huy@fpt.edu.vn', 0, N'ANNC0pUFlPp7jYA7fCMobpP1Ogr5yFKV3rwuNhfancBYFPmgs8noXKVLVLp4YVDP0w==', N'f1cbd80b-190b-4792-b266-c96791d1c614', NULL, 0, 0, 1, NULL, 0, N'huy@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-17T23:09:35.047' AS DateTime), NULL, NULL, 0)
INSERT [dbo].[Accounts] ([UserId], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnabled], [LockoutEndDateUtc], [AccessFailedCount], [UserName], [Discriminator], [WishlistID], [Address], [Image], [Gender], [TimeCreated], [Status], [Total], [IsDeleted]) VALUES (N'fcc22d71-5995-470e-ba8a-4e511b02bad0', N'Dongse62687@fpt.edu.vn', 0, N'ALZepk5CqS0LioVZ6P4VkZHCHeO+aFX+s1hM5Wtic2QcMDSU3dJ5FEAJdGb0bvlNdg==', N'896f7f3c-b4b5-440b-83d0-f16a380c9c42', NULL, 0, 0, 1, NULL, 0, N'Dongse62687@fpt.edu.vn', N'ApplicationUser', NULL, NULL, N'~/Content/Images/default-avatar.jpg', 1, CAST(N'2018-03-17T23:14:37.067' AS DateTime), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Animes] ON 

INSERT [dbo].[Animes] ([id], [title]) VALUES (1, N'Fate Stay Night')
INSERT [dbo].[Animes] ([id], [title]) VALUES (2, N'Re:Zero')
INSERT [dbo].[Animes] ([id], [title]) VALUES (3, N'Pokemon')
INSERT [dbo].[Animes] ([id], [title]) VALUES (4, N'Doraemon')
INSERT [dbo].[Animes] ([id], [title]) VALUES (5, N'Dragon Ball')
INSERT [dbo].[Animes] ([id], [title]) VALUES (13, N'One Piece')
INSERT [dbo].[Animes] ([id], [title]) VALUES (15, N'Naruto')
INSERT [dbo].[Animes] ([id], [title]) VALUES (16, N'Attack on Titan')
INSERT [dbo].[Animes] ([id], [title]) VALUES (17, N'Fairy Tail')
INSERT [dbo].[Animes] ([id], [title]) VALUES (19, N'Kuroko no Basket')
INSERT [dbo].[Animes] ([id], [title]) VALUES (20, N'No Game No Life')
INSERT [dbo].[Animes] ([id], [title]) VALUES (21, N'Yugi-Oh')
INSERT [dbo].[Animes] ([id], [title]) VALUES (22, N'Date Alive')
INSERT [dbo].[Animes] ([id], [title]) VALUES (23, N'One Punch Man')
INSERT [dbo].[Animes] ([id], [title]) VALUES (24, N'Swort Art Online')
INSERT [dbo].[Animes] ([id], [title]) VALUES (26, N'Other')
SET IDENTITY_INSERT [dbo].[Animes] OFF
SET IDENTITY_INSERT [dbo].[Blogs] ON 

INSERT [dbo].[Blogs] ([Id], [Title], [BlogImage], [Description], [DateCreated], [Publisher], [IsHidden]) VALUES (2, N'Hàng order, Pre-Order là gì?', N'/Content/Images/blog-post/keep-calm-and-pre-order-now.png', N'<p>Bạn c&oacute; bao giờ thắc mắc H&agrave;ng Order, Pre-Order l&agrave; g&igrave;? Tại sao c&ugrave;ng 1 mặt h&agrave;ng m&agrave; gi&aacute; mỗi shop lại kh&aacute;c nhau?<br />
H&ocirc;m nay, m&igrave;nh sẽ giới thiệu cho anh em thế n&agrave;o l&agrave; H&agrave;ng Order, Pre-Order v&agrave; thế n&agrave;o l&agrave; H&agrave;ng c&oacute; sẵn:</p>

<p><img alt="" src="/Content/Images/blog-post/keep-calm-and-pre-order-now.png" style="height:700px; width:600px" /></p>

<p><strong>1. H&agrave;ng Order:</strong><br />
- H&agrave;ng Order l&agrave; h&agrave;ng kh&ocirc;ng c&oacute; sẵn tại cửa h&agrave;ng (đ&atilde; ph&aacute;t h&agrave;nh), bạn cần đặt cọc để shop nhập về. Thời gian h&agrave;ng về khoảng từ 10 đến 14 ng&agrave;y.</p>

<p>&nbsp;</p>

<p><strong>2. Pre-Order</strong><br />
- Pre-Order l&agrave; h&igrave;nh thức đặt cọc trước khi h&agrave;ng được ph&aacute;t h&agrave;nh, thời gian ph&aacute;t h&agrave;nh được ghi r&otilde; trong phần m&ocirc; tả của mỗi sản phẩm, thời gian ph&aacute;t h&agrave;nh c&oacute; thể bị chậm hơn so với thời gian đ&atilde; ghi, v&agrave; thường Pre-Order phải đợi từ 6 th&aacute;ng đến 1 năm mới c&oacute; h&agrave;ng c&ograve;n Order chỉ cần 7-10 ng&agrave;y l&agrave; c&oacute; h&agrave;ng, ship ra chỗ kh&aacute;ch h&agrave;ng t&ugrave;y v&agrave;o địa l&yacute; Việt Nam l&acirc;u nhất ship chậm c&oacute; thể l&agrave; 6 ng&agrave;y. Cộng v&agrave;o c&oacute; thể l&agrave; từ 13-16 ng&agrave;y l&agrave; h&agrave;ng đến tay kh&aacute;ch h&agrave;ng.</p>

<p>&nbsp;</p>

<p><strong>3. H&agrave;ng c&oacute; sẵn:</strong><br />
- L&agrave; những loại h&agrave;ng c&oacute; sẵn ở shop, bạn kh&ocirc;ng phải đặt, t&ugrave;y v&agrave;o địa l&yacute; chậm nhất l&agrave; 6 ng&agrave;y h&agrave;ng đến tay kh&aacute;ch, nếu ship nhanh thậm ch&iacute; chỉ tầm 2 ng&agrave;y. Trước m&igrave;nh ship bưu điện 1 em Joker đến HCM bằng đường bưu điện chỉ cần đ&uacute;ng 1 ng&agrave;y, v&ocirc; c&ugrave;ng nhanh.</p>

<p>&nbsp;</p>

<p><strong>4. Gi&aacute; th&agrave;nh:</strong><br />
- Khẳng định rằng, gi&aacute; Order rẻ hơn so với h&agrave;ng c&oacute; sẵn. V&igrave; Order bạn phải đợi. Một số shop online kh&ocirc;ng c&oacute; h&agrave;ng sẵn, n&oacute;i thẳng ra kh&ocirc;ng c&oacute; chi ph&iacute; để mua nhưng họ vẫn đăng h&agrave;ng, th&ecirc;m điều kiện y&ecirc;u cầu kh&aacute;ch cọc 1 nửa c&ograve;n nửa c&ograve;n lại họ sẽ lo mua h&agrave;ng. Như vậy, vừa tiện cho họ c&oacute; chi ph&iacute; vừa kh&ocirc;ng sợ bị b&ugrave;ng h&agrave;ng.</p>

<p>- Một số bạn hỏi b&ecirc;n shop m&igrave;nh c&oacute; h&agrave;ng rẻ hơn c&oacute; h&agrave;ng đắt hơn. M&igrave;nh xin trả lời t&ugrave;y v&agrave;o nguồn h&agrave;ng nhập m&agrave; gi&aacute; th&agrave;nh đắt hay rẻ. M&igrave;nh đ&atilde; từng Order ở 1 số trang web, gi&aacute; th&agrave;nh sản phẩm rẻ đến kh&oacute; tin nhưng đ&oacute; chỉ l&agrave; gi&aacute; ảo c&aacute;c shop đặt ra để h&uacute;t kh&aacute;ch. Thực tế, khi kick v&agrave;o link n&oacute; sẽ độn gi&aacute; l&ecirc;n rất nhiều. Một số shop online kh&ocirc;ng c&oacute; h&agrave;ng họ đề gi&aacute; rẻ hơn đến khi kh&aacute;ch hỏi mới bảo phải đặt.</p>

<p>- Một số shop c&oacute; h&agrave;ng c&oacute; sẵn b&aacute;n đắt hơn, theo m&igrave;nh đ&oacute; l&agrave; lẽ đương nhi&ecirc;n, họ phải chịu nhiều chi ph&iacute;, họ phải đợi h&agrave;ng về tầm nửa th&aacute;ng, thậm ch&iacute; l&acirc;u hơn, chịu tắc bi&ecirc;n, thậm ch&iacute; kh&ocirc;ng về v&agrave; đ&ocirc;i khi nguy cơ kh&ocirc;ng ai mua h&agrave;ng ấy l&agrave; rất cao. Cho n&ecirc;n khi bạn hỏi gi&aacute; 1 shop h&agrave;ng c&oacute; sẵn với 1 shop h&agrave;ng Order phải đặt tiền l&agrave; v&ocirc; c&ugrave;ng khập khiễng, 1 b&ecirc;n chịu to&agrave;n bộ chi ph&iacute; 1 b&ecirc;n chịu 1 nửa chi ph&iacute; v&agrave; y&ecirc;u cầu bạn phải đặt tiền đ&atilde; l&agrave; kh&aacute;c nhau rồi.<br />
- Chất lượng đi k&egrave;m dịch vụ, 1 b&ecirc;n h&agrave;ng sẵn, bạn kh&ocirc;ng phải cọc ph&iacute;, ship nhanh nhận h&agrave;ng rồi mới giao tiền bao giờ cũng thoải m&aacute;i hơn cảm gi&aacute;c chờ đợi h&agrave;ng Order, thậm ch&iacute; kh&ocirc;ng về v&agrave; bắt bạn phải cọc tiền đ&uacute;ng kh&ocirc;ng n&agrave;o. Cho n&ecirc;n h&agrave;ng c&oacute; sẵn mắc hơn l&agrave; điều đương nhi&ecirc;n. Nếu bạn nghĩ bạn đủ khả năng đợi th&igrave; kh&ocirc;ng sao cả, đ&oacute; l&agrave; quyết định của bạn.</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn rất nhiều khi đ&atilde; theo d&otilde;i b&agrave;i viết n&agrave;y.</p>

<p>B&agrave;i viết đ&atilde; được xin ph&eacute;p t&aacute;c giả để chia sẽ, đ&atilde; sửa lại một số lỗi ch&iacute;nh tả v&agrave; c&acirc;u từ.<br />
Nguồn b&agrave;i viết: https://www.facebook.com/mohinhhaiphong123/posts/448088132259726</p>
', CAST(N'2018-03-13T00:00:00.000' AS DateTime), N'Admin', 1)
INSERT [dbo].[Blogs] ([Id], [Title], [BlogImage], [Description], [DateCreated], [Publisher], [IsHidden]) VALUES (3, N'Dakimakura - Vải nào là tốt nhất?', N'/Content/Images/blog-post/Dakimakura-vai.jpg', N'<p>L&agrave;m thế n&agrave;o để ph&acirc;n biệt c&aacute;c loại vật liệu kh&aacute;c nhau cho chiếc Dakimakura / Gối &ocirc;m của bạn?</p>

<p>Hiện tại nhu cầu mua 1 chiếc Dakimakura chất lượng đ&atilde; tăng l&ecirc;n rất nhiều so với v&agrave;i năm trước, tuy nhi&ecirc;n vẫn chưa c&oacute; 1 b&agrave;i viết n&agrave;o hướng dẫn cũng như tư vấn cho c&aacute;c bạn 1 c&aacute;ch chi tiết v&agrave; đầy đủ.</p>

<p>Trong b&agrave;i viết n&agrave;y shop sẽ giới thiệu cho c&aacute;c bạn c&aacute;c loại vải cũng như sự kh&aacute;c biệt giữa ch&uacute;ng:</p>

<p>Ch&uacute;ng ta c&oacute; 4 loại vải thường d&ugrave;ng để sản xuất cho Dakimakura&nbsp;:&nbsp;2Way Upgrade/ Smoothknit/Peach Skin and Super Soft (shop để nguy&ecirc;n t&ecirc;n tiếng anh v&igrave; khi dịch ra n&oacute; rất tối nghĩa :D</p>

<h3><strong>C&aacute;c loại vải Dakimakura</strong></h3>

<p><strong>Super Soft</strong>&nbsp;th&agrave;nh phần:&nbsp;100%Polyester</p>

<p>Đặc t&iacute;nh: một lớp nhung tr&ecirc;n bề mặt, tương đối d&agrave;y, mềm v&agrave; ấm, th&iacute;ch hợp cho m&ugrave;a đ&ocirc;ng</p>

<p><strong>Peach Skin&nbsp;</strong>th&agrave;nh phần&nbsp;100% Polyester</p>

<p>Đặc t&iacute;nh:&nbsp;Peach Skin n&oacute;i chung l&agrave; một polyester dệt trọng lượng nhẹ, đ&atilde; được m&agrave;i m&ograve;n cho đến khi n&oacute; c&oacute; một kết cấu mờ giống như da của một quả đ&agrave;o. Đ&acirc;y l&agrave; vật liệu được ưa chuộng nhất v&igrave; gi&aacute; th&agrave;nh dễ chịu, m&agrave;u in đẹp, mềm v&agrave; mịn m&agrave;ng, độ bền tốt, nhược điểm kh&ocirc;ng c&oacute; t&iacute;nh đ&agrave;n hồi (co gi&atilde;n)</p>

<p><img alt="" src="/Content/Images/blog-post/peach-skin.jpg" style="height:663px; width:800px" /></p>

<p><strong>2Way Tricot&nbsp;</strong>th&agrave;nh phần 18% Spandex, 82%&nbsp;Polyester</p>

<p>Sử dụng c&ugrave;ng chất liệu với&nbsp;2Way Tokyo upgrade của&nbsp;A&amp;J Inc, một nh&agrave; sản xuất gối nổi tiếng của Nhật Bản.</p>

<p>Đặc t&iacute;nh: tương đối d&agrave;y, mịn, c&oacute; thể đ&agrave;n hồi theo 4 hướng chống nhăn, C&oacute; độ đ&agrave;n hồi tốt, m&agrave;u in đẹp hơn Peach Skin.</p>

<p><img alt="" src="/Content/Images/blog-post/2way.jpg" style="height:663px; width:800px" /></p>

<p><strong>Smoothknit&nbsp;</strong>th&agrave;nh phần&nbsp;100% Polyester</p>

<p>Đặc t&iacute;nh: một trong những loại gối phổ biến ở Nhật Bản, v&agrave;i đ&agrave;n hồi nhưng chỉ c&oacute; thể đ&agrave;n hồi theo 1 hướng. M&agrave;u sắc sặc sỡ v&agrave; kh&ocirc;ng bị phai m&agrave;u, cảm gi&aacute;c mềm mại v&agrave; thoải m&aacute;i.</p>

<p><img alt="" src="/Content/Images/blog-post/smoothknit.jpg" style="height:663px; width:800px" /></p>

<p>C&oacute; 5 yếu tố ch&iacute;nh bạn cần phải biết khi quyết định n&ecirc;n chọn loại vải n&agrave;o cho chiếc Dakimakura của m&igrave;nh: cảm gi&aacute;c khi sờ, trọng lượng, độ đ&agrave;n hồi, độ bền, v&agrave; quan trọng nhất l&agrave; chất lượng h&igrave;nh ảnh Waifu của bạn sẽ như thế n&agrave;o khi in l&ecirc;n.</p>

<p><strong>Chọn vải cho dakimakura của t&ocirc;i?</strong></p>

<p><strong><img alt="" src="/Content/Images/blog-post/choose-which.jpg" style="height:350px; width:650px" /></strong></p>

<p>Nếu bạn muốn loại rẻ nhất h&atilde;y chọn&nbsp;<strong>Peach Skin</strong>.&nbsp;</p>

<p>Peach Skin cho cảm gi&aacute;c mịn m&agrave;ng, độ bền cao, h&igrave;nh ảnh r&otilde; n&eacute;t, kh&ocirc;ng bị phai m&agrave;u theo thời gian. Độ trơn của vải cho ra một bản in tốt hơn v&agrave; r&otilde; r&agrave;ng hơn.</p>

<p>Nếu bạn chuẩn bị để mua loại vải tốt nhất,&nbsp;<strong>2Way Tricot</strong>&nbsp;l&agrave; sự lựa chọn đ&uacute;ng.&nbsp;</p>

<p><strong>2Way Tricot</strong>&nbsp;l&agrave; tất cả mọi thứ bạn muốn cho&nbsp;Dakimakura của m&igrave;nh. C&oacute; thể n&oacute;i đ&acirc;y l&agrave; loại v&agrave;i mềm mại nhất m&agrave; bạn từng cảm thấy.&nbsp;<strong>2Way Tricot&nbsp;</strong>c&oacute; độ đ&agrave;n hồi cao, vải d&agrave;y v&agrave; b&ecirc;n. Chất lượng h&igrave;nh ảnh thật đ&aacute;ng kinh ngạc, kh&ocirc;ng c&oacute; lỗi n&agrave;o được t&igrave;m thấy tr&ecirc;n&nbsp;<strong>2Way Tricot,&nbsp;</strong>l&agrave; sự chọn lựa của nhiều người khi mua&nbsp;<strong>Dakimakura.</strong></p>

<p>Nhược điểm: gi&aacute; th&agrave;nh kh&aacute; cao so với mệnh gi&aacute; tiền VND</p>

<p>Nếu bạn chuẩn bị để mua 1 chiếc gối ấm &aacute;p cho m&ugrave;a đ&ocirc;ng th&igrave; h&atilde;y chọn&nbsp;<strong>Super Soft Velvet.&nbsp;</strong>N&oacute; mềm v&agrave; ấm &aacute;p khi c&oacute; 1 lớp nhung mỏng ở tr&ecirc;n bề mặt, nhưng chất liệu h&igrave;nh ảnh kh&ocirc;ng được r&otilde; r&agrave;ng v&agrave; sắc n&eacute;t so với 3 loại vải c&ograve;n lại.</p>

<p>Mặc d&ugrave; kh&ocirc;ng c&oacute; sự lựa chọn n&agrave;o l&agrave; tốt nhất, nếu c&oacute; điều kiện bạn c&oacute; thể mua cả 4 loại để sử dụng.</p>

<p>Bạn c&oacute; thể l&agrave;m theo tr&aacute;i tim của bạn để lựa chọn bất cứ điều g&igrave; bạn th&iacute;ch.</p>

<p>B&agrave;i viết được dịch lại từ:&nbsp;https://www.coosfly.com/blog/how-to-distinguish-the-different-kind-of-materials-for-a-hugging-dakimakura v&agrave; được sử dụng google dịch n&ecirc;n 1 số chỗ c&oacute; thể kh&oacute; hiểu, mong bạn đọc c&oacute; thể g&oacute;p &yacute; để shop sửa lại.</p>
', CAST(N'2018-03-12T00:00:00.000' AS DateTime), N'Admin', 0)
INSERT [dbo].[Blogs] ([Id], [Title], [BlogImage], [Description], [DateCreated], [Publisher], [IsHidden]) VALUES (8, N'Hàng order, Pre-Order là gì?', N'/Content/Images/blog-post/keep-calm-and-pre-order-now.png', N'abc', CAST(N'2018-03-11T00:00:00.000' AS DateTime), N'Admin', 0)
INSERT [dbo].[Blogs] ([Id], [Title], [BlogImage], [Description], [DateCreated], [Publisher], [IsHidden]) VALUES (9, N'Tại sao bạn phải mua Figure ?', N'/Content/Images/blog-post/choose-which.jpg', N'<p>T&ocirc;i cũng m&eacute;o biết !</p>
', CAST(N'2018-03-15T15:26:37.940' AS DateTime), N'Admin', 0)
SET IDENTITY_INSERT [dbo].[Blogs] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([id], [title]) VALUES (1, N'Manga & Anime')
INSERT [dbo].[Categories] ([id], [title]) VALUES (2, N'Marvel & DC Comic')
INSERT [dbo].[Categories] ([id], [title]) VALUES (3, N'Vocaloid')
INSERT [dbo].[Categories] ([id], [title]) VALUES (4, N'Cloth')
INSERT [dbo].[Categories] ([id], [title]) VALUES (5, N'Games')
INSERT [dbo].[Categories] ([id], [title]) VALUES (6, N'Sale Off')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [ProductID], [UserID], [Rate], [Comment], [BlogID], [Type], [dateCreate], [isDelete]) VALUES (41, 14, N'0be5f76b-85d0-4c7b-bd3b-28b51e09e6e9', 4, N'Beautiful', 0, 1, CAST(N'2018-03-18T12:32:57.673' AS DateTime), 0)
INSERT [dbo].[Comments] ([Id], [ProductID], [UserID], [Rate], [Comment], [BlogID], [Type], [dateCreate], [isDelete]) VALUES (42, 14, N'0be5f76b-85d0-4c7b-bd3b-28b51e09e6e9', 3, N'fwefewfewfew', 0, 1, CAST(N'2018-03-18T12:50:44.843' AS DateTime), 0)
INSERT [dbo].[Comments] ([Id], [ProductID], [UserID], [Rate], [Comment], [BlogID], [Type], [dateCreate], [isDelete]) VALUES (43, 14, N'0be5f76b-85d0-4c7b-bd3b-28b51e09e6e9', 5, N'gregre', 0, 1, CAST(N'2018-03-18T12:51:12.563' AS DateTime), 0)
INSERT [dbo].[Comments] ([Id], [ProductID], [UserID], [Rate], [Comment], [BlogID], [Type], [dateCreate], [isDelete]) VALUES (44, 14, N'0be5f76b-85d0-4c7b-bd3b-28b51e09e6e9', 5, N'guvuvu', 0, 1, CAST(N'2018-03-18T12:51:32.377' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Comments] OFF
SET IDENTITY_INSERT [dbo].[FAQs] ON 

INSERT [dbo].[FAQs] ([Id], [Title], [Description], [isHidden]) VALUES (2, N'Làm sao để đặt hàng tại Otaku-Store?', N'<p>-Đặt trực tuyến được giao h&agrave;ng tận nơi &aacute;p dụng với đơn h&agrave;ng tr&ecirc;n 500k</p>

<p>-Đặt trực tuyến được giao h&agrave;ng tận nơi cọc 50% &aacute;p dụng với đơn h&agrave;ng dưới 500k</p>

<p>-Mua trực tiếp tại Shop</p>

<p>-C&aacute;c hoạt động chuyển tiền được đưa tới ATM OtakuStore</p>
', 0)
INSERT [dbo].[FAQs] ([Id], [Title], [Description], [isHidden]) VALUES (3, N'Figure tại shop là hàng loại gì?', N'<p>_Đa phần figure tại shop đều l&agrave; real.</p>

<p>_1 số th&igrave; được đặt theo y&ecirc;u cầu của kh&aacute;ch(loại fake)</p>

<p>_Real v&agrave; Fake đều được shop ghi r&otilde; tr&ecirc;n t&ecirc;n sản phẩm</p>
', 0)
INSERT [dbo].[FAQs] ([Id], [Title], [Description], [isHidden]) VALUES (4, N'Otaku-Store có làm ngày chủ nhật không?', N'<p>Vẫn l&agrave;m như ng&agrave;y b&igrave;nh thường&nbsp;</p>
', 0)
INSERT [dbo].[FAQs] ([Id], [Title], [Description], [isHidden]) VALUES (5, N'Shop có nhận order figure nước ngoài không?', N'<p>Hiện nay shop c&oacute; nhận order figure của nhiều h&atilde;ng nước ngo&agrave;i. Bạn c&oacute; thể li&ecirc;n lạc với shop để biết th&ecirc;m chi tiết</p>
', 0)
INSERT [dbo].[FAQs] ([Id], [Title], [Description], [isHidden]) VALUES (6, N'Shop có nhận mua lại figure không?', N'<p>Shop c&oacute; nhận mua lại 1 số mặt h&agrave;ng figure để trưng b&agrave;y. Để biết th&ecirc;m chi tiết vui l&ograve;ng li&ecirc;n hệ với shop để biết th&ecirc;m.</p>
', 0)
SET IDENTITY_INSERT [dbo].[FAQs] OFF
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (1, 9, N'/Content/Images/Figure/FIGURE-037098_01.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (2, 9, N'/Content/Images/Figure/FIGURE-037098_02.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (3, 9, N'/Content/Images/Figure/FIGURE-037098_03.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (4, 9, N'/Content/Images/Figure/FIGURE-037098_04.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (5, 9, N'/Content/Images/Figure/FIGURE-037098_05.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (6, 10, N'/Content/Images/Figure/jeanne-d-arc-alter-1-7-2nd-ascension-aniplex.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (7, 10, N'/Content/Images/Figure/jeanne-d-arc-alter-1-7-2nd-ascension-aniplex-1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (8, 10, N'/Content/Images/Figure/jeanne-d-arc-alter-1-7-2nd-ascension-aniplex-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (9, 10, N'/Content/Images/Figure/jeanne-d-arc-alter-1-7-2nd-ascension-aniplex-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (10, 10, N'/Content/Images/Figure/jeanne-d-arc-alter-1-7-2nd-ascension-aniplex-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (11, 11, N'/Content/Images/Figure/fate-apocrypha-jeanne-d-arc-max-factory.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (13, 11, N'/Content/Images/Figure/fate-apocrypha-jeanne-d-arc-max-factory-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (14, 11, N'/Content/Images/Figure/fate-apocrypha-jeanne-d-arc-max-factory-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (15, 11, N'/Content/Images/Figure/fate-apocrypha-jeanne-d-arc-max-factory-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (16, 1, N'/Content/Images/Figure/fig_1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (17, 4, N'/Content/Images/Figure/fig_2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (18, 5, N'/Content/Images/Figure/fig_3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (19, 6, N'/Content/Images/Figure/fig_4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (21, 14, N'/Content/Images/Figure/fig_rezero_main.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (22, 14, N'/Content/Images/Figure/fig_rezero_main2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (23, 14, N'/Content/Images/Figure/fig_rezero_main3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (24, 14, N'/Content/Images/Figure/fig_rezero_main4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (25, 14, N'/Content/Images/Figure/fig_rezero_main5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (30, 14, N'/Content/Images/Figure/5049231433166269.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (31, 18, N'/Content/Images/Figure/fig_16.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (32, 19, N'/Content/Images/Figure/rezero-starting-life-in-another-world-ram-1-7.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (33, 19, N'/Content/Images/Figure/rezero-starting-life-in-another-world-ram-1-7-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (34, 19, N'/Content/Images/Figure/rezero-starting-life-in-another-world-ram-1-7-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (35, 19, N'/Content/Images/Figure/rezero-starting-life-in-another-world-ram-1-7-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (36, 19, N'/Content/Images/Figure/rezero-starting-life-in-another-world-ram-1-7-5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (37, 20, N'/Content/Images/Figure/1-7th-scale-rem-rezero-starting-life-in-another-world-1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (38, 20, N'/Content/Images/Figure/1-7th-scale-rem-rezero-starting-life-in-another-world-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (39, 20, N'/Content/Images/Figure/1-7th-scale-rem-rezero-starting-life-in-another-world-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (40, 20, N'/Content/Images/Figure/1-7th-scale-rem-rezero-starting-life-in-another-world-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (41, 20, N'/Content/Images/Figure/1-7th-scale-rem-rezero-starting-life-in-another-world-5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (42, 20, N'/Content/Images/Figure/1-7th-scale-rem-rezero-starting-life-in-another-world-6.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (43, 21, N'/Content/Images/Figure/re-zero-kara-hajimeru-isekai-seikatsu-emilia-pm-figure-natsu-no-hi-e-m-t-sega.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (44, 21, N'/Content/Images/Figure/re-zero-kara-hajimeru-isekai-seikatsu-emilia-pm-figure-natsu-no-hi-e-m-t-sega-1.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (45, 21, N'/Content/Images/Figure/re-zero-kara-hajimeru-isekai-seikatsu-emilia-pm-figure-natsu-no-hi-e-m-t-sega-2.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (46, 22, N'/Content/Images/Figure/marz-studio-luffy-lucy-sd-scale.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (47, 22, N'/Content/Images/Figure/marz-studio-luffy-lucy-sd-scale-1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (48, 22, N'/Content/Images/Figure/marz-studio-luffy-lucy-sd-scale-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (49, 22, N'/Content/Images/Figure/marz-studio-luffy-lucy-sd-scale-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (50, 22, N'/Content/Images/Figure/marz-studio-luffy-lucy-sd-scale-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (51, 23, N'/Content/Images/Figure/bbt-studios-sengoku-golden-buddha-sd-resin-statue.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (52, 23, N'/Content/Images/Figure/bbt-studios-sengoku-golden-buddha-sd-resin-statue-1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (53, 23, N'/Content/Images/Figure/bbt-studios-sengoku-golden-buddha-sd-resin-statue-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (54, 23, N'/Content/Images/Figure/bbt-studios-sengoku-golden-buddha-sd-resin-statue-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (55, 23, N'/Content/Images/Figure/bbt-studios-sengoku-golden-buddha-sd-resin-statue-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (56, 23, N'/Content/Images/Figure/bbt-studios-sengoku-golden-buddha-sd-resin-statue-5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (57, 24, N'/Content/Images/Figure/black-pearl-studios-charlotte-linlin-big-mama-resin-statue.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (58, 24, N'/Content/Images/Figure/black-pearl-studios-charlotte-linlin-big-mama-resin-statue-1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (59, 24, N'/Content/Images/Figure/black-pearl-studios-charlotte-linlin-big-mama-resin-statue-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (60, 24, N'/Content/Images/Figure/black-pearl-studios-charlotte-linlin-big-mama-resin-statue-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (61, 24, N'/Content/Images/Figure/black-pearl-studios-charlotte-linlin-big-mama-resin-statue-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (62, 24, N'/Content/Images/Figure/black-pearl-studios-charlotte-linlin-big-mama-resin-statue-5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (63, 25, N'/Content/Images/Figure/f3-studio-yonkou-kaido-resin-figure.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (64, 25, N'/Content/Images/Figure/f3-studio-yonkou-kaido-resin-figure-1.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (65, 25, N'/Content/Images/Figure/f3-studio-yonkou-kaido-resin-figure-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (66, 25, N'/Content/Images/Figure/f3-studio-yonkou-kaido-resin-figure-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (67, 25, N'/Content/Images/Figure/f3-studio-yonkou-kaido-resin-figure-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (68, 25, N'/Content/Images/Figure/f3-studio-yonkou-kaido-resin-figure-5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (69, 13, N'/Content/Images/Figure/Miku.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (70, 13, N'/Content/Images/Figure/Miku-2.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (71, 13, N'/Content/Images/Figure/Miku-3.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (72, 13, N'/Content/Images/Figure/Miku-4.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (73, 13, N'/Content/Images/Figure/Miku-5.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (74, 13, N'/Content/Images/Figure/Miku-6.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (75, 26, N'/Content/Images/Figure/sword-art-online.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (76, 26, N'/Content/Images/Figure/sword-art-online-2.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (77, 26, N'/Content/Images/Figure/sword-art-online-3.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (78, 26, N'/Content/Images/Figure/sword-art-online-4.jpeg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (79, 26, N'/Content/Images/Figure/No-image-available.jpg')
INSERT [dbo].[Images] ([Id], [ProductID], [Link]) VALUES (80, 26, N'/Content/Images/Figure/sword-art-online-5.jpeg')
SET IDENTITY_INSERT [dbo].[Images] OFF
SET IDENTITY_INSERT [dbo].[Manufactors] ON 

INSERT [dbo].[Manufactors] ([Id], [Name], [Address]) VALUES (1, N'Bandai', N'/Content/images/Brands/bandai-250x250.png')
INSERT [dbo].[Manufactors] ([Id], [Name], [Address]) VALUES (2, N'Aniplex+', N'/Content/images/Brands/aniplexplus-250x250.gif')
INSERT [dbo].[Manufactors] ([Id], [Name], [Address]) VALUES (3, N'Alter', N'/Content/images/Brands/Apocalypse-250x250.jpg')
INSERT [dbo].[Manufactors] ([Id], [Name], [Address]) VALUES (4, N'Good Smile Company', N'/Content/images/Brands/banpesto-250x250.jpg')
INSERT [dbo].[Manufactors] ([Id], [Name], [Address]) VALUES (5, N'Resin', N'/Content/images/Brands/F3-Studio-250x250.jpg')
SET IDENTITY_INSERT [dbo].[Manufactors] OFF
SET IDENTITY_INSERT [dbo].[MessageSendings] ON 

INSERT [dbo].[MessageSendings] ([id], [name], [email], [phone], [message], [subject], [time]) VALUES (1, N'Huy', N'QuangHuy@gmail.com', N'0909217723', N'Huy is the best', N'Naruto', CAST(N'2018-03-16T11:44:09.000' AS DateTime))
INSERT [dbo].[MessageSendings] ([id], [name], [email], [phone], [message], [subject], [time]) VALUES (2, N'Huy', N'Huy@gmail.com', N'060615181', N'How much ?', N'Pikachu Figure', CAST(N'2018-03-16T15:46:59.000' AS DateTime))
INSERT [dbo].[MessageSendings] ([id], [name], [email], [phone], [message], [subject], [time]) VALUES (3, N'songoku', N'songoku@sayan.com', N'062816495', N'Where is my Chichi ?', N'Chichi', CAST(N'2018-03-16T15:58:25.000' AS DateTime))
INSERT [dbo].[MessageSendings] ([id], [name], [email], [phone], [message], [subject], [time]) VALUES (4, N'fwef', N'd', N'151561651', N'fewfew', N'efewf', CAST(N'2018-03-16T16:00:32.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[MessageSendings] OFF
SET IDENTITY_INSERT [dbo].[OrderProducts] ON 

INSERT [dbo].[OrderProducts] ([Id], [OrderID], [ProductID], [Quantity], [Name], [Price]) VALUES (1, 0, 13, 1, N'Miku hot figure in the world', 9999999)
INSERT [dbo].[OrderProducts] ([Id], [OrderID], [ProductID], [Quantity], [Name], [Price]) VALUES (2, 4, 13, 1, N'Miku hot figure in the world', 9999999)
INSERT [dbo].[OrderProducts] ([Id], [OrderID], [ProductID], [Quantity], [Name], [Price]) VALUES (3, 4, 14, 1, N'Re:Zero kara Hajimeru Isekai Seikatsu - Emilia - 1/7 (Good Smile Company)', 20000)
INSERT [dbo].[OrderProducts] ([Id], [OrderID], [ProductID], [Quantity], [Name], [Price]) VALUES (4, 5, 13, 1, N'Miku hot figure in the world', 9999999)
INSERT [dbo].[OrderProducts] ([Id], [OrderID], [ProductID], [Quantity], [Name], [Price]) VALUES (5, 5, 14, 1, N'Re:Zero kara Hajimeru Isekai Seikatsu - Emilia - 1/7 (Good Smile Company)', 20000)
INSERT [dbo].[OrderProducts] ([Id], [OrderID], [ProductID], [Quantity], [Name], [Price]) VALUES (6, 5, 6, 1, N'Mô hình lắp ráp Chopper Robo Super No. 1 To 5', 1000000)
SET IDENTITY_INSERT [dbo].[OrderProducts] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [UserID], [DateOrder], [Address], [Phone], [CardID], [Status], [Description], [Total]) VALUES (1, N'Hoang@fpt.edu.vn', CAST(N'2018-03-19T11:28:47.267' AS DateTime), N'asdasdasd', N'0123456789', N'', 0, N'', 10000000)
INSERT [dbo].[Orders] ([Id], [UserID], [DateOrder], [Address], [Phone], [CardID], [Status], [Description], [Total]) VALUES (2, N'Hoang@fpt.edu.vn', CAST(N'2018-03-19T11:31:20.900' AS DateTime), N'dasdas', N'0123456789', N'', 0, N'', 10000000)
INSERT [dbo].[Orders] ([Id], [UserID], [DateOrder], [Address], [Phone], [CardID], [Status], [Description], [Total]) VALUES (3, N'Hoang@fpt.edu.vn', CAST(N'2018-03-19T11:39:22.873' AS DateTime), N'ádasasdasd', N'0123456789', N'', 0, N'Hoàng là 1 thằng Weaboo', 10000000)
INSERT [dbo].[Orders] ([Id], [UserID], [DateOrder], [Address], [Phone], [CardID], [Status], [Description], [Total]) VALUES (4, N'Hoang@fpt.edu.vn', CAST(N'2018-03-19T11:43:54.103' AS DateTime), N'ádsadasdsad', N'0123456789', N'', 0, N'Đổng là 1 thằng Weaboo', 10020001)
INSERT [dbo].[Orders] ([Id], [UserID], [DateOrder], [Address], [Phone], [CardID], [Status], [Description], [Total]) VALUES (5, N'Hoang@fpt.edu.vn', CAST(N'2018-03-25T11:53:49.537' AS DateTime), N'aa', N'1234567890', N'', 0, N'', 11020002)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (1, N'Mô hình Tàu Thousand Sunny Film Gold Release Anniversary Color Ver - One Piece Grand Ship Collection (Plastic model)', 1, N'Hera 7 sừng ', 500000, 5, 1, 40, 0, N'lắp ráp hoàn thiện dài khoảng 15cm', CAST(N'2018-02-26T00:00:00.000' AS DateTime), 10, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (4, N'Mô hình Tàu Marshall D. Teach Pirate Ship - One Piece Grand Ship Collection (Plastic model)', 2, N'Hera 7 sừng', 500000, 1, 1, 18, 0, N'lắp ráp hoàn thiện dài khoảng 15cm', CAST(N'2018-02-26T00:00:00.000' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (5, N'Mô hình Tàu Trafalgar Law Submarine - One Piece Grand Ship Collection (Plastic model)', 1, N'Hera 7 sừng ', 500000, 1, 1, 18, 0, N'lắp ráp hoàn thiện dài khoảng 15cm', CAST(N'2018-02-26T00:00:00.000' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (6, N'Mô hình lắp ráp Chopper Robo Super No. 1 To 5', 1, N'Hera 7 sừng ', 1000000, 5, 1, 10, 0, N'', CAST(N'2018-02-26T00:00:00.000' AS DateTime), 20, 0, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (9, N'Fate/Grand Order - Berserker/Mysterious Heroine X (Alter)', 1, N'Berserker (バーサーカー, Bāsākā?), Mad Warrior and Heroic Spirit of Berserk Rage, is one of the Four Cavalry Classes among the seven standard Servant classes summoned for the Holy Grail War. Servants placed within this Class are always Heroic Spirits who have gone berserk during battle at least once in their lifetime. This trait allows them to use the special ability Mad Enhancement, which trades their consciousness and sanity for a large power boost. This Class is usually for magi who have summoned Heroic Spirits with insufficient abilities and attributes, allowing them to strengthen their Servants to make up for their lower attributes and compete against stronger opponents. While it is ideal for Servants to reach the level of the Heroic Spirit, the Class allows for their attributes to surpass even the original. If used on an already strong Heroic Spirit, such as Heracles, they will become empowered to truly extraordinary levels. The abuse of this to create powerful Servants has made the Class referred to as the strongest of all seven classes.', 3500000, 3, 1, 273, 0, N'', CAST(N'2018-02-26T00:00:00.000' AS DateTime), 0, 4, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (10, N'Jeanne d''Arc (Alter) - 1/7 - 2nd Ascension (Aniplex)', 3, NULL, 5400000, 1, 1, 4, 0, NULL, CAST(N'2018-02-26T00:00:00.000' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (11, N'Fate/Apocrypha Jeanne d''Arc 1/8 (Alter)', 3, NULL, 4700000, 1, 1, 2, 0, NULL, CAST(N'2018-02-26T00:00:00.000' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (13, N'Miku hot figure in the world', 1, N'Hot figure in the wolrd', 9999999, 1, 1, 1058, 999, N'Full size', CAST(N'2018-02-28T00:00:00.000' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (14, N'Re:Zero kara Hajimeru Isekai Seikatsu - Emilia - 1/7 (Good Smile Company)', 1, N'Re:zero main girl', 20000, 5, 1, 72, 50, N'Full size', CAST(N'2018-02-28T00:00:00.000' AS DateTime), 20, 4, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (18, N'Shippuden Naruto ', 1, N'Shippuden Naruto ', 20000, 4, 1, 0, 0, N'All Size', CAST(N'2018-03-17T12:27:02.563' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (19, N'Re:ZERO - Starting Life in Another World - Ram 1/7', 4, N'"I am Rem''s older sister. That is one thing that can never be taken from me."
From the popular anime series ''Re:ZERO -Starting Life in Another World-'' comes a 1/7th scale figure of the older of the twin maids that serve at the Roswaal mansion - Ram! The figure is based on the 2nd volume of the Blu-ray/DVD jacket cover for the series and features Ram wearing her characteristic maid outfit while holding a deck brush out in her right hand.

Ram is in a more resolute pose when compared to Rem, but her soft-looking lady-like figure has also been faithfully preserved on the figure for fans to enjoy! The base of the figure is specially designed to link together with that of the previously announced 1/7th scale figure of Rem to display the twin sisters together! Be sure to display Ram together with her beloved Rem!', 2600000, 1, 1, 0, 0, N'40cm', CAST(N'2018-03-19T11:05:07.780' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (20, N'Re:ZERO - Starting Life in Another World - Rem 1/7', 4, N'"You''re fanatical like a demon."
From the anime series ''Re:ZERO -Starting Life in Another World-'' comes a 1/7th scale figure of one of the maids that serves at the Roswaal mansion, Rem! The figure is based on the 2nd volume of the Blu-ray/DVD jacket cover and features Rem wearing her characteristic maid outfit holding a tea set on a tray, showing her hard at work in the mansion.

A set of alternate parts to display her in her demon form are also included together with her morning star weapon, allowing you to choose how you prefer to display her in your collection!', 3600000, 1, 1, 0, 0, N'Cao 22.5cm', CAST(N'2018-03-19T11:10:43.973' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (21, N'Re:Zero kara Hajimeru Isekai Seikatsu - Emilia - PM Figure - Natsu no Hi E M T (SEGA)', 2, N'Emilia (エミリア) is the main heroine of the Re:Zero kara Hajimeru Isekai Seikatsu series. She is a Half Elf and a candidate to become the 42nd King of Lugnica.', 500000, 1, 1, 0, 0, N'20cm', CAST(N'2018-03-19T11:14:21.900' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (22, N'Marz Studio - Luffy & Lucy SD Scale', 3, N'Monkey D. Luffy, also known as "Straw Hat Luffy"', 3200000, 3, 1, 0, 0, N'15×16×26CM', CAST(N'2018-03-19T11:24:46.220' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (23, N'[Pre-Order] BBT Studios - Sengoku Golden Buddha SD Resin Statue', 5, N'We do not ship worldwide, sorry about that !', 7000000, 2, 1, 1, 0, N' 39*36*40cm', CAST(N'2018-03-19T11:28:35.677' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (24, N'F3 Studios - Charlotte Linlin Big Mama Resin Statue', 5, N'Charlotte Linlin (シャーロット・リンリン Shārotto Rinrin), còn được biết đến với cái tên Big Mom (ビッグ・マム Biggu Mamu). Là “Tứ hoàng” cuối cùng được nói tên ra. Danh hiệu của bà được nói ra sau trận chiến tại “Tổng bộ hải quân”và cái chết của “Tứ hoàng” Râu Trắng. Tên thật của bà được đề cập lần đầu bởi Pappug.', 6500000, 1, 1, 0, 0, N'Cao 24cm', CAST(N'2018-03-19T11:31:15.767' AS DateTime), 0, 0, 0, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (25, N'F3-Studio - Yonkou Kaido SD Scale Resin Statue', 5, N'Kaido có biệt danh là "Kaido bách thú". Theo Law, Kaido được gọi là "sinh vật mạnh nhất thế giới".

Kaido được biết đến là một hải tặc tàn nhẫn và liều lĩnh, không bao giờ bỏ lỡ cơ hội hạ gục đối thủ, bằng chứng là hắn đã lên kế hoạch tấn công WB khi biết WB đang trên đường cứu Ace. Tuy nhiên, kế hoạch của hắn đã bị Shanks ngăn chặn trước khi gặp được WB. Doflamingo là Vua của một vương quốc, vừa là TVH, và khả năng rất cao là con cháu của Thiên Long Hội cũng phải khiếp sợ trước Kaido đủ biết hắn đáng sợ như thế nào.', 6000000, 4, 1, 1, 0, N'24cm', CAST(N'2018-03-19T11:33:32.957' AS DateTime), 0, 0, 1, NULL)
INSERT [dbo].[Products] ([Id], [Name], [ManufactorID], [Description], [Price], [StatusID], [CategoryID], [_View], [OrderCounter], [Size], [DateCreated], [SaleRate], [Rate], [isDelete], [ModifiedDate]) VALUES (26, N'Sword Art Online II - Sinon - Special Figure - ALO (FuRyu)', 1, N'Sword Art Online Series', 500000, 1, 1, 4, 0, N'All Size', CAST(N'2018-03-25T19:18:01.637' AS DateTime), 0, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[ProductTags] ON 

INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (1, 9, 1)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (2, 9, 2)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (3, 9, 3)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (4, 1, 4)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (5, 4, 4)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (6, 5, 6)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (7, 6, 6)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (8, 10, 1)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (9, 11, 1)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (10, 14, 5)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (11, 13, 6)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (12, 9, 21)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (13, 5, 9)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (14, 5, 10)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (15, 13, 22)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (16, 18, 11)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (17, 19, 5)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (18, 20, 5)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (19, 21, 5)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (20, 22, 10)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (21, 23, 10)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (22, 24, 10)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (23, 25, 10)
INSERT [dbo].[ProductTags] ([Id], [ProductID], [TagID]) VALUES (24, 26, 23)
SET IDENTITY_INSERT [dbo].[ProductTags] OFF
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'Admin', N'Admin')
INSERT [dbo].[Roles] ([Id], [Name]) VALUES (N'User', N'User')
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([Id], [Status_String]) VALUES (1, N'Còn hàng')
INSERT [dbo].[Status] ([Id], [Status_String]) VALUES (2, N'Hết hàng')
INSERT [dbo].[Status] ([Id], [Status_String]) VALUES (3, N'Sắp có')
INSERT [dbo].[Status] ([Id], [Status_String]) VALUES (4, N'Hàng Pre-order')
INSERT [dbo].[Status] ([Id], [Status_String]) VALUES (5, N'Sale')
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[Tags] ON 

INSERT [dbo].[Tags] ([Id], [Name]) VALUES (1, N'Fate Stay Night')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (2, N'Mysterious Heroine X')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (3, N'Berserker')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (4, N'Mô hình tàu lắp ráp')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (5, N'Re:Zero')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (6, N'Miku')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (7, N'Pokemon')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (8, N'Doraemon')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (9, N'Dragon Ball')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (10, N'One Piece')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (11, N'Naruto')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (12, N'Attack on Titan')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (13, N'Fairy Tail')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (14, N'Kuroko no Basket')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (15, N'No Game No Life')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (16, N'Yugi-Oh')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (17, N'Date Alive')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (18, N'One Punch Man')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (19, N'Swort Art Online')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (20, N'Other')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (21, N'Saber')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (22, N'Hot Figure')
INSERT [dbo].[Tags] ([Id], [Name]) VALUES (23, N'Sword Art Online')
SET IDENTITY_INSERT [dbo].[Tags] OFF
SET IDENTITY_INSERT [dbo].[Types] ON 

INSERT [dbo].[Types] ([Id], [Name]) VALUES (1, N'Figure')
INSERT [dbo].[Types] ([Id], [Name]) VALUES (2, N'Móc khóa')
SET IDENTITY_INSERT [dbo].[Types] OFF
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'0be5f76b-85d0-4c7b-bd3b-28b51e09e6e9', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'10e64f20-7b72-45ba-b453-b059eb4036f5', N'Admin', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'1c46b98a-b14e-4ebf-b9f3-57fb1ad5ffd1', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'2a9bfb5c-0369-4530-bf79-a84c0f0db27f', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'8871336d-d74f-40ac-a1a5-b326e7456171', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'd038260f-7abb-42a7-a9e6-a3caa293eadf', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'de697c60-80d7-41f1-aedd-f79c4a4a8028', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'e218021f-d3d6-42f0-a874-3d2debaa2ba3', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'e92aa57e-364e-4f65-a648-4c8b20d2ca66', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'eeb5d694-1c71-456c-8439-999d822fd07d', N'User', NULL)
INSERT [dbo].[UserRoles] ([UserId], [RoleId], [IdentityUser_Id]) VALUES (N'fcc22d71-5995-470e-ba8a-4e511b02bad0', N'User', NULL)
SET IDENTITY_INSERT [dbo].[WebsiteAttributes] ON 

INSERT [dbo].[WebsiteAttributes] ([id], [name], [email], [address], [country], [city], [district], [phone], [location], [logo], [time_open], [description]) VALUES (1, N'Otaku Store', NULL, N'1/160a4 Nguyễn Văn Quá, P.Đông Hưng Thuận', N'Việt Nam', N'Hồ Chí Minh', N'12', N'0909217723', N'10.8391392,106.6337668', N'/Content/Images/BG/header.png', NULL, N'Công ty TNHH chuyên phân phối sỉ và lẻ các loại Figure nhập khẩu từ Nhật Bản. Cam kết sản phẩm đạt chuẩn ISO9001 và được bộ y tế thẩm định và cấp phép.')
SET IDENTITY_INSERT [dbo].[WebsiteAttributes] OFF
SET IDENTITY_INSERT [dbo].[WishLists] ON 

INSERT [dbo].[WishLists] ([Id], [UserID], [ProductID]) VALUES (40, N'1c46b98a-b14e-4ebf-b9f3-57fb1ad5ffd1', 14)
INSERT [dbo].[WishLists] ([Id], [UserID], [ProductID]) VALUES (41, N'1c46b98a-b14e-4ebf-b9f3-57fb1ad5ffd1', 9)
INSERT [dbo].[WishLists] ([Id], [UserID], [ProductID]) VALUES (42, N'1c46b98a-b14e-4ebf-b9f3-57fb1ad5ffd1', 13)
SET IDENTITY_INSERT [dbo].[WishLists] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 3/25/2018 7:25:52 PM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_Accounts] FOREIGN KEY([UserId])
REFERENCES [dbo].[Accounts] ([UserId])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_Accounts]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Accounts] FOREIGN KEY([UserID])
REFERENCES [dbo].[Accounts] ([UserId])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Accounts]
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_Images_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_Images_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserClaims_Accounts] FOREIGN KEY([IdentityUser_Id])
REFERENCES [dbo].[Accounts] ([UserId])
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_UserClaims_Accounts]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Accounts] FOREIGN KEY([UserId])
REFERENCES [dbo].[Accounts] ([UserId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Accounts]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 3/25/2018 7:25:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
USE [master]
GO
ALTER DATABASE [OtakuStore] SET  READ_WRITE 
GO
