--
-- You need to replace ORACLE_HOME for your own Path.
CREATE TABLESPACE CO_DAT DATAFILE 
  'ORACLE_HOME\CO_DAT.DBF' SIZE 2M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--

CREATE TABLESPACE CO_IDX DATAFILE 
  'ORACLE_HOME\CO_IDX.DBF' SIZE 1M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--
-- You should change the user's password
CREATE USER CO
  IDENTIFIED BY CO
  DEFAULT TABLESPACE CO_DAT
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  GRANT RESOURCE TO CO;
  GRANT CONNECT TO CO;
  ALTER USER CO DEFAULT ROLE ALL;
  GRANT ALTER USER TO CO;
  GRANT CREATE SESSION TO CO;
  GRANT CREATE PROCEDURE TO CO;
  GRANT UNLIMITED TABLESPACE TO CO;
  GRANT CREATE ANY INDEX TO CO;
  GRANT CREATE VIEW TO CO;
  GRANT CREATE PUBLIC SYNONYM TO CO;
  ALTER USER CO QUOTA UNLIMITED ON CO_DAT;
  ALTER USER CO QUOTA UNLIMITED ON CO_IDX;

--
-- Tables
CREATE TABLE CO.CO_SALDOS_CLIENTES
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  COD_COBRO         NUMBER(10)                       NOT NULL,
  COD_CLIENTE       NUMBER(10)                       NOT NULL,
  COD_MONEDA        VARCHAR2(4 BYTE)                 NOT NULL,
  MONTO_COBRO       NUMBER(18, 2)                    DEFAULT 0,
  MONTO_PAGADO      NUMBER(18, 2)                    DEFAULT 0,
  MONTO_SALDO       NUMBER(18, 2)                    DEFAULT 0,
  NO_VENTA_ASOCIADA NUMBER(10),
  FECHA_REG_COBRO   DATE,
  COD_ESTADO        VARCHAR2(4 BYTE)                 DEFAULT 'REG',
  OBSERVACIONES     VARCHAR2(500 BYTE),
  OBSER_ANULA       VARCHAR2(500 BYTE),
  USER_ANULA        VARCHAR2(30 BYTE),
  FECHA_ANULA       DATE,
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE
)
TABLESPACE CO_DAT
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


CREATE UNIQUE INDEX CO.PK_CO_SALDOS_CLIENTES ON CO.CO_SALDOS_CLIENTES
(COD_COMPANIA, COD_COBRO)
LOGGING
TABLESPACE CO_IDX
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
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE PUBLIC SYNONYM CO_SALDOS_CLIENTES FOR CO.CO_SALDOS_CLIENTES;


ALTER TABLE CO_SALDOS_CLIENTES.CO_SALDOS_CLIENTES ADD (
  CONSTRAINT PK_CO_SALDOS_CLIENTES
 PRIMARY KEY
 (COD_COMPANIA, COD_COBRO)
    USING INDEX 
    TABLESPACE CO_IDX
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

ALTER TABLE CO.CO_SALDOS_CLIENTES
 ADD CONSTRAINT FK_MONEDAS_SALDOS_CLIENTES
 FOREIGN KEY (COD_COMPANIA, COD_MONEDA) 
 REFERENCES PA.PA_MONEDAS (COD_COMPANIA, COD_MONEDA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON CO.CO_SALDOS_CLIENTES TO PUBLIC;

--
--
CREATE SEQUENCE CO.SQ_CODCOBRO
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999999999
NOCACHE 
NOCYCLE 
NOORDER;

GRANT SELECT ON CO.SQ_CODCOBRO TO PUBLIC;

CREATE PUBLIC SYNONYM SQ_CODCOBRO FOR CO.SQ_CODCOBRO;

--
--
--
--
CREATE OR REPLACE FUNCTION CO.OBT_SALDO_CLIENTE(pCodCompania  IN  VARCHAR2, 
                                                pCodCliente   IN  NUMBER,
                                                pCodMoneda    IN  VARCHAR2,
                                                pFecSaldo     IN  DATE
                                               ) RETURN NUMBER IS  
   --
   --  Se encarga de obtener el saldo del cliente a una fecha dada
   --
   vMontoSaldo  NUMBER(18, 2) := 0;
   --
BEGIN
   --
   Select Nvl(Sum(Monto_Saldo), 0)
     into vMontoSaldo
     from Co_Saldos_Clientes
    where Cod_Compania     = pCodCompania
      and Cod_Cliente      = pCodCliente
      and Cod_Moneda       = pCodMoneda
      and Fecha_Reg_Cobro <= pFecSaldo
      and Cod_Estado       = 'REG'; 
   --
   Return vMontoSaldo;
   --
EXCEPTION
   WHEN OTHERS THEN
       Return 0;
END;

GRANT EXECUTE ON CO.OBT_SALDO_CLIENTE TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_SALDO_CLIENTE FOR CO.OBT_SALDO_CLIENTE;

--

CREATE OR REPLACE PROCEDURE CO.CREA_SALDO_CL(pCodCompania   IN VARCHAR2,
                                             pCodCliente    IN NUMBER,
                                             pCodMoneda     IN VARCHAR2, 
                                             pMontoCobro    IN NUMBER, 
                                             pNoVenta       IN NUMBER,
                                             pFechaCobro    IN DATE,
                                             pCodEstado     IN VARCHAR2, 
                                             pObservaciones IN VARCHAR2,
                                             pEstadoEj      OUT BOOLEAN,
                                             pError         OUT VARCHAR2
                                            ) IS
   --
   -- Registra una nueva linea de saldo para el cliente indicado
   --
   vConsCobro  Number(10);
   --
BEGIN
   --
   Begin
     Select SQ_CodCobro.NextVal
       into vConsCobro
       from Dual;
   Exception
     When Others Then
         pEstadoEj := FALSE;
         pError    := 'Error al generar el consecutivo de cobro';
         Return;
   End;
   --
   Insert Into Co_Saldos_Clientes(Cod_Compania, Cod_Cobro, Cod_Cliente,
                                  Cod_Moneda, Monto_Cobro, Monto_Pagado, 
                                  Monto_Saldo, No_Venta_Asociada, Fecha_Reg_Cobro, 
                                  Cod_Estado, Observaciones, User_Reg, 
                                  Fecha_Reg
                                 )
          Values                 (pCodCompania, vConsCobro, pCodCliente,
                                  pCodMoneda, pMontoCobro, 0,
                                  pMontoCobro, pNoVenta, pFechaCobro,
                                  pCodEstado, pObservaciones, User,
                                  Trunc(Sysdate)
                                 );
   --
   pEstadoEj := TRUE;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al registrar saldo para el cliente - '||Sqlerrm;
END;

GRANT EXECUTE ON CO.CREA_SALDO_CL TO PUBLIC;

CREATE PUBLIC SYNONYM CREA_SALDO_CL FOR CO.CREA_SALDO_CL;

--