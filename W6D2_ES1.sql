CREATE schema W5D2_Epicode;
use W5D2_Epicode;

-- Creazione tabella store
CREATE TABLE Store (
    Codice_Store INT PRIMARY KEY,
    Indirizzo_fisico VARCHAR(100),
    N_Telefono VARCHAR(100)
);

-- Creazione tabella Impiegato
CREATE TABLE Impiegato (
Codice_Fiscale VARCHAR(100) PRIMARY KEY,
Nome VARCHAR (100),
Titolo_Studio VARCHAR(100),
Recapito VARCHAR(100)
);

-- Creazione tabella Servizio_Impiegato
CREATE TABLE Servizio_Impiegato (
    Codice_Fiscale VARCHAR(100),
    Codice_Store INT,
    Data_inizio DATE,
    Data_fine DATE,
    Carica VARCHAR(100),
    FOREIGN KEY (Codice_Fiscale)
        REFERENCES Impiegato (Codice_Fiscale),
    FOREIGN KEY (Codice_Store)
        REFERENCES Store (Codice_Store)
);
-- Crezione tabella videogioco
CREATE TABLE Videogioco (
    Titolo VARCHAR(100),
    Sviluppatore VARCHAR(100),
    Anno_di_distribuzione INT,
    Prezzo DECIMAL(4 , 2 ),
    Genere VARCHAR(100),
    Remake_Di VARCHAR(100)
);
 

