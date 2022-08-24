-- Creacion de Stored Procedure --

-- TABLA INTERMEDIA CATEGORIA --

CREATE PROCEDURE sp_carga_INT_DIM_CATEGORIA
AS
BEGIN

  TRUNCATE TABLE [dbo].[INT_DIM_CATEGORIA]

  INSERT INTO [dbo].[INT_DIM_CATEGORIA] (COD_CATEGORIA, DESC_CATEGORIA)
    SELECT
      COD_CATEGORIA,
      LTRIM(RTRIM(UPPER(ISNULL(DESC_CATEGORIA, 'Sin especificar')))) DESC_CATEGORIA
    FROM [dbo].[STG_DIM_CATEGORIA]

END
  ;
  EXEC sp_carga_INT_DIM_CATEGORIA


  -- Se presenta un inconveniente, cargo la tabla int_categoria multiples veces y los registros se repiten --
  -- TRUNCATE TABLE [dbo].[STG_DIM_CATEGORIA] Trunco la stg y la cargo de vuelta --


  -- PROCEDIMIENTO PARA CARGAR LA TABLA DIM_CATEGORIA --

  CREATE PROCEDURE sp_carga_DIM_CATEGORIA
  AS
  BEGIN

    --ACTUALIZO LOS REGISTROS EXISTENTES EN LA DIM--

    UPDATE old
    SET DESC_CATEGORIA = new.DESC_CATEGORIA,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = 'STORED PROCEDURE'

    FROM [dbo].[DIM_CATEGORIA] old
    LEFT JOIN [dbo].[INT_DIM_CATEGORIA] new
      ON old.COD_CATEGORIA = new.COD_CATEGORIA
    WHERE new.COD_CATEGORIA IS NOT NULL

    -- INSERTO LOS NUEVOS REGISTROS --

    INSERT INTO [dbo].[DIM_CATEGORIA] (/* old.? */COD_CATEGORIA,
    DESC_CATEGORIA,
    FECHA_ALTA,
    USUARIO_ALTA,  							-- NO VA EL KEY CATEGORIA, YA ESTA DEFINIDO COMO INCREMENTAL --
    FECHA_UPDATE,
    USUARIO_UPDATE)
      SELECT
        new.COD_CATEGORIA,
        new.DESC_CATEGORIA, --
        GETDATE(),
        'STORED PROCEDURE',
        NULL,
        NULL

      FROM [dbo].[INT_DIM_CATEGORIA] new
      LEFT JOIN [dbo].[DIM_CATEGORIA] old
        ON old.COD_CATEGORIA = new.COD_CATEGORIA
      WHERE old.COD_CATEGORIA IS NULL

  END

    EXEC sp_carga_DIM_CATEGORIA

    SELECT
      *
    FROM [dbo].[DIM_CATEGORIA]

    -- CARGA DE TABLA INTERMEDIA CLIENTE --

    CREATE PROCEDURE sp_carga_INT_CLIENTE
    AS
    BEGIN

      TRUNCATE TABLE [dbo].[INT_DIM_CLIENTE]

      INSERT INTO [dbo].[INT_DIM_CLIENTE] (COD_CLIENTE, DESC_CLIENTE)
        SELECT
          COD_CLIENTE,
          LTRIM(RTRIM(UPPER(ISNULL(DESC_CLIENTE, 'Sin especificar')))) DESC_CLIENTE
        FROM [dbo].[STG_DIM_CLIENTE]

    END

      EXEC sp_carga_INT_CLIENTE


      -- TABLA DIM_CLIENTE --

      CREATE PROCEDURE sp_carga_DIM_CLIENTE
      AS
      BEGIN

        --ACTUALIZO LOS REGISTROS EXISTENTES EN LA DIM--

        UPDATE old
        SET DESC_CLIENTE = new.DESC_CLIENTE, -- Son los campos de la tabla dim que quiero actualizar --
            FECHA_UPDATE = GETDATE(),
            USUARIO_UPDATE = 'STORED PROCEDURE'
        FROM [dbo].[DIM_CLIENTE] old
        LEFT JOIN [dbo].[INT_DIM_CLIENTE] new
          ON old.COD_CLIENTE = new.COD_CLIENTE
        WHERE new.COD_CLIENTE IS NOT NULL

        -- INSERTO LOS NUEVOS REGISTROS --

        INSERT INTO [dbo].[DIM_CLIENTE] (COD_CLIENTE,
        DESC_CLIENTE,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE)
          SELECT
            new.COD_CLIENTE,
            new.DESC_CLIENTE,
            GETDATE(),
            'STORED PROCEDURE',
            NULL,
            NULL

          FROM [dbo].[INT_DIM_CLIENTE] new
          LEFT JOIN [dbo].[DIM_CLIENTE] old
            ON old.COD_CLIENTE = new.COD_CLIENTE
          WHERE old.COD_CLIENTE IS NULL
      END


        EXEC sp_carga_DIM_CLIENTE


        -- CARGA TABLA INTERMEDIA PAIS --

        CREATE PROCEDURE sp_carga_INT_DIM_PAIS
        AS
        BEGIN

          TRUNCATE TABLE [dbo].[INT_DIM_PAIS]

          INSERT INTO [dbo].[INT_DIM_PAIS] (COD_PAIS, DESC_PAIS)
            SELECT
              COD_PAIS,
              LTRIM(RTRIM(UPPER(ISNULL(DESC_PAIS, 'Sin especificar')))) DESC_PAIS
            FROM [dbo].[STG_DIM_PAIS]

        END
          ;


          -- PROCEDIMIENTO PARA CARGAR LA TABLA DIM_PAIS --

          CREATE PROCEDURE sp_carga_DIM_PAIS
          AS
          BEGIN

            --ACTUALIZO LOS REGISTROS EXISTENTES EN LA DIM--

            UPDATE old
            SET DESC_PAIS = new.DESC_PAIS,
                FECHA_UPDATE = GETDATE(),
                USUARIO_UPDATE = 'STORED PROCEDURE'

            FROM [dbo].[DIM_PAIS] old
            LEFT JOIN [dbo].[INT_DIM_PAIS] new
              ON old.COD_PAIS = new.COD_PAIS
            WHERE new.COD_PAIS IS NOT NULL

            -- INSERTO LOS NUEVOS REGISTROS --

            INSERT INTO [dbo].[DIM_PAIS] (COD_PAIS,
            DESC_PAIS,
            FECHA_ALTA,
            USUARIO_ALTA,
            FECHA_UPDATE,
            USUARIO_UPDATE)


              SELECT
                new.COD_PAIS AS cod_pais,
                new.DESC_PAIS AS desc_pais, --
                GETDATE() AS fecha_alta,
                'STORED PROCEDURE' AS usuario_alta,
                NULL AS fecha_update,
                NULL AS usuario_update

              FROM [dbo].[INT_DIM_PAIS] new
              LEFT JOIN [dbo].[DIM_PAIS] old
                ON old.COD_PAIS = new.COD_PAIS
              WHERE old.COD_PAIS IS NULL

          END

            EXEC sp_carga_DIM_PAIS

            -- CARGA TABLA INTERMEDIA PRODUCTO --

            CREATE PROCEDURE sp_carga_INT_DIM_PRODUCTO
            AS
            BEGIN

              TRUNCATE TABLE [dbo].[INT_DIM_PRODUCTO]

              INSERT INTO [dbo].[INT_DIM_PRODUCTO] (COD_PRODUCTO, DESC_PRODUCTO)
                SELECT
                  COD_PRODUCTO,
                  LTRIM(RTRIM(UPPER(ISNULL(DESC_PRODUCTO, 'Sin especificar')))) DESC_PRODUCTO
                FROM [dbo].[STG_DIM_PRODUCTO]

            END
              ;
              EXEC sp_carga_INT_DIM_PRODUCTO

              SELECT
                *
              FROM [dbo].[INT_DIM_PRODUCTO]


              -- PROCEDIMIENTO PARA CARGAR LA TABLA DIM_PRODUCTO --

              CREATE PROCEDURE sp_carga_DIM_PRODUCTO
              AS
              BEGIN


                --ACTUALIZO LOS REGISTROS EXISTENTES EN LA DIM--

                UPDATE old
                SET DESC_PAIS = new.DESC_PAIS,
                    FECHA_UPDATE = GETDATE(),
                    USUARIO_UPDATE = 'STORED PROCEDURE'

                FROM [dbo].[DIM_PAIS] old
                LEFT JOIN [dbo].[INT_DIM_PAIS] new
                  ON old.COD_PAIS = new.COD_PAIS
                WHERE new.COD_PAIS IS NOT NULL

                -- INSERTO LOS NUEVOS REGISTROS --

                INSERT INTO [dbo].[DIM_PRODUCTO] (COD_PRODUCTO,
                DESC_PRODUCTO,
                FECHA_ALTA,
                USUARIO_ALTA,
                FECHA_UPDATE,
                USUARIO_UPDATE)


                  SELECT
                    new.COD_PRODUCTO,
                    new.DESC_PRODUCTO, --
                    GETDATE(),
                    'STORED PROCEDURE',
                    NULL,
                    NULL

                  FROM [dbo].[INT_DIM_PRODUCTO] new
                  LEFT JOIN [dbo].[DIM_PRODUCTO] old
                    ON old.COD_PRODUCTO = new.COD_PRODUCTO
                  WHERE old.COD_PRODUCTO IS NULL

              END

                EXEC sp_carga_DIM_PRODUCTO

                SELECT
                  *
                FROM [dbo].[DIM_PRODUCTO]

                -- CARGA TABLA INTERMEDIA SUCURSAL --

                CREATE PROCEDURE sp_carga_INT_DIM_SUCURSAL
                AS
                BEGIN

                  TRUNCATE TABLE [dbo].[INT_DIM_SUCURSAL]

                  INSERT INTO [dbo].[INT_DIM_SUCURSAL] (COD_SUCURSAL, DESC_SUCURSAL)
                    SELECT
                      COD_SUCURSAL,
                      LTRIM(RTRIM(UPPER(ISNULL(DESC_SUCURSAL, 'Sin especificar')))) DESC_SUCURSAL
                    FROM [dbo].[STG_DIM_SUCURSAL]

                END
                  ;
                  EXEC sp_carga_INT_DIM_SUCURSAL

                  SELECT
                    *
                  FROM [dbo].[STG_DIM_SUCURSAL]

                  -- PROCEDIMIENTO PARA CARGAR LA TABLA DIM_SUCURSAL --

                  CREATE PROCEDURE sp_carga_DIM_SUCURSAL
                  AS
                  BEGIN


                    --ACTUALIZO LOS REGISTROS EXISTENTES EN LA DIM--

                    UPDATE old
                    SET DESC_PAIS = new.DESC_PAIS,
                        FECHA_UPDATE = GETDATE(),
                        USUARIO_UPDATE = 'STORED PROCEDURE'

                    FROM [dbo].[DIM_PAIS] old
                    LEFT JOIN [dbo].[INT_DIM_PAIS] new
                      ON old.COD_PAIS = new.COD_PAIS
                    WHERE new.COD_PAIS IS NOT NULL

                    -- INSERTO LOS NUEVOS REGISTROS --

                    INSERT INTO [dbo].[DIM_SUCURSAL] (COD_SUCURSAL,
                    DESC_SUCURSAL,
                    FECHA_ALTA,
                    USUARIO_ALTA,
                    FECHA_UPDATE,
                    USUARIO_UPDATE)


                      SELECT
                        new.COD_SUCURSAL,
                        new.DESC_SUCURSAL, --
                        GETDATE(),
                        'STORED PROCEDURE',
                        NULL,
                        NULL

                      FROM [dbo].[INT_DIM_SUCURSAL] new
                      LEFT JOIN [dbo].[DIM_SUCURSAL] old
                        ON old.COD_SUCURSAL = new.COD_SUCURSAL
                      WHERE old.COD_SUCURSAL IS NULL

                  END

                    EXEC sp_carga_DIM_SUCURSAL

                    SELECT
                      *
                    FROM [dbo].[DIM_SUCURSAL]



                    -- CARGA TABLA INTERMEDIA VENDEDOR --

                    CREATE PROCEDURE sp_carga_INT_DIM_VENDEDOR
                    AS
                    BEGIN

                      TRUNCATE TABLE [dbo].[INT_DIM_VENDEDOR]

                      INSERT INTO [dbo].[INT_DIM_VENDEDOR] (COD_VENDEDOR, DESC_VENDEDOR)
                        SELECT
                          COD_VENDEDOR,
                          LTRIM(RTRIM(UPPER(ISNULL(DESC_VENDEDOR, 'Sin especificar')))) DESC_VENDEDOR
                        FROM [dbo].[STG_DIM_VENDEDOR]

                    END


                      -- PROCEDIMIENTO PARA CARGAR LA TABLA DIM_VENDEDOR --

                      CREATE PROCEDURE sp_carga_DIM_VENDEDOR
                      AS
                      BEGIN


                        --ACTUALIZO LOS REGISTROS EXISTENTES EN LA DIM --

                        UPDATE old
                        SET DESC_VENDEDOR = new.DESC_VENDEDOR,
                            FECHA_UPDATE = GETDATE(),
                            USUARIO_UPDATE = 'STORED PROCEDURE'

                        FROM [dbo].[DIM_VENDEDOR] old
                        LEFT JOIN [dbo].[INT_DIM_VENDEDOR] new
                          ON old.COD_VENDEDOR = new.COD_VENDEDOR
                        WHERE new.COD_VENDEDOR IS NOT NULL

                        -- INSERTO LOS NUEVOS REGISTROS --

                        INSERT INTO [dbo].[DIM_VENDEDOR] (COD_VENDEDOR,
                        DESC_VENDEDOR,
                        FECHA_ALTA,
                        USUARIO_ALTA,
                        FECHA_UPDATE,
                        USUARIO_UPDATE)

                          SELECT
                            new.COD_VENDEDOR,
                            new.DESC_VENDEDOR, --
                            GETDATE(),
                            'STORED PROCEDURE',
                            NULL,
                            NULL

                          FROM [dbo].[INT_DIM_VENDEDOR] new
                          LEFT JOIN [dbo].[DIM_VENDEDOR] old
                            ON old.COD_VENDEDOR = new.COD_VENDEDOR
                          WHERE old.COD_VENDEDOR IS NULL

                      END


                        -- CARGA TABLA INTERMEDIA FACT_VENTAS --

						USE [DW_COMERCIAL]
						GO

                        SET ANSI_NULLS ON
                    GO
                      SET QUOTED_IDENTIFIER ON
                  GO

                    CREATE PROCEDURE [dbo].[SP_Carga_Int_Fact_Ventas]

                    AS
                    BEGIN

                      SET NOCOUNT ON;

                      TRUNCATE TABLE Int_Fact_Ventas

                      INSERT INTO Int_Fact_Ventas ([COD_PRODUCTO]
                      , [COD_CATEGORIA]
                      , [COD_CLIENTE]
                      , [COD_PAIS]
                      , [COD_VENDEDOR]
                      , [COD_SUCURSAL]
                      , [Fecha]
                      , [CANTIDAD_VENDIDA]
                      , [MONTO_VENDIDO]
                      , [PRECIO]
                      , [COMISION_COMERCIAL])
                        SELECT
                          CAST(COD_PRODUCTO AS varchar(15)),
                          CAST(COD_CATEGORIA AS varchar(15)),
                          CAST(COD_CLIENTE AS varchar(15)),
                          CAST(COD_PAIS AS varchar(15)),
                          CAST(COD_VENDEDOR AS varchar(15)),
                          CAST(COD_SUCURSAL AS varchar(15)),
                          CONVERT(smalldatetime, FECHA),
                          CAST(CANTIDAD_VENDIDA AS decimal(18, 2)),
                          CAST(MONTO_VENDIDO AS decimal(18, 2)),
                          CAST(PRECIO AS decimal(18, 2)),
                          CAST(COMISION_COMERCIAL AS decimal(18, 2))

                        FROM [dbo].[STG_FACT_VENTAS]
                    END

                      -- exec [dbo].[SP_Carga_Int_Fact_Ventas] --


                      -- CARGA TABLA DIM_FACT_VENTAS --
						
						USE [DW_COMERCIAL]
						GO

                      SET ANSI_NULLS ON
                  GO
                    SET QUOTED_IDENTIFIER ON
                GO

                  CREATE PROCEDURE [dbo].[SP_Carga_Fact_Ventas] @FechaDesde smalldatetime,
                  @FechaHasta smalldatetime

                  AS
                  BEGIN

                    SET NOCOUNT ON;

                    DELETE FROM Fact_Ventas
                    WHERE TIEMPO_KEY BETWEEN @FechaDesde AND @FechaHasta

                    -- INSERTO NUEVOS REGISTROS
                    INSERT INTO Fact_Ventas (f.PRODUCTO_KEY,
                    f.CATEGORIA_KEY
                    , f.CLIENTE_KEY
                    , f.PAIS_KEY
                    , f.VENDEDOR_KEY
                    , f.SUCURSAL_KEY
                    , f.TIEMPO_KEY
                    , f.CANTIDAD_VENDIDA
                    , f.MONTO_VENDIDO
                    , f.PRECIO
                    , f.COMISION_COMERCIAL)
                      SELECT
                        ISNULL(prod.PRODUCTO_KEY, -1) AS PRODUCTO_KEY,
                        ISNULL(c.CATEGORIA_KEY, -1) AS CATEGORIA_KEY,
                        ISNULL(cl.CLIENTE_KEY, -1) AS CLIENTE_KEY,
                        ISNULL(p.PAIS_KEY, -1) AS PAIS_KEY,
                        ISNULL(tie.TIEMPO_KEY, -1) AS Tiempo_KEY,
                        ISNULL(v.VENDEDOR_KEY, -1) AS VENDEDOR_KEY,
                        ISNULL(suc.SUCURSAL_KEY, -1) AS SUCURSAL_KEY,
                        i.CANTIDAD_VENDIDA,
                        i.MONTO_VENDIDO,
                        i.PRECIO,
                        i.COMISION_COMERCIAL
                      FROM Int_Fact_Ventas i
                      LEFT JOIN Dim_Producto prod
                        ON i.COD_PRODUCTO = prod.COD_PRODUCTO
                      LEFT JOIN DIM_CATEGORIA c
                        ON i.COD_CATEGORIA = c.COD_CATEGORIA
                      LEFT JOIN DIM_CLIENTE cl
                        ON i.COD_CLIENTE = cl.COD_CLIENTE
                      LEFT JOIN Dim_PAIS p
                        ON i.COD_PAIS = p.COD_PAIS
                      LEFT JOIN Dim_Tiempo tie
                        ON i.Fecha = tie.TIEMPO_KEY
                      LEFT JOIN DIM_VENDEDOR v
                        ON i.COD_VENDEDOR = v.COD_VENDEDOR
                      LEFT JOIN DIM_SUCURSAL suc
                        ON i.COD_SUCURSAL = suc.COD_SUCURSAL

                      WHERE i.Fecha BETWEEN @FechaDesde AND @FechaHasta

                  END
