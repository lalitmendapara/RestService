USE [master]
GO
/****** Object:  Database [RestServiceDB]    Script Date: 02-08-2019 04:27:51 PM ******/

CREATE DATABASE [RestServiceDB]
GO
USE [RestServiceDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_WordCount]    Script Date: 02-08-2019 04:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author       : Aspire
-- Create date  : 02-08-2019
 --Description  : Rest ServiceMessage Table Insert and return total count Value
 --Modified date: 02-08-2019
-- =============================================
CREATE FUNCTION [dbo].[fn_WordCount] ( @Param nvarchar(max) )   
RETURNS INT  
AS  
BEGIN  
DECLARE @Index          INT  
DECLARE @Char           CHAR(1)  
DECLARE @PrevChar       CHAR(1)  
DECLARE @WordCount      INT  
SET @Index = 1  
SET @WordCount = 0  
  
WHILE @Index <= LEN(@Param)  
BEGIN  
    SET @Char     = SUBSTRING(@Param, @Index, 1)  
    SET @PrevChar = CASE WHEN @Index = 1 THEN ' '  
                         ELSE SUBSTRING(@Param, @Index - 1, 1)  
                    END  
  
    IF @PrevChar = ' ' AND @Char != ' '  
        SET @WordCount = @WordCount + 1  
  
    SET @Index = @Index + 1  
END  
RETURN @WordCount  
END 
GO
/****** Object:  Table [dbo].[ServiceMessage]    Script Date: 02-08-2019 04:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceMessage](
	[Id] [int] NOT NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_ServiceMessage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[USP_ServiceMessage]    Script Date: 02-08-2019 04:27:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author       : Aspire
-- Create date  : 02-08-2019
 --Description  : Rest ServiceMessage Table Insert and return total count Value
 --Modified date: 02-08-2019
-- =============================================
CREATE PROCEDURE [dbo].[USP_ServiceMessage] --1,'test123'
(	
	@Id int=null ,
	@Message nvarchar(MAX)=null,
    @TotalCount int OUTPUT
)AS
BEGIN
	 SET  NOCOUNT  ON;
	 BEGIN
	 TRAN ServiceMessageTrans 
   BEGIN
      TRY 
	   IF Not Exists(SELECT Id from ServiceMessage WHERE Id=@Id)
	   BEGIN 
	   INSERT INTO dbo.ServiceMessage(Id,Message)VALUES(@Id,@Message)	   
	   END	  

	  SET @TotalCount=(SELECT SUM([dbo].[fn_WordCount](ServiceMessage.Message)) as MessageCount  from ServiceMessage)	 
	  COMMIT TRANSACTION ServiceMessageTrans 
	   END
   TRY 
   BEGIN
      CATCH ROLLBACK TRAN ServiceMessageTrans 
   END
   CATCH 
END
GO
USE [master]
GO
ALTER DATABASE [RestServiceDB] SET  READ_WRITE 
GO
