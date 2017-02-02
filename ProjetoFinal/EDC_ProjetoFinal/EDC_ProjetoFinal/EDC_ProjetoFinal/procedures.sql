CREATE PROCEDURE [dbo].CheckMovieFavorite
	@x VARCHAR(100),
	@y INT
AS   -- Verifica se Dado Filme foi visto pelo utilizador, devolve 1 para visto , 0 para não visto
BEGIN TRANSACTION
	SELECT Id,T.C.value('@user', 'nvarchar(100)') AS favorite 
		INTO #temp
		FROM [Movies] AS Y outer apply Y.About.nodes('/about/wishlist/favorite[@user = sql:variable("@x")]') as T(C)
	 
		IF exists (SELECT * FROM #temp WHERE favorite is not null and Id=@y)
			SELECT 1
		ELSE
			SELECT 0
		DROP TABLE #temp
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].CheckMovieRated
	@x VARCHAR(100),
	@y INT
AS   -- Verifica se Dado Filme foi classificado pelo utilizador, devolve 1 se sim, 0 se não!!
BEGIN TRANSACTION 
	SELECT Id,T.C.value('@user', 'nvarchar(100)') AS rated 
		INTO #temp
		FROM [Movies] AS Y outer apply Y.About.nodes('/about/ratings/rating[@user = sql:variable("@x")]') AS T(C)
	 
		IF exists (SELECT * FROM #temp WHERE rated is not null and Id=@y)
			SELECT 1
		ELSE
			SELECT 0
		DROP TABLE #temp
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].CheckMovieSeen
	@x VARCHAR(100),
	@y INT
AS   -- Verifica se Dado Filmes foi visto pelo utilizador, devolve 1 para visto , 0 para não visto
BEGIN TRANSACTION
	SELECT Id,T.C.value('@user', 'nvarchar(100)') AS seen 
		INTO #temp
		FROM [Movies] AS Y outer apply Y.About.nodes('/about/watchlist/seen[@user = sql:variable("@x")]') AS T(C)

		IF exists (SELECT * FROM #temp WHERE seen is not null and Id=@y)
			SELECT 1
		ELSE
			SELECT 0
		DROP TABLE #temp
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].MostFavoriteMovies
AS
-- Procedure that returns the 10 most favorite movies
BEGIN TRANSACTION 
	SELECT Id AS IdTemp, ENName AS ENNameTemp, SmallImage AS SmallImageTemp, [Year] AS YearTemp, T.C.value('@user', 'nvarchar(100)') AS favTemp 
	INTO #temp
	FROM [Movies] AS Y outer apply Y.[About].nodes('about/wishlist/favorite') AS T(C) 

	SELECT IdTemp AS IdTemp2, ENNameTemp AS ENNameTemp2, SmallImageTemp AS SmallImageTemp2, YearTemp AS YearTemp2, favTemp AS favTemp2 
	INTO #temp2 
	FROM #temp 
	WHERE favTemp is not null 
		
	SELECT TOP 10 IdTemp2, ENNameTemp2, SmallImageTemp2, YearTemp2, COUNT(favTemp2) AS NrFavorites, 'user(s) has linked this movie as favorite' AS Favorites 
	FROM #temp2
	GROUP BY ENNameTemp2, IdTemp2, SmallImageTemp2, YearTemp2
	ORDER BY NrFavorites DESC

	DROP TABLE #temp
	DROP TABLE #temp2
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].MostReviewedMovies
AS
-- Procedure that returns the 10 most reviewed movies
BEGIN TRANSACTION 
	SELECT Id AS IdTemp, ENName AS ENNameTemp, SmallImage AS SmallImageTemp, [Year] AS YearTemp, T.C.value('@user', 'nvarchar(100)') AS reviewTemp 
	INTO #temp
	FROM [Movies] AS Y outer apply Y.[About].nodes('about/reviews/review') AS T(C) 

	SELECT IdTemp AS IdTemp2, ENNameTemp AS ENNameTemp2, SmallImageTemp AS SmallImageTemp2, YearTemp AS YearTemp2, reviewTemp AS reviewTemp2 
	INTO #temp2 
	FROM #temp 
	WHERE reviewTemp is not null 
		
	SELECT TOP 10 IdTemp2, ENNameTemp2, SmallImageTemp2, YearTemp2, COUNT(reviewTemp2) AS NrReviews, 'review(s)' AS Reviews 
	FROM #temp2
	GROUP BY ENNameTemp2, IdTemp2, SmallImageTemp2, YearTemp2
	ORDER BY NrReviews DESC

	DROP TABLE #temp
	DROP TABLE #temp2
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].MostSeenMovies
AS
-- Procedure that returns the 10 most viewed movies
BEGIN TRANSACTION 
	SELECT Id AS IdTemp, ENName AS ENNameTemp, SmallImage AS SmallImageTemp, [Year] AS YearTemp, T.C.value('@user', 'nvarchar(100)') AS seenTemp 
	INTO #temp
	FROM [Movies] AS Y outer apply Y.[About].nodes('about/watchlist/seen') AS T(C) 

	SELECT IdTemp AS IdTemp2, ENNameTemp AS ENNameTemp2, SmallImageTemp AS SmallImageTemp2, YearTemp AS YearTemp2, seenTemp AS seenTemp2 
	INTO #temp2 
	FROM #temp 
	WHERE seenTemp is not null 
		
	SELECT TOP 10 IdTemp2, ENNameTemp2, SmallImageTemp2, YearTemp2, COUNT(seenTemp2) AS NrSeens, 'view(s)' AS Seens 
	FROM #temp2
	GROUP BY ENNameTemp2, IdTemp2, SmallImageTemp2, YearTemp2
	ORDER BY NrSeens DESC

	DROP TABLE #temp
	DROP TABLE #temp2
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].ReturnFavoriteMoviesByUser
	@tempUser VARCHAR(100)
