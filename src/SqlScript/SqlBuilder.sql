USE ZZ_DEVICES
GO

declare @TableName varchar(max)  = 'provider'


/*
SELECT 

'Columns.Add("' + COLUMN_NAME + '");',
'Values.Add(MedicineProduct.' + COLUMN_NAME + ');',


 '@'+COLUMN_NAME+' '+DATA_TYPE+CASE WHEN DATA_TYPE='VARCHAR' THEN ' (' ELSE ''END+ISNULL(CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR),'')+ CASE WHEN DATA_TYPE='VARCHAR' THEN '),' ELSE ','END,
 COLUMN_NAME+',',
 COLUMN_NAME ,
 '"' + COLUMN_NAME+', " & _',
 '@'+COLUMN_NAME+',',
 COLUMN_NAME + ' = @'+COLUMN_NAME+',',
 '.Parameters.AddWithValue("@'+COLUMN_NAME+'", '+COLUMN_NAME+')',
 '@'+COLUMN_NAME+' As '+CASE WHEN DATA_TYPE='VARCHAR' THEN 'String, _' WHEN DATA_TYPE = 'INT' THEN 'Integer, _' WHEN DATA_TYPE = 'BIT' THEN 'Boolean, _' WHEN DATA_TYPE = 'DATETIME' THEN 'DateTime, _' WHEN DATA_TYPE = 'NVARCHAR' THEN 'String, _'  WHEN DATA_TYPE = 'FLOAT' THEN 'Decimal, _' END,
 'Byval '+COLUMN_NAME+' As '+CASE WHEN DATA_TYPE='VARCHAR' THEN 'String, _' WHEN DATA_TYPE = 'INT' THEN 'Integer, _' WHEN DATA_TYPE = 'BIT' THEN 'Boolean, _' WHEN DATA_TYPE = 'DATETIME' THEN 'DateTime, _'  WHEN DATA_TYPE = 'NVARCHAR' THEN 'String, _'  WHEN DATA_TYPE = 'FLOAT' THEN 'Decimal, _' END,
 'new SqlParameter("'+COLUMN_NAME+'", _Record.'+COLUMN_NAME+'),',
 'currCC.'+CASE WHEN DATA_TYPE='VARCHAR' THEN 'enterTextField(' WHEN DATA_TYPE = 'INT' THEN 'enterTextField(' WHEN DATA_TYPE = 'BIT' THEN 'enterCheckField(' WHEN DATA_TYPE = 'DATETIME' THEN 'enterDateField('  WHEN DATA_TYPE = 'NVARCHAR' THEN 'enterTextField(' END + 'txt_'+COLUMN_NAME+',"'+COLUMN_NAME+'",r)',
 '_Record.Add("'+COLUMN_NAME+'", _DR_DataRow["'+COLUMN_NAME+'"].ToString());',
 '_Record.'+COLUMN_NAME+' = $('''+COLUMN_NAME+''').val(); ',
 'sb.Append("<td>" + _DR_DataRow["'+COLUMN_NAME+'"].ToString() + "</td>");',
 'sb.Append("<th>'+COLUMN_NAME+'</th>");',
 '$(''#_txt_'+COLUMN_NAME+''').val(result['''+COLUMN_NAME+''']);',
 'txt_'+COLUMN_NAME+'.Text, _',
 'ddl_'+COLUMN_NAME+'.SelectedValue, _',

 'public static final String COLUMN_VFL_'+COLUMN_NAME+' = "'+COLUMN_NAME+'";',


 'Columns.Add("'+COLUMN_NAME+'");' + ' Values.Add(_Model.'+COLUMN_NAME+');'


FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName
*/




 
declare @Result varchar(max) = 'public class ' + @TableName + '
{'

select @Result = @Result + '
    /// <summary>
    /// ' + replace(ColumnName, '_', ' ') + '
    /// </summary>
    [Display(Name = "' + replace(ColumnName, '_', ' ') + '")]
    [DbColumn("' + ColumnName + '")]
    [DataMember(Name = "' + ColumnName + '")]
    [DataType(DataType.' + DataType + ')]
    [StringLength(3000, MinimumLength = 3, ErrorMessage = "* The field is is not the correct length")]
    [DisplayFormat(ConvertEmptyStringToNull = false)]
    [Required(ErrorMessage = "* Is a required field")]
    public ' + ColumnType + NullableSign + ' ' + replace(ColumnName, '_', ' ') + ' { get; set; }
'
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        case typ.name 
            when 'bigint' then 'long'
            when 'binary' then 'byte[]'
            when 'bit' then 'bool'
            when 'char' then 'string'
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTimeOffset'
            when 'decimal' then 'decimal'
            when 'float' then 'double'
            when 'image' then 'byte[]'
            when 'int' then 'int'
            when 'money' then 'decimal'
            when 'nchar' then 'string'
            when 'ntext' then 'string'
            when 'numeric' then 'decimal'
            when 'nvarchar' then 'string'
            when 'real' then 'float'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'short'
            when 'smallmoney' then 'decimal'
            when 'text' then 'string'
            when 'time' then 'TimeSpan'
            when 'timestamp' then 'long'
            when 'tinyint' then 'byte'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'byte[]'
            when 'varchar' then 'string'
            else 'UNKNOWN_' + typ.name
        end ColumnType,
        case typ.name 
            when 'bigint' then 'Text'
            when 'binary' then 'Text'
            when 'bit' then 'Text'
            when 'char' then 'Text'
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTime'
            when 'decimal' then 'Text'
            when 'float' then 'Text'
            when 'image' then 'Text'
            when 'int' then 'Text'
            when 'money' then 'Text'
            when 'nchar' then 'Text'
            when 'ntext' then 'Text'
            when 'numeric' then 'Text'
            when 'nvarchar' then 'Text'
            when 'real' then 'Text'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'Text'
            when 'smallmoney' then 'Text'
            when 'text' then 'Text'
            when 'time' then 'Text'
            when 'timestamp' then 'Text'
            when 'tinyint' then 'Text'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'Text'
            when 'varchar' then 'Text'
            else 'UNKNOWN_' + typ.name
        end DataType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            then '?' 
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId

set @Result = @Result  + '
}'


