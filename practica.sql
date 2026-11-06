USE [Chinook];


-- Ejecutar un bloque cada vez (incluyendo GO), comparar con el enunciado.

-- SELECT * FROM INFORMATION_SCHEMA.TABLES
-- EXEC sp_help INVOICE

-- ##############  ejercicios faciles  ##############



-- C01 | Traer diez tracks
-- Listar los primeros 10 tracks por TrackId ascendente. Mostrar TrackId, Name, UnitPrice.

-- SELECT TOP 10 TrackId, Name, UnitPrice 
-- FROM dbo.Track
-- ORDER BY TrackId ASC

GO

-- C02 | Contar tracks
-- Obtener una única fila con la cantidad total de tracks. Alias: cantidad_tracks.

-- SELECT count(TrackId) AS cantidad_tracks
-- FROM Track

GO

-- C03 | Filtrar precios
-- Mostrar TrackId, Name, UnitPrice de los tracks cuyo precio unitario es estrictamente mayor que 1. Ordenar por TrackId ascendente y mostrar solamente los primeros 15.

-- SELECT TOP 15 t.TrackId, t.Name, t.UnitPrice
-- FROM Track t
-- WHERE UnitPrice > 1
-- ORDER BY TrackId ASC

GO

-- C04 | Tracks más largos
-- Mostrar los 10 tracks con mayor duración: TrackId, Name, Milliseconds; desempatar por TrackId ascendente.

-- SELECT TOP 10 TrackId, Name, Milliseconds
-- FROM Track
-- ORDER BY Milliseconds DESC, TrackId ASC


GO

-- C05 | Países de facturación
-- Mostrar los países de facturación distintos (Invoice.BillingCountry), sin duplicados y ordenados alfabéticamente.

GO

-- SELECT BillingCountry
-- FROM Invoice
-- GROUP BY BillingCountry

-- SELECT DISTINCT BillingCountry
-- FROM Invoice
-- ORDER BY BillingCountry

-- ##############  ejercicios intermedios  ##############


-- C06 | Álbum de cada track
-- Mostrar para los primeros 20 tracks (TrackId ascendente) el ID y nombre del track y el título de su álbum: TrackId, track, album.

-- SELECT TOP 20 t.TrackId, t.Name, a.Title
-- FROM TRACK t
-- LEFT JOIN Album a on t.AlbumId = a.AlbumId 

GO

-- C07 | Artistas y álbumes
-- Listar los primeros 25 álbumes por AlbumId, mostrando AlbumId, Title, Artist.Name como artista.

-- SELECT TOP 25 a.AlbumId, a.Title, ar.Name
-- FROM Album a JOIN Artist ar on a.ArtistId = ar.ArtistId


GO

-- C08 | Clientes y representantes
-- Listar los primeros 20 clientes por CustomerId, incluyendo CustomerId, FirstName, LastName y el nombre y apellido del empleado asignado. Si no hay representante, conservar al cliente con campos NULL.

-- SELECT TOP 20 c.CustomerId, c.FirstName, c.LastName, e.FirstName, e.LastName
-- FROM Customer c LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId

GO

-- C09 | Tracks por género
-- Para cada género que tenga tracks, mostrar GenreId, nombre de género y cantidad de tracks. Ordenar por cantidad descendente y luego GenreId ascendente.

-- SELECT g.genreId, g.Name, count(t.TrackId) as track_count
-- FROM Genre g JOIN Track t ON g.GenreId = t.GenreId
-- GROUP BY g.GenreId, g.Name
-- ORDER BY track_count DESC, g.GenreId ASC

GO

-- C10 | Facturas por cliente
-- Para todos los clientes, mostrar CustomerId, FirstName, LastName y cantidad de facturas, incluyendo cero. Ordenar por CustomerId ascendente.

-- SELECT c.CustomerId, c.FirstName, c.LastName, count(i.InvoiceId) as cantidad_facturas
-- FROM Customer c JOIN Invoice i ON c.CustomerId = i.CustomerId
-- GROUP BY c.CustomerId, c.FirstName, c.LastName
-- ORDER BY c.CustomerId ASC

GO

-- C11 | Álbumes por artista
-- Para todos los artistas, mostrar ArtistId, nombre y cantidad de álbumes (cero si no tiene). Ordenar por cantidad descendente, luego ArtistId ascendente.

-- SELECT ar.ArtistId, ar.Name, count(a.AlbumId) as cantidad_albums
-- FROM Artist ar JOIN Album a ON ar.ArtistId = a.ArtistId
-- GROUP BY ar.ArtistId, ar.Name
-- ORDER BY cantidad_albums DESC, ar.ArtistId ASC 


