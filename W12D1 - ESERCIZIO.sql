/*Esercizio 1 Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. */

SELECT 
    GN.Name, TK.GenreId, COUNT(TK.GenreId) AS Numero_Tracce
FROM
    track TK
        JOIN
    genre GN ON GN.GenreId = TK.GenreId
GROUP BY GN.Name , GN.GenreId
HAVING (Numero_Tracce >= 10)
ORDER BY Numero_Tracce DESC;



/*Esercizio 2 Trovate le tre canzoni più costose. */

SELECT 
    tk.UnitPrice Prezzo, COUNT(tk.TrackId) as Numero_Canzoni
FROM
    track AS TK
GROUP BY tk.UnitPrice
ORDER BY tk.UnitPrice DESC;




/*Esercizio 3 Elencate gli artisti che hanno canzoni più lunghe di 6 minuti. */

SELECT DISTINCT
art.Name,
tk.Milliseconds
FROM 
    track AS tk
    JOIN album AS alb ON alb.AlbumId = tk.AlbumId
    JOIN artist AS art ON art.ArtistId = alb.ArtistId
    WHERE tk.Milliseconds > 360000;

/*Esercizio 4 Individuate la durata media delle tracce per ogni genere. */

SELECT 
    gn.Name,
    avg(tk.Milliseconds) as durata_media_tracce
FROM track as tk
JOIN genre as gn on gn.GenreId = tk.GenreId
GROUP BY gn.Name;
    



/*Esercizio 5 Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome. */

SELECT
gn.Name as Genere,
tk.Name as Titolo_Canzone
FROM track as tk
JOIN genre as gn on gn.GenreId = tk.GenreId
GROUP BY tk.Name, gn.Name
HAVING Titolo_Canzone like '%Love%'
order by gn.Name asc,
tk.Name asc;

/*Esercizio 6 Trovate il costo medio per ogni tipologia di media.*/
SELECT 
    mt.Name, AVG(tk.UnitPrice) AS costomedio_mediatype
FROM
    track AS tk
        JOIN
    mediatype AS mt ON mt.MediaTypeId = tk.MediaTypeId
GROUP BY mt.Name;


 /* Esercizio 7 Individuate il genere con più tracce. */

SELECT G.NAME AS GENRE_NAME
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME
HAVING COUNT(DISTINCT T.NAME)=(SELECT MAX(NUM_TRACK)
FROM(SELECT G.NAME AS GENRE_NAME, COUNT(DISTINCT T.NAME) AS NUM_TRACK
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME) A );



/* Esercizio 8 Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.*/



SELECT AR.NAME ARTISTA, COUNT(AL.TITLE) AS NUM_ALBUM
FROM ALBUM AL 
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME
HAVING NUM_ALBUM=( SELECT COUNT(AL.TITLE) AS NUM_ALBUM
FROM ALBUM AL 
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
WHERE AR.NAME = 'The Rolling Stones') ;


/* Esercizio 9 Trovate l’artista con l’album più costoso. */

SELECT AR.NAME ARTIST, AL.TITLE ALBUM -- , SUM(T.UNITPRICE) AS ALBUM_PRICE
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME, AL.TITLE
HAVING SUM(T.UNITPRICE)=(SELECT MAX(ALBUM_PRICE)
FROM(SELECT AR.NAME ARTIST, AL.TITLE ALBUM, SUM(T.UNITPRICE) AS ALBUM_PRICE
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME, AL.TITLE)A);



