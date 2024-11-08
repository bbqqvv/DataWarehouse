USE [master]
GO
/****** Object:  Database [SSIS_DATAWAREHOUSE]    Script Date: 11/8/2024 4:21:26 PM ******/
CREATE DATABASE [SSIS_DATAWAREHOUSE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SSIS_DATAWAREHOUSE', FILENAME = N'D:\Program Files - Study\SQLServer\MSSQL16.MSSQLSERVER\MSSQL\DATA\SSIS_DATAWAREHOUSE.mdf' , SIZE = 729088KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SSIS_DATAWAREHOUSE_log', FILENAME = N'D:\Program Files - Study\SQLServer\MSSQL16.MSSQLSERVER\MSSQL\DATA\SSIS_DATAWAREHOUSE_log.ldf' , SIZE = 1056768KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SSIS_DATAWAREHOUSE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ARITHABORT OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET RECOVERY FULL 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET  MULTI_USER 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SSIS_DATAWAREHOUSE', N'ON'
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET QUERY_STORE = ON
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SSIS_DATAWAREHOUSE]
GO
/****** Object:  User [NT SERVICE\MSOLAP$VANBUI]    Script Date: 11/8/2024 4:21:26 PM ******/
CREATE USER [NT SERVICE\MSOLAP$VANBUI] FOR LOGIN [NT SERVICE\MSOLAP$VANBUI] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT SERVICE\MSOLAP$VANBUI]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT SERVICE\MSOLAP$VANBUI]
GO
/****** Object:  Table [dbo].[Actual_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actual_Dim](
	[flight_id] [varchar](255) NULL,
	[actual_date] [date] NULL,
	[actual_key] [varchar](50) NOT NULL,
	[actualDeparture] [datetime] NULL,
	[actualArrival] [datetime] NULL,
	[actual_duration]  AS (datediff(minute,[actualDeparture],[actualArrival])) PERSISTED,
	[delay] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[actual_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airline_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airline_Dim](
	[airline_code] [varchar](100) NOT NULL,
	[airline_name] [varchar](255) NULL,
	[country] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[airline_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Date_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Date_Dim](
	[date] [date] NOT NULL,
	[year] [int] NOT NULL,
	[quarter] [int] NOT NULL,
	[month] [int] NOT NULL,
	[day] [int] NOT NULL,
	[week_of_year] [int] NOT NULL,
	[lookup_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Destination_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destination_Dim](
	[desGeocoded_City] [varchar](255) NOT NULL,
	[desairport_id] [int] NULL,
	[descity_name] [varchar](255) NULL,
	[desairport_name] [varchar](255) NULL,
	[country] [varchar](100) NULL,
	[full_destination_location]  AS (([descity_name]+' - ')+[desairport_name]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[desGeocoded_City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fare_fact]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fare_fact](
	[fare_key] [varchar](255) NOT NULL,
	[flight_id] [varchar](255) NULL,
	[fare] [float] NULL,
	[passengers] [int] NULL,
	[carrier_low] [varchar](255) NULL,
	[carrier_lg] [varchar](255) NULL,
	[total_revenue]  AS ([fare]*[passengers]) PERSISTED,
	[date_fare] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[fare_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Farelg_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Farelg_Dim](
	[carrier_lg] [varchar](255) NOT NULL,
	[lf_ms] [float] NULL,
	[fare_lg] [float] NULL,
	[passengers] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[carrier_lg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Farelow_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Farelow_Dim](
	[carrier_low] [varchar](255) NOT NULL,
	[lf_ms] [float] NULL,
	[fare_low] [float] NULL,
	[passengers] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[carrier_low] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flight_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight_Dim](
	[flight_id] [varchar](255) NOT NULL,
	[airline_code] [varchar](100) NULL,
	[tailNumber] [varchar](255) NULL,
	[aircraftType] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[flight_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Origin_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Origin_Dim](
	[originGeocoded_City] [varchar](255) NOT NULL,
	[originairport_id] [int] NULL,
	[origincity_name] [varchar](255) NULL,
	[originairport_name] [varchar](255) NULL,
	[country] [varchar](100) NULL,
	[full_origin_location]  AS (([origincity_name]+' - ')+[originairport_name]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[originGeocoded_City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Route_fact]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Route_fact](
	[route_key] [varchar](100) NOT NULL,
	[desGeocoded_City] [varchar](255) NULL,
	[schedule_date] [date] NULL,
	[flight_id] [varchar](255) NULL,
	[originGeocoded_City] [varchar](255) NULL,
	[distance] [float] NULL,
	[cancellationReason] [varchar](255) NULL,
	[cancelled] [bit] NULL,
	[diverted] [bit] NULL,
	[delayArrival] [int] NULL,
	[delayDeparture] [int] NULL,
	[total_delay]  AS ([delayArrival]+[delayDeparture]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[route_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule_Dim](
	[schedule_id] [int] NOT NULL,
	[scheduledDeparture] [datetime] NULL,
	[scheduledArrival] [datetime] NULL,
	[schedule_date] [date] NULL,
	[scheduled_duration]  AS (datediff(minute,[scheduledDeparture],[scheduledArrival])) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Time_Dim]    Script Date: 11/8/2024 4:21:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Time_Dim](
	[time_key] [varchar](200) NOT NULL,
	[taxin] [int] NULL,
	[taxiOut] [int] NULL,
	[schedule_date] [date] NULL,
	[actual_key] [varchar](50) NULL,
	[hour] [int] NULL,
	[minute] [int] NULL,
	[second] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[time_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Actual_Dim]  WITH CHECK ADD  CONSTRAINT [FK_Actual_Dim_Flight_Dim] FOREIGN KEY([flight_id])
REFERENCES [dbo].[Flight_Dim] ([flight_id])
GO
ALTER TABLE [dbo].[Actual_Dim] CHECK CONSTRAINT [FK_Actual_Dim_Flight_Dim]
GO
ALTER TABLE [dbo].[Fare_fact]  WITH CHECK ADD FOREIGN KEY([carrier_low])
REFERENCES [dbo].[Farelow_Dim] ([carrier_low])
GO
ALTER TABLE [dbo].[Fare_fact]  WITH CHECK ADD FOREIGN KEY([carrier_lg])
REFERENCES [dbo].[Farelg_Dim] ([carrier_lg])
GO
ALTER TABLE [dbo].[Fare_fact]  WITH CHECK ADD FOREIGN KEY([flight_id])
REFERENCES [dbo].[Flight_Dim] ([flight_id])
GO
ALTER TABLE [dbo].[Fare_fact]  WITH CHECK ADD  CONSTRAINT [FK_Fare_fact_Date_Dim1] FOREIGN KEY([date_fare])
REFERENCES [dbo].[Date_Dim] ([date])
GO
ALTER TABLE [dbo].[Fare_fact] CHECK CONSTRAINT [FK_Fare_fact_Date_Dim1]
GO
ALTER TABLE [dbo].[Flight_Dim]  WITH CHECK ADD  CONSTRAINT [FK_Flight_Dim_Airline_Dim] FOREIGN KEY([airline_code])
REFERENCES [dbo].[Airline_Dim] ([airline_code])
GO
ALTER TABLE [dbo].[Flight_Dim] CHECK CONSTRAINT [FK_Flight_Dim_Airline_Dim]
GO
ALTER TABLE [dbo].[Route_fact]  WITH NOCHECK ADD FOREIGN KEY([desGeocoded_City])
REFERENCES [dbo].[Destination_Dim] ([desGeocoded_City])
GO
ALTER TABLE [dbo].[Route_fact]  WITH NOCHECK ADD FOREIGN KEY([originGeocoded_City])
REFERENCES [dbo].[Origin_Dim] ([originGeocoded_City])
GO
ALTER TABLE [dbo].[Route_fact]  WITH NOCHECK ADD FOREIGN KEY([schedule_date])
REFERENCES [dbo].[Date_Dim] ([date])
GO
ALTER TABLE [dbo].[Route_fact]  WITH NOCHECK ADD  CONSTRAINT [FK_Route_fact_Flight_Dim1] FOREIGN KEY([flight_id])
REFERENCES [dbo].[Flight_Dim] ([flight_id])
GO
ALTER TABLE [dbo].[Route_fact] CHECK CONSTRAINT [FK_Route_fact_Flight_Dim1]
GO
ALTER TABLE [dbo].[Schedule_Dim]  WITH NOCHECK ADD FOREIGN KEY([schedule_date])
REFERENCES [dbo].[Date_Dim] ([date])
GO
ALTER TABLE [dbo].[Time_Dim]  WITH NOCHECK ADD FOREIGN KEY([actual_key])
REFERENCES [dbo].[Actual_Dim] ([actual_key])
GO
ALTER TABLE [dbo].[Time_Dim]  WITH NOCHECK ADD FOREIGN KEY([schedule_date])
REFERENCES [dbo].[Date_Dim] ([date])
GO
USE [master]
GO
ALTER DATABASE [SSIS_DATAWAREHOUSE] SET  READ_WRITE 
GO