GO

-- C12 | Promedios por tipo de medio
-- Para cada MediaType con tracks mostrar MediaTypeId, nombre, cantidad de tracks, precio mínimo, máximo y promedio. Ordenar por MediaTypeId.

-- SELECT m.MediaTypeId, m.Name, count(t.trackId) as cantidad_tracks, MIN(t.UnitPrice) as minimio, MAX(t.UnitPrice) as maximo, AVG(t.UnitPrice) as promedio
-- FROM MediaType m JOIN Track t on m.MediaTypeId = t.MediaTypeId
-- GROUP BY m.MediaTypeId, m.Name
-- ORDER BY MediaTypeId

GO

-- C13 | Tamaño de las playlists
-- Para todas las playlists, mostrar PlaylistId, Name y cantidad de tracks distintos. Incluir playlists vacías; ordenar por cantidad descendente y luego PlaylistId. No agrupar solamente por nombre.

-- SELECT p.PlaylistId, p.Name, count(pt.trackId) cantidad_tracks
-- FROM Playlist p LEFT JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
-- GROUP BY p.PlaylistId, p.Name
-- ORDER BY cantidad_tracks DESC, p.PlaylistId DESC

GO
-- C14 | Líneas por factura
-- Para cada factura con líneas, mostrar InvoiceId, número de líneas y cantidad total de unidades compradas (SUM(Quantity)). Mostrar las 10 primeras por número de líneas descendente y InvoiceId ascendente.

-- SELECT TOP 10 i.InvoiceId, count(il.invoiceLineId) as cantidad_lineas, SUM(il.Quantity) total_compradas
-- FROM Invoice i JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
-- GROUP BY i.InvoiceId
-- ORDER BY cantidad_lineas DESC, i.invoiceId ASC

GO

-- ##############  nivel del parcial  ##############



-- C15 | Duración de álbumes
-- Para los álbumes que tengan al menos 8 tracks, obtener AlbumId, título, cantidad de tracks y duración total en milisegundos. Ordenar por duración total descendente y luego AlbumId.

-- SELECT a.AlbumId, a.Title, count(t.trackId) as cantidad_tracks, SUM(t.Milliseconds) as longitud_album
-- FROM Album a JOIN Track t ON a.AlbumId = t.AlbumId
-- GROUP BY a.AlbumId, a.Title
-- HAVING count(t.trackId) > 7
-- ORDER BY longitud_album DESC, a.AlbumId ASC

GO


-- C16 | Precio promedio por género
-- Para cada género que tenga tracks, calcular cantidad y precio unitario promedio de tracks. Devolver solo géneros con al menos 10 tracks. Mostrar GenreId, nombre, cantidad, precio_promedio; ordenar por promedio descendente y GenreId.

-- SELECT g.genreId, g.Name, COUNT(t.TrackId) as cantidad_tracks, AVG(t.UnitPrice) as precio_promedio
-- FROM Track t JOIN Genre g on g.GenreId = t.GenreId
-- GROUP BY g.genreId, g.Name
-- HAVING COUNT(t.TrackId) > 9
-- ORDER BY precio_promedio DESC, g.GenreId


GO

-- C17 | Compras por tipo de medio
-- Mostrar cada MediaTypeId, nombre, cantidad de líneas de factura relacionadas con sus tracks y unidades vendidas. Incluir tipos sin ventas con ceros. Ordenar por unidades descendente y MediaTypeId.

-- SELECT m.MediaTypeId, m.Name, COUNT(il.invoiceLineId) as cantidad_lineas_facturas, ISNULL(SUM(il.Quantity), 0) as unidades_vendidas
-- FROM MediaType m LEFT JOIN Track t ON m.MediaTypeId = t.MediaTypeId LEFT JOIN InvoiceLine il ON il.TrackId = t.TrackId
-- GROUP BY m.MediaTypeId, m.Name
-- ORDER BY unidades_vendidas DESC, m.MediaTypeId ASC

GO

-- C18 | Máxima factura por cliente
-- Para cada cliente que tenga facturas, mostrar CustomerId, nombre, apellido y el importe máximo de una de sus facturas. Ordenar por importe máximo descendente y luego CustomerId.

-- SELECT c.CustomerId, c.FirstName, c.LastName, MAX(i.total) as importe_maximo
-- FROM Customer c JOIN Invoice i ON c.CustomerId = i.CustomerId
-- GROUP BY c.CustomerId, c.FirstName, c.LastName
-- ORDER BY importe_maximo DESC, c.CustomerId ASC

