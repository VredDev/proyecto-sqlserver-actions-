USE EmpresaDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_AuditarVenta
ON dbo.Ventas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Inserción directa basada en conjuntos (Set-Based) desde la pseudo-tabla 'inserted'
    INSERT INTO dbo.AuditoriaVentas (VentaID, FechaRegistro, Mensaje)
    SELECT 
        i.VentaID,
        GETDATE(),
        CONCAT('Venta registrada automáticamente (Producto: ', i.Producto, ', Cantidad: ', i.Cantidad, ')')
    FROM inserted i;
END;
GO
