USE EmpresaDB;
GO

-- Tabla de Inventario (Reto Avanzado)
IF OBJECT_ID('dbo.Inventario', 'U') IS NOT NULL DROP TABLE dbo.Inventario;
CREATE TABLE dbo.Inventario (
    Producto VARCHAR(100) PRIMARY KEY,
    StockActual INT NOT NULL CHECK (StockActual >= 0)
);
GO

-- Tabla de Ventas
IF OBJECT_ID('dbo.Ventas', 'U') IS NOT NULL DROP TABLE dbo.Ventas;
CREATE TABLE dbo.Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    Producto VARCHAR(100) NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Ventas_Inventario FOREIGN KEY (Producto) REFERENCES dbo.Inventario(Producto)
);
GO

-- Tabla de Auditoría
IF OBJECT_ID('dbo.AuditoriaVentas', 'U') IS NOT NULL DROP TABLE dbo.AuditoriaVentas;
CREATE TABLE dbo.AuditoriaVentas (
    AuditoriaID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    Mensaje VARCHAR(255) NOT NULL
);
GO
