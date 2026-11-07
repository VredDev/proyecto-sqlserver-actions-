USE EmpresaDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarAuditoria
    @VentaID INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.AuditoriaVentas (VentaID, Mensaje)
    VALUES (@VentaID, 'Venta registrada individualmente vía SP');
END;
GO

-- Procedimiento para Reto Avanzado: Procesa venta validando y descontando existencias
CREATE OR ALTER PROCEDURE dbo.sp_RegistrarVentaConInventario
    @Producto VARCHAR(100),
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM dbo.Inventario WHERE Producto = @Producto)
        BEGIN
            THROW 50001, 'El producto no existe en el inventario.', 1;
        END

        IF (SELECT StockActual FROM dbo.Inventario WHERE Producto = @Producto) < @Cantidad
        BEGIN
            THROW 50002, 'Stock insuficiente para cubrir la venta solicitada.', 1;
        END

        -- Descuenta de existencias
        UPDATE dbo.Inventario
        SET StockActual = StockActual - @Cantidad
        WHERE Producto = @Producto;

        -- Registra la venta (El trigger auditador se disparará automáticamente aquí)
        INSERT INTO dbo.Ventas (Producto, Cantidad)
        VALUES (@Producto, @Cantidad);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
