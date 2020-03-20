--
-- You need to replace ORACLE_HOME for your own Path.
CREATE TABLESPACE VT_DAT DATAFILE 
  'ORACLE_HOME\VT_DAT.DBF' SIZE 2M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--

CREATE TABLESPACE VT_IDX DATAFILE 
  'ORACLE_HOME\VT_IDX.DBF' SIZE 1M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--
-- You should change the user's password
CREATE USER VT
  IDENTIFIED BY VT 
  DEFAULT TABLESPACE VT_DAT
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  GRANT RESOURCE TO VT;
  GRANT CONNECT TO VT;
  ALTER USER VT DEFAULT ROLE ALL;
  GRANT ALTER USER TO VT;
  GRANT CREATE SESSION TO VT;
  GRANT CREATE PROCEDURE TO VT;
  GRANT UNLIMITED TABLESPACE TO VT;
  GRANT CREATE ANY INDEX TO VT;
  GRANT CREATE VIEW TO VT;
  GRANT CREATE PUBLIC SYNONYM TO VT;
  ALTER USER VT QUOTA UNLIMITED ON VT_DAT;
  ALTER USER VT QUOTA UNLIMITED ON VT_IDX;

--
-- Tablas
CREATE TABLE VT.VT_ENCA_VENTAS
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  NUM_VENTA         NUMBER(10)                       NOT NULL,
  COD_MONEDA        VARCHAR2(4 BYTE)                 NOT NULL,
  FECHA_VENTA       DATE                             NOT NULL,
  COD_CLIENTE       NUMBER(10)                       NOT NULL,
  NOMBRE_CLIENTE    VARCHAR2(300 BYTE),
  DIRECCION         VARCHAR2(500 BYTE),
  COD_ESTADO        VARCHAR2(4 BYTE)                 DEFAULT 'REG',
  FORMA_PAGO        VARCHAR2(4 BYTE)                 DEFAULT 'CO',
  TOTAL_DESCUENTO   NUMBER(18, 2)                    DEFAULT 0,
  TOTAL_GENERAL     NUMBER(18, 2)                    DEFAULT 0,
  OBSERVACIONES     VARCHAR2(200 BYTE),
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_ANULA        VARCHAR2(30 BYTE),
  FECHA_ANULA       DATE,
  OBSER_ANULA       VARCHAR2(500 BYTE)
)
TABLESPACE VT_DAT
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          10880K
            NEXT             40K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE PUBLIC SYNONYM VT_ENCA_VENTAS FOR VT.VT_ENCA_VENTAS;


ALTER TABLE VT.VT_ENCA_VENTAS ADD (
  CONSTRAINT PK_VT_ENCA_VENTAS
 PRIMARY KEY
 (COD_COMPANIA, NUM_VENTA)
    USING INDEX 
    TABLESPACE VT_IDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          4160K
                NEXT             40K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
               ));

ALTER TABLE VT.VT_ENCA_VENTAS
 ADD CONSTRAINT FK_MONEDAS_VT_ENCA_VENTAS
 FOREIGN KEY (COD_COMPANIA, COD_MONEDA) 
 REFERENCES PA.PA_MONEDAS (COD_COMPANIA, COD_MONEDA);

ALTER TABLE VT.VT_ENCA_VENTAS
 ADD CONSTRAINT FK_PA_COMPANIA_VT_ENCA_VENTAS
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON VT.VT_ENCA_VENTAS TO PUBLIC;

--

CREATE TABLE VT.VT_DETA_VENTAS
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  NUM_VENTA         NUMBER(10)                       NOT NULL,
  COD_PRODUCTO      NUMBER(10)                       NOT NULL,
  CANT_PRODUCTO     NUMBER(10)                       DEFAULT 0,
  PRECIO_VENTA      NUMBER(18, 2)                    DEFAULT 0,
  MONTO_DESCUENTO   NUMBER(18, 2)                    DEFAULT 0,
  TOTAL_PRECIO      NUMBER(18, 2)                    DEFAULT 0
)
TABLESPACE VT_DAT
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          10880K
            NEXT             40K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

CREATE PUBLIC SYNONYM VT_DETA_VENTAS FOR VT.VT_DETA_VENTAS;


ALTER TABLE VT.VT_DETA_VENTAS ADD (
  CONSTRAINT PK_VT_DETA_VENTAS
 PRIMARY KEY
 (COD_COMPANIA, NUM_VENTA, COD_PRODUCTO)
    USING INDEX 
    TABLESPACE VT_IDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          4160K
                NEXT             40K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
               ));
               
ALTER TABLE VT.VT_DETA_VENTAS
 ADD CONSTRAINT FK_ENCA_VENTAS_DETA_VENTAS
 FOREIGN KEY (COD_COMPANIA, NUM_VENTA) 
 REFERENCES VT.VT_ENCA_VENTAS (COD_COMPANIA, NUM_VENTA);

ALTER TABLE VT.VT_DETA_VENTAS
 ADD CONSTRAINT FK_PRODUCTOS_DETA_VENTAS
 FOREIGN KEY (COD_COMPANIA, COD_PRODUCTO) 
 REFERENCES IV.IV_PRODUCTOS (COD_COMPANIA, COD_PRODUCTO);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON VT.VT_DETA_VENTAS TO PUBLIC;

--
--

CREATE SEQUENCE VT.SQ_NOVENTA
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999999999
NOCACHE 
NOCYCLE 
NOORDER;

GRANT SELECT ON VT.SQ_NOVENTA TO PUBLIC;

CREATE PUBLIC SYNONYM SQ_NOVENTA FOR VT.SQ_NOVENTA;

--

CREATE OR REPLACE FUNCTION VT.OBT_DAT_TRANSAC_VT(pCodCompania  IN  VARCHAR2,
                                                 pEstadoEj     OUT BOOLEAN,
                                                 pError        OUT VARCHAR2
                                                ) RETURN IV_TIP_TRANSACCIONES%ROWTYPE IS  
   --
   --  Se encarga de obtener la transacción de inventario asociada a ventas
   --
   vDatTransac  Iv_Tip_Transacciones%RowType;
   --
BEGIN
   --
   Select *
     into vDatTransac
     from Iv_Tip_Transacciones
    where Cod_Compania    = pCodCompania
      and Efecto_Transac  = '-' -- Resta o Salida
      and Cod_Estado      = 'ACT' -- Activo
      and Asociada_Ventas = 'S'; -- Asociada
   --
   pEstadoEj := TRUE;
   --
   Return vDatTransac;
   --
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       --
       pEstadoEj := FALSE;
       pError    := 'No existe una transacción asociada a ventas';
       Return NULL;
       --
   WHEN TOO_MANY_ROWS THEN
       --
       pEstadoEj := FALSE;
       pError    := 'Existe más de una transacción asociada a ventas';
       Return NULL;
       --
   WHEN OTHERS THEN
       --
       pEstadoEj := FALSE;
       pError    := 'Error al obtener la transacción asociada a ventas - '||Sqlerrm;
       Return NULL;
       --
END;

GRANT EXECUTE ON VT.OBT_DAT_TRANSAC_VT TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_DAT_TRANSAC_VT FOR VT.OBT_DAT_TRANSAC_VT;

--