PRINT '


--############################################################################################################################'
PRINT '--## C# Class  ##'
PRINT '--############################################################################################################################'

print @Result
 


 



declare @INSERTResult varchar(max)  = 'CREATE PROCEDURE SP_' + UPPER(@TableName) + '_INSERT 
'

declare @INSERTResult2 varchar(max)  = '

AS

INSERT INTO ' + @TableName + ' 
( '



declare @INSERTResult3 varchar(max)  = '

) VALUES ( 
'



declare @INSERTResult4 varchar(max)  = '
); 

SELECT SCOPE_IDENTITY();

'


 

select @INSERTResult = @INSERTResult + '
    @' + ColumnName + + ' ' + ColumnType + ','
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        typ.name ColumnType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            then '?' 
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId


select @INSERTResult2 = @INSERTResult2 + '
    ' + ColumnName + ','
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        case typ.name 
            when 'bigint' then 'long'
            when 'binary' then 'byte[]'
            when 'bit' then 'bool'
            when 'char' then 'string'
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTimeOffset'
            when 'decimal' then 'decimal'
            when 'float' then 'double'
            when 'image' then 'byte[]'
            when 'int' then 'int'
            when 'money' then 'decimal'
            when 'nchar' then 'string'
            when 'ntext' then 'string'
            when 'numeric' then 'decimal'
            when 'nvarchar' then 'string'
            when 'real' then 'float'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'short'
            when 'smallmoney' then 'decimal'
            when 'text' then 'string'
            when 'time' then 'TimeSpan'
            when 'timestamp' then 'long'
            when 'tinyint' then 'byte'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'byte[]'
            when 'varchar' then 'string'
            else 'UNKNOWN_' + typ.name
        end ColumnType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            then '?' 
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId
 


 
select @INSERTResult3 = @INSERTResult3 + '
    @' + ColumnName + ','
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        case typ.name 
            when 'bigint' then 'long'
            when 'binary' then 'byte[]'
            when 'bit' then 'bool'
            when 'char' then 'string'
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTimeOffset'
            when 'decimal' then 'decimal'
            when 'float' then 'double'
            when 'image' then 'byte[]'
            when 'int' then 'int'
            when 'money' then 'decimal'
            when 'nchar' then 'string'
            when 'ntext' then 'string'
            when 'numeric' then 'decimal'
            when 'nvarchar' then 'string'
            when 'real' then 'float'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'short'
            when 'smallmoney' then 'decimal'
            when 'text' then 'string'
            when 'time' then 'TimeSpan'
            when 'timestamp' then 'long'
            when 'tinyint' then 'byte'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'byte[]'
            when 'varchar' then 'string'
            else 'UNKNOWN_' + typ.name
        end ColumnType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            then '?' 
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId
 



 SET @INSERTResult = 
     CASE @INSERTResult WHEN null THEN null 
     ELSE (
         CASE LEN(@INSERTResult) WHEN 0 THEN @INSERTResult 
            ELSE LEFT(@INSERTResult, LEN(@INSERTResult) - 1) 
         END 
     ) END



 SET @INSERTResult2 = 
     CASE @INSERTResult2 WHEN null THEN null 
     ELSE (
         CASE LEN(@INSERTResult2) WHEN 0 THEN @INSERTResult2 
            ELSE LEFT(@INSERTResult2, LEN(@INSERTResult2) - 1) 
         END 
     ) END



 SET @INSERTResult3 = 
     CASE @INSERTResult3 WHEN null THEN null 
     ELSE (
         CASE LEN(@INSERTResult3) WHEN 0 THEN @INSERTResult3 
            ELSE LEFT(@INSERTResult3, LEN(@INSERTResult3) - 1) 
         END 
     ) END






