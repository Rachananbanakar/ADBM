INSERT INTO Groc_Store.Form_F([Form])
	SELECT
	DISTINCT [Form]
	FROM [Groc_Store].[FruitStaging]
	ORDER BY [Form] ASC

UPDATE Groc_Store.FruitStaging
SET Groc_Store.FruitStaging.Form_ID = Groc_Store.Form_F.Form_ID
FROM Groc_Store.FruitStaging
INNER JOIN Groc_Store.Form_F ON 
Groc_Store.Form_F.[Form] = Groc_Store.FruitStaging.[Form]


INSERT INTO Groc_Store.RPU_F([RetailPriceUnit])
	SELECT
	DISTINCT [RetailPriceUnit]
	FROM [Groc_Store].[FruitStaging]
	ORDER BY [RetailPriceUnit] ASC

UPDATE Groc_Store.FruitStaging
SET Groc_Store.FruitStaging.RPU_ID = Groc_Store.RPU_F.RPU_ID
FROM Groc_Store.FruitStaging
INNER JOIN Groc_Store.RPU_F ON 
Groc_Store.FruitStaging.[RetailPriceUnit] = Groc_Store.RPU_F.[RetailPriceUnit]

--UPDATE Groc_Store.FruitStaging
--SET Groc_Store.FruitStaging.RetailPriceUnit = Groc_Store.RPU_F.RetailPriceUnit
--FROM Groc_Store.FruitStaging
--INNER JOIN Groc_Store.RPU_F ON 
--Groc_Store.FruitStaging.[RetailPriceUnit] = Groc_Store.RPU_F.[RetailPriceUnit]

INSERT INTO Groc_Store.CEU_F([CupEquivalentUnit])
	SELECT
	DISTINCT [CupEquivalentUnit]
	FROM [Groc_Store].[FruitStaging]
	ORDER BY [CupEquivalentUnit] ASC

UPDATE Groc_Store.FruitStaging
SET Groc_Store.FruitStaging.CEU_ID = Groc_Store.CEU_F.CEU_ID
FROM Groc_Store.FruitStaging
INNER JOIN Groc_Store.CEU_F ON 
Groc_Store.FruitStaging.[CupEquivalentUnit] = Groc_Store.CEU_F.[CupEquivalentUnit]


INSERT INTO Groc_Store.Fruit_F([Fruit],[Form_ID],[RPU_ID],[CEU_ID])
	SELECT
	DISTINCT Fruit,Form_ID,RPU_ID,CEU_ID
	FROM [Groc_Store].[FruitStaging]
	ORDER BY Form_ID ASC,RPU_ID ASC,CEU_ID ASC

UPDATE Groc_Store.FruitStaging
SET Groc_Store.FruitStaging.Fruit_ID = Groc_Store.Fruit_F.Fruit_ID
FROM Groc_Store.FruitStaging
INNER JOIN Groc_Store.Fruit_F ON 
Groc_Store.FruitStaging.[Fruit] = Groc_Store.Fruit_F.[Fruit] and Groc_Store.FruitStaging.[Form_ID] = Groc_Store.Fruit_F.[Form_ID] and Groc_Store.FruitStaging.[RPU_ID] = Groc_Store.Fruit_F.[RPU_ID] and Groc_Store.FruitStaging.[CEU_ID] = Groc_Store.Fruit_F.[CEU_ID]



INSERT INTO Groc_Store.Fruit_Fact
           (RetailPrice,
		   Yield,
		   CupEquivalentSize,
		   CupEquivalentPrice,
		   Fruit_ID)
		   SELECT
		   RetailPrice,
		   Yield,
		   CupEquivalentSize,
		   CupEquivalentPrice,
		   Fruit_ID  
		  FROM Groc_Store.FruitStaging

select * from Groc_Store.Fruit_Fact;

INSERT INTO Groc_Store.State_GS([State_gs])
	SELECT
	DISTINCT [State_gs]
	FROM [Groc_Store].[GSStaging]
	ORDER BY [State_gs] ASC

UPDATE Groc_Store.GSStaging
SET Groc_Store.GSStaging.State_ID = Groc_Store.State_GS.State_ID
FROM Groc_Store.GSStaging
INNER JOIN Groc_Store.State_GS ON 
Groc_Store.State_GS.State_gs = Groc_Store.GSStaging.State_gs


