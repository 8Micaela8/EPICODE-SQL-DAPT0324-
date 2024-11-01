
-- Creazione tabella Prodotti
CREATE TABLE Prodotti (
    IDProdotto INT NOT NULL,
    NomeProdotto VARCHAR(100) NOT NULL,
    Prezzo DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Prodotti PRIMARY KEY (IDProdotto)
);

-- Creazione tabella clienti

CREATE TABLE Clienti (
    IDCliente INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Clienti PRIMARY KEY (IDCliente)
);

-- Creazione tabella ordini

CREATE TABLE Ordini (
    IDOrdine INT NOT NULL,
    IDProdotto INT NOT NULL,
    IDCliente INT,
    Quantità INT NOT NULL,
    CONSTRAINT PK_Ordini PRIMARY KEY (IDOrdine),
    CONSTRAINT FK_Prodotti FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
    CONSTRAINT FK_Clienti FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente)
);




