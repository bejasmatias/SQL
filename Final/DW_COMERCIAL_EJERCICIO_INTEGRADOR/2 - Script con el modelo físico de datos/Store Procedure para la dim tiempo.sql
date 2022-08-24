-- Stored Procedure para la DIM_TIEMPO --

CREATE PROCEDURE [dbo].[Sp_Genera_Dim_Tiempo]
@anio Int
As
SET NOCOUNT ON
SET arithabort off
SET arithignore on

/**************/
/* Variables */
/**************/

SET DATEFIRST 1;
SET DATEFORMAT mdy
DECLARE @dia smallint
DECLARE @mes smallint
DECLARE @f_txt varchar(10)
DECLARE @fecha smalldatetime
DECLARE @key int
DECLARE @vacio smallint
DECLARE @fin smallint
DECLARE @fin_mes int
DECLARE @anioperiodicidad int

SELECT @dia = 1
SELECT @mes = 1
SELECT @f_txt = Convert(char(2), @mes) + '/' + Convert(char(2), @dia) + '/' + Convert(char(4), @anio)
SELECT @fecha = Convert(smalldatetime, @f_txt)
select @anioperiodicidad = @anio

/************************************/
/* Se chequea que el a¤o a procesar */
/* no exista en la tabla TIME */
/************************************/

IF (SELECT Count(*) FROM dim_tiempo WHERE anio = @anio) > 0
BEGIN
Print 'El año que ingreso ya existe en la tabla'
Print 'Procedimiento CANCELADO.................'
Return 0
END
/*************************/
/* Se inserta d¡a a d¡a */
/* hasta terminar el a¤o */
/*************************/

SELECT @fin = @anio + 1
WHILE (@anio < @fin)
BEGIN
--Armo la fecha
IF Len(Rtrim(Convert(Char(2),Datepart(mm, @fecha))))=1
BEGIN
IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha))))=1
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + '0' +

Rtrim(Convert(Char(2),Datepart(mm, @fecha))) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha)))
ELSE
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + '0' +

Rtrim(Convert(Char(2),Datepart(mm, @fecha))) + Convert(Char(2),Datepart(dd, @fecha))
END
ELSE
BEGIN
IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha))))=1
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + Convert(Char(2),Datepart(mm,

@fecha)) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha)))
ELSE
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + Convert(Char(2),Datepart(mm,

@fecha)) + Convert(Char(2),Datepart(dd, @fecha))
END
--Calculo el último día del mes
SET @fin_mes = day(dateadd(d, -1, dateadd(m, 1, dateadd(d, - day(@fecha) + 1, @fecha))))

INSERT Dim_Tiempo (Tiempo_Key, Anio, Mes_Nro, Mes_Nombre, Semestre, Trimestre, Semana_Anio

,Semana_Nro_Mes, Dia, Dia_Nombre, Dia_Semana_Nro)

SELECT
tiempo_key = @fecha
, anio = Datepart(yyyy, @fecha)
, mes = Datepart(mm, @fecha)
--, mes_nombre = Datename(mm, @fecha)
, mes_nombre = CASE Datename(mm, @fecha)
when 'January' then 'Enero'
when 'February' then 'Febrero'
when 'March' then 'Marzo'
when 'April' then 'Abril'
when 'May' then 'Mayo'
when 'June' then 'Junio'
when 'July' then 'Julio'
when 'August' then 'Agosto'
when 'September' then 'Septiembre'
when 'October' then 'Octubre'
when 'November' then 'Noviembre'
when 'December' then 'Diciembre'
else Datename(mm, @fecha)
END

, semestre = CASE Datepart(mm, @fecha)
when (SELECT Datepart(mm, @fecha)

WHERE Datepart(mm, @fecha) between 1 and 6) then 1

else 2
END

, trimestre = Datepart(qq, @fecha)
, semana_anio = Datepart(wk, @fecha)
, semana_nro_mes = Datepart(wk, @fecha) - datepart(week,
dateadd(dd,-day(@fecha)+1,@fecha)) +1
, dia = Datepart(dd, @fecha)
, dia_nombre = CASE Datename(dw, @fecha)
when 'Monday' then 'Lunes'
when 'Tuesday' then 'Martes'
when 'Wednesday' then 'Miercoles'
when 'Thursday' then 'Jueves'
when 'Friday' then 'Viernes'
when 'Saturday' then 'Sabado'
when 'Sunday' then 'Domingo'
else Datename(dw, @fecha)
END
--, dia_nombre = Datename(dw, @fecha)
, dia_semana_nro = Datepart(dw, @fecha)

SELECT @fecha = Dateadd(dd, 1, @fecha)
SELECT @dia = Datepart(dd, @fecha)
SELECT @mes = Datepart(mm, @fecha)
SELECT @anio = Datepart(yy, @fecha) CONTINUE
END

exec [dbo].[Sp_Genera_Dim_Tiempo] 2016
exec [dbo].[Sp_Genera_Dim_Tiempo] 2017
exec [dbo].[Sp_Genera_Dim_Tiempo] 2018
exec [dbo].[Sp_Genera_Dim_Tiempo] 2019
exec [dbo].[Sp_Genera_Dim_Tiempo] 2020
exec [dbo].[Sp_Genera_Dim_Tiempo] 2021
exec [dbo].[Sp_Genera_Dim_Tiempo] 2022
