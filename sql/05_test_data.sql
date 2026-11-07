USE EmpresaDB;
GO

-- Población de inventario inicial
INSERT INTO dbo.Inventario (Producto, StockActual) VALUES 
('Laptop', 20),
('Monitor', 30),
('Teclado Mecanico', 50);
GO

-- Prueba 1: Inserción múltiple en una sola sentencia (Valida el soporte multi-fila del Trigger)
INSERT INTO dbo.Ventas (Producto, Cantidad) VALUES 
('Laptop', 3),
('Monitor', 5),
('Teclado Mecanico', 10);
GO

-- Prueba 2: Inserción mediante SP que descuenta inventario (Reto Avanzado)
EXEC dbo.sp_RegistrarVentaConInventario @Producto = 'Laptop', @Cantidad = 2;
GO

-- Validaciones de verificación en logs
PRINT '=== ESTADO DEL INVENTARIO ===';
SELECT * FROM dbo.Inventario;

PRINT '=== REGISTRO DE VENTAS ===';
SELECT * FROM dbo.Ventas;

PRINT '=== AUDITORIA DE VENTAS (Verificación de Trigger Multi-fila) ===';
SELECT * FROM dbo.AuditoriaVentas;
GO