AS -- Recolhe os filmes favoritos do User
BEGIN TRANSACTION
SELECT Id, SmallImage, ENName, Genre, T.C.value('@user', 'nvarchar(100)') AS seen 
	INTO #temp
	FROM [Movies] AS Y outer apply Y.[About].nodes('about/wishlist/favorite[@user = sql:variable("@tempUser")]') AS T(C)
	 
	SELECT * FROM #temp WHERE seen is not null 
	DROP TABLE #temp
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].ReturnMoviesSeenFromUser
	@tempUser VARCHAR(100)
AS --Recolhe todos os filmes visto pelo User
BEGIN TRANSACTION
	SELECT Id,SmallImage,ENName,[Year],Synopsis,T.C.value('@user', 'nvarchar(100)') AS seen 
		INTO #temp
		FROM [Movies] AS Y outer apply Y.[About].nodes('about/watchlist/seen[@user = sql:variable("@tempUser")]') AS T(C)
	 
		SELECT * FROM #temp WHERE seen is not null 
		DROP TABLE #temp
COMMIT
RETURN 0
GO

CREATE PROCEDURE [dbo].ReturnNrReviewsByMovie
	@Id INT
AS
BEGIN TRANSACTION
	SELECT [Id], COUNT(r.value('@text', 'varchar(150)')) AS NReviews
	INTO #temp
	FROM [Movies] CROSS APPLY Movies.About.nodes('about/reviews/review') AS x(r) 
	WHERE Movies.Id = @Id
	GROUP BY [Id]

	SELECT NReviews FROM #temp;
	DROP TABLE #temp
COMMIT
RETURN 0;
GO

CREATE PROCEDURE [dbo].ReturnReviewsFromUser
	@x VARCHAR(150)
AS --Recolhe todos os filmes em que o User fez Reviews
BEGIN TRANSACTION
	SELECT Id, ENName, SmallImage, T.C.value('@text', 'nvarchar(MAX)') AS review 
	INTO #temp
	FROM [Movies] AS Y outer apply Y.[About].nodes('/about/reviews/review[@user = sql:variable("@x")]') AS T(C)

	SELECT * FROM #temp WHERE review is not null
	DROP TABLE #temp
COMMIT
RETURN 0
GO