PRINT '



--############################################################################################################################'
PRINT '--## INSERT ##'
PRINT '--############################################################################################################################'


print @INSERTResult + ' ' + @INSERTResult2 + ' ' + @INSERTResult3 + @INSERTResult4

  




declare @UPDATEResult varchar(max)  = 'CREATE PROCEDURE SP' + @TableName + '_UPDATE 
'

declare @UPDATEResult2 varchar(max)  = '

AS

UPDATE ' + @TableName + ' 
SET
 '



declare @UPDATEResult3 varchar(max)  = '

WHERE ID = @ID
'

 


 

select @UPDATEResult = @UPDATEResult + '
    @' + ColumnName + + ' ' + ColumnType + ','
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        typ.name ColumnType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            then '?' 
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId


select @UPDATEResult2 = @UPDATEResult2 + '
    ' + ColumnName + ' = @' + ColumnName + ', '
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        case typ.name 
            when 'bigint' then 'long'
            when 'binary' then 'byte[]'
            when 'bit' then 'bool'
            when 'char' then 'string'
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTimeOffset'
            when 'decimal' then 'decimal'
            when 'float' then 'double'
            when 'image' then 'byte[]'
            when 'int' then 'int'
            when 'money' then 'decimal'
            when 'nchar' then 'string'
            when 'ntext' then 'string'
            when 'numeric' then 'decimal'
            when 'nvarchar' then 'string'
            when 'real' then 'float'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'short'
            when 'smallmoney' then 'decimal'
            when 'text' then 'string'
            when 'time' then 'TimeSpan'
            when 'timestamp' then 'long'
            when 'tinyint' then 'byte'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'byte[]'
            when 'varchar' then 'string'
            else 'UNKNOWN_' + typ.name
        end ColumnType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            then '?' 
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId
 


  



 SET @UPDATEResult = 
     CASE @UPDATEResult WHEN null THEN null 
     ELSE (
         CASE LEN(@UPDATEResult) WHEN 0 THEN @UPDATEResult 
            ELSE LEFT(@UPDATEResult, LEN(@UPDATEResult) - 1) 
         END 
     ) END



 SET @UPDATEResult2 = 
     CASE @UPDATEResult2 WHEN null THEN null 
     ELSE (
         CASE LEN(@UPDATEResult2) WHEN 0 THEN @UPDATEResult2 
            ELSE LEFT(@UPDATEResult2, LEN(@UPDATEResult2) - 1) 
         END 
     ) END

	  





PRINT '



--############################################################################################################################'
PRINT '--## UPDATE ##'
PRINT '--############################################################################################################################'


print @UPDATEResult + ' ' + @UPDATEResult2 + ' ' + @UPDATEResult3  

  


  






declare @DELETEResult varchar(max)  = 'CREATE PROCEDURE SP' + @TableName + '_DELETE '

declare @DELETEResult2 varchar(max)  = '

	@ID INT

AS

DELETE FROM ' + @TableName + ' WHERE ID = @ID '


 

PRINT '



--############################################################################################################################'
PRINT '--## DELETE ##'
PRINT '--############################################################################################################################'


print @DELETEResult + ' ' + @DELETEResult2 

  





  


declare @SELECTResult varchar(max)  = 'CREATE PROCEDURE SP' + @TableName + '_SELECT '

declare @SELECTResult2 varchar(max)  = '

	@ID INT

AS

SELECT FROM ' + @TableName + ' WHERE ID = @ID '


 

PRINT '



--############################################################################################################################'
PRINT '--## SELECT ##'
PRINT '--############################################################################################################################'


print @SELECTResult + ' ' + @SELECTResult2 

  