GO

-- C19 | Artistas sin álbumes
-- Listar ArtistId y Name de artistas que no tienen ningún álbum registrado. Ordenar por ArtistId. Encontrar ausencia de relación, no álbumes con cero tracks.

-- SELECT ar.ArtistId, ar.Name
-- FROM Artist ar LEFT JOIN Album a ON ar.ArtistId = a.ArtistId
-- WHERE a.AlbumId IS NULL
-- ORDER BY ar.ArtistId;

-- C20 | Álbumes con Rock y otro género
-- Listar AlbumId, título del álbum y nombre del artista de álbumes que tengan al menos un track del género Rock **y** al menos un track de un género distinto de Rock. Ordenar por AlbumId.

-- SELECT a.AlbumId, a.Title, ar.Name
-- FROM Album a JOIN Artist ar ON a.ArtistId = ar.ArtistId
-- WHERE EXISTS (
--     SELECT 1
--     FROM Track t1 JOIN Genre g1 ON t1.GenreId = g1.GenreId
--     WHERE t1.AlbumId = a.AlbumId AND g1.Name = 'Rock'
-- ) AND EXISTS (
--     SELECT 1
--     FROM Track t2 JOIN Genre g2 ON t2.GenreId = g2.GenreId
--     WHERE t2.AlbumId = a.AlbumId AND g2.Name <> 'Rock'
-- )
-- ORDER BY a.AlbumId ASC

GO

-- C21 | Tracks vendidos en múltiples facturas
-- Listar TrackId, nombre y cantidad de facturas distintas en que aparece, para tracks presentes en al menos dos facturas distintas. Ordenar por cantidad descendente y TrackId ascendente.

-- SELECT t.TrackId, t.Name, COUNT(DISTINCT(il.InvoiceId)) as cantidad_facturas
-- FROM Track t 
-- JOIN InvoiceLine il ON t.TrackId = il.TrackId 
-- GROUP BY t.TrackId, t.Name
-- HAVING COUNT(DISTINCT(il.InvoiceId)) > 1
-- ORDER BY cantidad_facturas DESC, t.TrackId ASC

GO

-- C22 | Clientes con variedad de medios
-- Mostrar CustomerId, nombre, apellido y cantidad de MediaTypeId distintos efectivamente comprados; incluir solo clientes con al menos dos tipos de medio. Ordenar por cantidad descendente y CustomerId.

SELECT c.CustomerId, c.FirstName, c.LastName, COUNT(DISTINCT(m.MediaTypeId)) as cantidad_medias
FROM Customer c 
JOIN Invoice i ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
JOIN Track t ON il.TrackId = t.TrackId
JOIN MediaType m ON m.MediaTypeId = t.MediaTypeId
GROUP BY c.CustomerId, c.FirstName, c.LastName
HAVING COUNT(DISTINCT(m.MediaTypeId)) > 1
ORDER BY cantidad_medias DESC, c.CustomerId ASC

GO


-- ##############  ejercicios mas avanzados  ##############


-- C23 | Playlists de una banda sin otra
-- Obtener PlaylistId, nombre de playlist para las que hay al menos un track de Iron Maiden y ningún track de U2. La condición se aplica a los artistas de los álbumes de los tracks. Ordenar por PlaylistId.


GO

-- C24 | Artistas por encima de la duración media de álbumes
-- Para cada artista con al menos 2 álbumes que tengan tracks, calcular la duración total de cada álbum y después el promedio de esas duraciones por artista. Devolver ArtistId, nombre, cantidad de álbumes considerados y promedio de minutos por álbum, ordenado descendente por promedio y luego ArtistId.


GO

-- C25 | Clientes destacados por representante
-- Calcular el gasto acumulado por cliente (SUM(Invoice.Total)), luego para cada representante contar cuántos clientes asignados gastaron **más de $40**. Mostrar a todos los empleados con EmployeeId, nombre, apellido y ese conteo, incluso cero. Ordenar por conteo descendente y EmployeeId.


GO

-- C26 | Género líder de ventas por año
-- Para cada año presente en Invoice.InvoiceDate, devolver todos los géneros que empatan en **mayor cantidad de unidades vendidas** de ese año. Mostrar anio, GenreId, genero, unidades; ordenar por año ascendente y GenreId ascendente. Calcular unidades con InvoiceLine.Quantity y no confundir líneas con unidades.


GO