INSERT INTO Groc_Store.City_GS([City],[State_ID])
	SELECT
	DISTINCT City,State_ID
	FROM [Groc_Store].[GSStaging]
	ORDER BY State_ID ASC

UPDATE Groc_Store.GSStaging
SET Groc_Store.GSStaging.City_ID = Groc_Store.City_GS.City_ID
FROM Groc_Store.GSStaging
INNER JOIN Groc_Store.City_GS ON 
Groc_Store.City_GS.City = Groc_Store.GSStaging.City and Groc_Store.City_GS.State_ID = Groc_Store.GSStaging.State_ID


INSERT INTO Groc_Store.Zip_GS([ZipCode],[City_ID])
	SELECT
	DISTINCT ZipCode,City_ID
	FROM [Groc_Store].[GSStaging]
	ORDER BY City_ID ASC

UPDATE Groc_Store.GSStaging
SET Groc_Store.GSStaging.Zip_ID = Groc_Store.Zip_GS.Zip_ID
FROM Groc_Store.GSStaging
INNER JOIN Groc_Store.Zip_GS ON 
Groc_Store.Zip_GS.ZipCode = Groc_Store.GSStaging.ZipCode and Groc_Store.Zip_GS.City_ID = Groc_Store.GSStaging.City_ID


INSERT INTO Groc_Store.DataSource_GS([Data_Source_gs])
	SELECT
	DISTINCT [Data_Source_gs]
	FROM [Groc_Store].[GSStaging]
	ORDER BY [Data_Source_gs] ASC

UPDATE Groc_Store.GSStaging
SET Groc_Store.GSStaging.DS_ID = Groc_Store.DataSource_GS.DS_ID
FROM Groc_Store.GSStaging
INNER JOIN Groc_Store.DataSource_GS ON 
Groc_Store.DataSource_GS.Data_Source_gs = Groc_Store.GSStaging.Data_Source_gs


INSERT INTO Groc_Store.DigMember_GS([DIG_MEMBER])
	SELECT
	DISTINCT [DIG_MEMBER]
	FROM [Groc_Store].[GSStaging]
	ORDER BY [DIG_MEMBER] ASC

UPDATE Groc_Store.GSStaging
SET Groc_Store.GSStaging.DM_ID = Groc_Store.DigMember_GS.DM_ID
FROM Groc_Store.GSStaging
INNER JOIN Groc_Store.DigMember_GS ON 
Groc_Store.DigMember_GS.DIG_MEMBER = Groc_Store.GSStaging.DIG_MEMBER


INSERT INTO Groc_Store.Company_GS(Company,Address_gs,Better_Lat,Better_Long,Common_Name,Notes,PHONE,FAX,EMAIL,WEBSITE,Centroid_X,Centroid_Y,Zip_ID,DS_ID,DM_ID)
	SELECT
	distinct Company,Address_gs,Better_Lat,Better_Long,Common_Name,Notes,PHONE,FAX,EMAIL,WEBSITE,Centroid_X,Centroid_Y,Zip_ID,DS_ID,DM_ID
	FROM [Groc_Store].[GSStaging]
	ORDER BY Zip_ID ASC,DS_ID ASC,DM_ID ASC

UPDATE Groc_Store.GSStaging
SET Groc_Store.GSStaging.Company_ID = Groc_Store.Company_GS.Company_ID
FROM Groc_Store.GSStaging
INNER JOIN Groc_Store.Company_GS ON 
Groc_Store.Company_GS.Company = Groc_Store.GSStaging.Company --and Groc_Store.Company_GS.Zip_ID = Groc_Store.GSStaging.Zip_ID and Groc_Store.Company_GS.DS_ID = Groc_Store.GSStaging.DS_ID and Groc_Store.Company_GS.DM_ID = Groc_Store.GSStaging.DM_ID


INSERT INTO Groc_Store.GS_Fact
           (SquareFeet,
			Company_ID)
		   SELECT
		    SquareFeet,
			Company_ID
		  FROM Groc_Store.GSStaging where SquareFeet is not null

select * from Groc_Store.Company_GS
--select * from Groc_Store.GSStaging
select * from Groc_Store.GS_Fact;

