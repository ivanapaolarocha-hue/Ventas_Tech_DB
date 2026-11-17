-- ============================================================
-- Pre-entrega 4: Consultas SQL de negocio
-- Proyecto: Ventas_Tech_DB
-- Archivo: m4_consultas_negocio.sql
-- Base de Datos: Ventas_Tech_DB
-- ============================================================

USE Ventas_Tech_DB;

-- Consulta 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio por mes.
SELECT fecha_venta AS mes,
       cantidad * precio_unitario AS [Total Facturado],
       COUNT(*) AS cantidad_pedidos,
       AVG(cantidad * precio_unitario) AS ticket_promedio
FROM dbo.ventas
GROUP BY fecha_venta;


-- Consulta 2: Ranking de productos
-- Top 5 de id_producto por total facturado y unidades vendidas.
SELECT TOP 5
    id_producto,cantidad AS unidades_vendidas,
    cantidad * precio_unitario AS total_generado
FROM dbo.ventas 
GROUP BY id_producto
ORDER BY total_generado DESC;


-- Consulta 3: Clientes recurrentes
-- Clientes con más de un pedido, su cantidad de pedidos y total gastado.
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- Consulta 4: Productos por encima/por debajo del promedio
-- Categoriza los productos según si superan el promedio de facturación por producto.
SELECT id_producto, cantidad * precio_unitario AS total_facturado
    FROM dbo.ventas
    GROUP BY id_producto

SELECT id_producto, total_facturado,
    CASE 
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM FacturacionPorProducto) 
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS categoria_promedio
FROM precio;


-- BLOQUE DE CIERRE: Hallazgos de negocio

HALLAZGOS CLAVE DEL ANÁLISIS:

1. Los 5 productos principales (id_producto 3, 8, 4, 7 y 1) representan casi el 47% 
   de la facturación total acumulada de la empresa ($989.967,00 sobre un total de $2.124.587,94).

2. Los 225 clientes registrados en la base de datos cuentan con más de 1 compra realizada
   , lo que demuestra un hábito de compra altamente recurrente.

3. De los 42 productos comercializados, solo 12 logran posicionarse 'por encima' del 
   promedio de facturación por producto ($50.585,43), mientras que 30 productos quedan 'por debajo'.