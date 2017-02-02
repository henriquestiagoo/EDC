CREATE TABLE [dbo].[Movies] (
    [Id]                INT            NOT NULL,
    [PTName]            NVARCHAR (MAX) NOT NULL,
    [ENName]            NVARCHAR (MAX) NOT NULL,
    [Genre]             NVARCHAR (50)  NULL,
    [Rating]            NVARCHAR (50)  NULL,
    [ProductionCountry] NVARCHAR (50)  NULL,
    [Year]              NVARCHAR (50)  NULL,
    [OfficialURL]       NVARCHAR (MAX) NULL,
    [BigImage]          NVARCHAR (MAX) NULL,
    [SmallImage]        NVARCHAR (MAX) NULL,
    [Actors]            NVARCHAR (MAX) NULL,
    [Directors]         NVARCHAR (MAX) NULL,
    [Argument]          NVARCHAR (MAX) NULL,
    [Synopsis]          NVARCHAR (MAX) NULL,
    [Distributor]       NVARCHAR (MAX) NULL,
    [About]             XML (DOCUMENT [dbo].[AboutSCHEMA]) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

