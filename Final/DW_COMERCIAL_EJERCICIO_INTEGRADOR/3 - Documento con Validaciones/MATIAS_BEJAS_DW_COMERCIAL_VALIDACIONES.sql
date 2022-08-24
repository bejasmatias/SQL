-- VALIDACIONES --

-- Cantidad de Registros tabla DIM_CATEGORIA --

SELECT
  COUNT(CATEGORIA_KEY) 
FROM DIM_CATEGORIA

-- Cantidad de Registros de tabla DIM_PAIS --

SELECT DISTINCT
  COUNT(PAIS_KEY)
FROM DIM_PAIS

-- Cantidad de Registros de tabla DIM_PRODUCTO --

SELECT
  COUNT(PRODUCTO_KEY) 
FROM DIM_PRODUCTO

-- Cantidad Vendida de la tabla FACT_VENTAS --

select sum(CANTIDAD_VENDIDA) SumCantVen, 
avg(CANTIDAD_VENDIDA) PromedioCantVen,
min(CANTIDAD_VENDIDA) MinCantVen,
max(CANTIDAD_VENDIDA) MaxCantVen,
count(CANTIDAD_VENDIDA) CantidadRegistrosVen
from FACT_VENTAS


-- Total Monto Vendido de la tabla FACT_VENTAS --

select sum(MONTO_VENDIDO) SumaMontVen, 
avg(MONTO_VENDIDO) PromedioMontVen,
min(MONTO_VENDIDO) MinMontVen,
max(MONTO_VENDIDO) MaxMontVen
from FACT_VENTAS