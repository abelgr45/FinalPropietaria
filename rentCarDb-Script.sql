USE [master]
GO
/****** Object:  Database [rentCar]    Script Date: 10/03/2019 10:45:59 AM ******/
CREATE DATABASE [rentCar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'rentCar', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.LOCALBLADE\MSSQL\DATA\rentCar.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'rentCar_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.LOCALBLADE\MSSQL\DATA\rentCar_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [rentCar] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [rentCar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [rentCar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [rentCar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [rentCar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [rentCar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [rentCar] SET ARITHABORT OFF 
GO
ALTER DATABASE [rentCar] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [rentCar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [rentCar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [rentCar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [rentCar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [rentCar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [rentCar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [rentCar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [rentCar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [rentCar] SET  DISABLE_BROKER 
GO
ALTER DATABASE [rentCar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [rentCar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [rentCar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [rentCar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [rentCar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [rentCar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [rentCar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [rentCar] SET RECOVERY FULL 
GO
ALTER DATABASE [rentCar] SET  MULTI_USER 
GO
ALTER DATABASE [rentCar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [rentCar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [rentCar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [rentCar] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [rentCar] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'rentCar', N'ON'
GO
ALTER DATABASE [rentCar] SET QUERY_STORE = OFF
GO
USE [rentCar]
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
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [rentCar]
GO
/****** Object:  Table [dbo].[Renta]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Renta](
	[IdRenta] [int] IDENTITY(1,1) NOT NULL,
	[IdVehiculo] [int] NOT NULL,
	[IdCliente] [int] NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[FechaRenta] [datetime] NOT NULL,
	[DetalleRenta] [varchar](100) NOT NULL,
	[FechaDevolucion] [varchar](30) NULL,
	[montopordia] [money] NULL,
	[CantidadDias] [int] NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Renta] PRIMARY KEY CLUSTERED 
(
	[IdRenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vehiculos]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vehiculos](
	[IdVehiculos] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[IdMarca] [int] NOT NULL,
	[IdTipoVehiculo] [int] NOT NULL,
	[IdCombustible] [int] NOT NULL,
	[nochasis] [varchar](30) NULL,
	[nomotor] [varchar](30) NULL,
	[noplaca] [varchar](30) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_vehiculos] PRIMARY KEY CLUSTERED 
(
	[IdVehiculos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VehiculosRentados]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VehiculosRentados]
AS
SELECT        dbo.Renta.IdRenta, dbo.vehiculos.Nombre AS nombreVehiculo, dbo.Renta.estado, dbo.vehiculos.IdVehiculos
FROM            dbo.Renta INNER JOIN
                         dbo.vehiculos ON dbo.Renta.IdVehiculo = dbo.vehiculos.IdVehiculos
GO
/****** Object:  Table [dbo].[tiposDeCombustible]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tiposDeCombustible](
	[IdCombustible] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_tiposDeCombustible] PRIMARY KEY CLUSTERED 
(
	[IdCombustible] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[numeroTelefono] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NOT NULL,
	[cedula] [varchar](11) NULL,
	[noTarjetaCr] [varchar](30) NULL,
	[LimiteCredito] [money] NULL,
	[TipoPersona] [varchar](10) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modelo]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modelo](
	[IdModelo] [int] IDENTITY(0,1) NOT NULL,
	[IdMarca] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdModelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marcas](
	[IdMarca] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Reporte]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Reporte]
AS
SELECT        dbo.Renta.FechaRenta, dbo.Renta.DetalleRenta, dbo.vehiculos.Nombre AS NombreVehiculo, dbo.Modelo.Nombre AS Modelo, dbo.Marcas.Nombre AS Marca, dbo.tiposDeCombustible.Nombre AS Combustible, 
                         dbo.Clientes.Nombre AS Cliente
FROM            dbo.Clientes INNER JOIN
                         dbo.Renta ON dbo.Clientes.IdCliente = dbo.Renta.IdCliente CROSS JOIN
                         dbo.Marcas INNER JOIN
                         dbo.vehiculos ON dbo.Marcas.IdMarca = dbo.vehiculos.IdMarca INNER JOIN
                         dbo.Modelo ON dbo.Marcas.IdMarca = dbo.Modelo.IdMarca INNER JOIN
                         dbo.tiposDeCombustible ON dbo.vehiculos.IdCombustible = dbo.tiposDeCombustible.IdCombustible
GO
/****** Object:  Table [dbo].[TipoVehiculo]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoVehiculo](
	[IdTipoVehiculo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_TipoVehiculo] PRIMARY KEY CLUSTERED 
(
	[IdTipoVehiculo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Reportevehiculos]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Reportevehiculos]
AS
SELECT        dbo.vehiculos.Nombre AS Vehiculo, dbo.tiposDeCombustible.Nombre AS Combustible, dbo.Marcas.Nombre AS Marca, dbo.TipoVehiculo.Nombre AS TipoVehiculo, dbo.Renta.DetalleRenta, dbo.Renta.FechaRenta, 
                         dbo.Clientes.Nombre AS Cliente
FROM            dbo.vehiculos INNER JOIN
                         dbo.Renta ON dbo.vehiculos.IdVehiculos = dbo.Renta.IdVehiculo INNER JOIN
                         dbo.tiposDeCombustible ON dbo.vehiculos.IdCombustible = dbo.tiposDeCombustible.IdCombustible INNER JOIN
                         dbo.Marcas ON dbo.vehiculos.IdMarca = dbo.Marcas.IdMarca INNER JOIN
                         dbo.Clientes ON dbo.Renta.IdCliente = dbo.Clientes.IdCliente INNER JOIN
                         dbo.TipoVehiculo ON dbo.vehiculos.IdTipoVehiculo = dbo.TipoVehiculo.IdTipoVehiculo
GO
/****** Object:  Table [dbo].[Devolucion]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Devolucion](
	[IdDevolucion] [int] NOT NULL,
	[IdRenta] [int] NOT NULL,
	[detallesDevolucion] [varchar](50) NOT NULL,
	[fechaDevolucion] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 10/03/2019 10:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Decision] [varchar](50) NOT NULL,
	[numeroTelefono] [varchar](50) NOT NULL,
	[cedula] [varchar](11) NULL,
	[tandaLaboral] [varchar](30) NULL,
	[porcientocomision] [int] NULL,
	[fechaingreso] [datetime] NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estados]    Script Date: 10/03/2019 10:46:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estados](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](10) NULL,
	[value] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[procesoInspeccion]    Script Date: 10/03/2019 10:46:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[procesoInspeccion](
	[IdInspeccion] [int] IDENTITY(1,1) NOT NULL,
	[IdVehiculo] [int] NOT NULL,
	[detalleInspeccion] [varchar](50) NOT NULL,
	[tieneRalladura] [bit] NULL,
	[CantidadCombustible] [varchar](50) NULL,
	[TieneGomarepuesta] [bit] NULL,
	[TieneGato] [bit] NULL,
	[TieneRoturasCristal] [bit] NULL,
	[estadoGoma] [varchar](50) NULL,
	[Fecha] [datetime] NULL,
	[idempleado] [int] NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_procesoInspeccion] PRIMARY KEY CLUSTERED 
(
	[IdInspeccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Modelo]  WITH NOCHECK ADD  CONSTRAINT [Modelo_fk] FOREIGN KEY([IdMarca])
REFERENCES [dbo].[Marcas] ([IdMarca])
GO
ALTER TABLE [dbo].[Modelo] CHECK CONSTRAINT [Modelo_fk]
GO
ALTER TABLE [dbo].[procesoInspeccion]  WITH CHECK ADD  CONSTRAINT [FK_procesoInspeccion_Empleado] FOREIGN KEY([IdInspeccion])
REFERENCES [dbo].[Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[procesoInspeccion] CHECK CONSTRAINT [FK_procesoInspeccion_Empleado]
GO
ALTER TABLE [dbo].[procesoInspeccion]  WITH CHECK ADD  CONSTRAINT [FK_procesoInspeccion_vehiculos] FOREIGN KEY([IdVehiculo])
REFERENCES [dbo].[vehiculos] ([IdVehiculos])
GO
ALTER TABLE [dbo].[procesoInspeccion] CHECK CONSTRAINT [FK_procesoInspeccion_vehiculos]
GO
ALTER TABLE [dbo].[Renta]  WITH CHECK ADD  CONSTRAINT [Renta_fk] FOREIGN KEY([IdVehiculo])
REFERENCES [dbo].[vehiculos] ([IdVehiculos])
GO
ALTER TABLE [dbo].[Renta] CHECK CONSTRAINT [Renta_fk]
GO
ALTER TABLE [dbo].[tiposDeCombustible]  WITH CHECK ADD  CONSTRAINT [FK_tiposDeCombustible_tiposDeCombustible1] FOREIGN KEY([IdCombustible])
REFERENCES [dbo].[tiposDeCombustible] ([IdCombustible])
GO
ALTER TABLE [dbo].[tiposDeCombustible] CHECK CONSTRAINT [FK_tiposDeCombustible_tiposDeCombustible1]
GO
ALTER TABLE [dbo].[vehiculos]  WITH NOCHECK ADD  CONSTRAINT [vehiculos_fk] FOREIGN KEY([IdMarca])
REFERENCES [dbo].[Marcas] ([IdMarca])
GO
ALTER TABLE [dbo].[vehiculos] CHECK CONSTRAINT [vehiculos_fk]
GO
ALTER TABLE [dbo].[vehiculos]  WITH CHECK ADD  CONSTRAINT [vehiculos_fk2] FOREIGN KEY([IdTipoVehiculo])
REFERENCES [dbo].[TipoVehiculo] ([IdTipoVehiculo])
GO
ALTER TABLE [dbo].[vehiculos] CHECK CONSTRAINT [vehiculos_fk2]
GO
ALTER TABLE [dbo].[vehiculos]  WITH CHECK ADD  CONSTRAINT [vehiculos_fk3] FOREIGN KEY([IdCombustible])
REFERENCES [dbo].[tiposDeCombustible] ([IdCombustible])
GO
ALTER TABLE [dbo].[vehiculos] CHECK CONSTRAINT [vehiculos_fk3]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Renta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "vehiculos"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Modelo"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 119
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Marcas"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 102
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tiposDeCombustible"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 102
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Clientes"
            Begin Extent = 
               Top = 6
               Left = 1078
               Bottom = 136
               Right = 1256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Reporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Reporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Reporte'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vehiculos"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Renta"
            Begin Extent = 
               Top = 227
               Left = 387
               Bottom = 357
               Right = 557
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tiposDeCombustible"
            Begin Extent = 
               Top = 228
               Left = 89
               Bottom = 324
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Marcas"
            Begin Extent = 
               Top = 37
               Left = 360
               Bottom = 133
               Right = 530
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Clientes"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 136
               Right = 1048
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TipoVehiculo"
            Begin Extent = 
               Top = 6
               Left = 568
               Bottom = 102
               Right = 738
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Reportevehiculos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Reportevehiculos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Reportevehiculos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Renta"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "vehiculos"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 136
               Right = 426
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VehiculosRentados'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VehiculosRentados'
GO
USE [master]
GO
ALTER DATABASE [rentCar] SET  READ_WRITE 
GO
