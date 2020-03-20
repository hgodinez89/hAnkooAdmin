--
-- You need to replace ORACLE_HOME for your own Path.
CREATE TABLESPACE IV_DAT DATAFILE 
  'ORACLE_HOME\IV_DAT.DBF' SIZE 2M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--

CREATE TABLESPACE IV_IDX DATAFILE 
  'ORACLE_HOME\IV_IDX.DBF' SIZE 1M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--
-- You should change the user's password
CREATE USER IV
  IDENTIFIED BY IV 
  DEFAULT TABLESPACE IV_DAT
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  GRANT RESOURCE TO IV;
  GRANT CONNECT TO IV;
  ALTER USER IV DEFAULT ROLE ALL;
  GRANT ALTER USER TO IV;
  GRANT CREATE SESSION TO IV;
  GRANT CREATE PROCEDURE TO IV;
  GRANT UNLIMITED TABLESPACE TO IV;
  GRANT CREATE ANY INDEX TO IV;
  GRANT CREATE VIEW TO IV;
  GRANT CREATE PUBLIC SYNONYM TO IV;
  ALTER USER IV QUOTA UNLIMITED ON IV_DAT;
  ALTER USER IV QUOTA UNLIMITED ON IV_IDX;

--
-- Tables
CREATE TABLE IV.IV_PRODUCTOS
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  COD_PRODUCTO      NUMBER(10)                       NOT NULL,
  DES_PRODUCTO      VARCHAR2(100 BYTE),
  COD_MONEDA        VARCHAR2(4 BYTE)                 NOT NULL,
  MON_COSTOCOMPRA   NUMBER(18, 4)                    DEFAULT 0,
  MON_PRECIOVENTA   NUMBER(18, 2)                    DEFAULT 0,
  CANT_EXISTMINIMA  NUMBER(10)                       DEFAULT 0,
  COD_ESTADO        VARCHAR2(4 BYTE)                 DEFAULT 'ACT',
  OBSERVACIONES     VARCHAR2(200 BYTE),
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_MOD          VARCHAR2(30 BYTE),
  FECHA_MOD         DATE
)
TABLESPACE IV_DAT
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


CREATE UNIQUE INDEX IV.PK_IV_PRODUCTOS ON IV.IV_PRODUCTOS
(COD_COMPANIA, COD_PRODUCTO)
LOGGING
TABLESPACE IV_IDX
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


CREATE PUBLIC SYNONYM IV_PRODUCTOS FOR IV.IV_PRODUCTOS;


ALTER TABLE IV.IV_PRODUCTOS ADD (
  CONSTRAINT PK_IV_PRODUCTOS
 PRIMARY KEY
 (COD_COMPANIA, COD_PRODUCTO)
    USING INDEX 
    TABLESPACE IV_IDX
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

ALTER TABLE IV.IV_PRODUCTOS
 ADD CONSTRAINT FK_MONEDAS_IV_PRODUCTOS
 FOREIGN KEY (COD_COMPANIA, COD_MONEDA) 
 REFERENCES PA.PA_MONEDAS (COD_COMPANIA, COD_MONEDA);

ALTER TABLE IV.IV_PRODUCTOS
 ADD CONSTRAINT FK_PA_COMPANIA_IV_PRODUCTOS 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON IV.IV_PRODUCTOS TO PUBLIC;

--

CREATE TABLE IV.IV_TIP_TRANSACCIONES
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  COD_TRANSACCION   NUMBER(10)                       NOT NULL,
  DES_TRANSACCION   VARCHAR2(100 BYTE),
  EFECTO_TRANSAC    VARCHAR2(1 BYTE)                 NOT NULL,
  COD_ESTADO        VARCHAR2(4 BYTE)                 DEFAULT 'ACT',
  ASOCIADA_VENTAS   VARCHAR2(1 BYTE)                 DEFAULT 'N',
  OBSERVACIONES     VARCHAR2(200 BYTE),
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_MOD          VARCHAR2(30 BYTE),
  FECHA_MOD         DATE
)
TABLESPACE IV_DAT
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


CREATE UNIQUE INDEX IV.PK_IV_TIP_TRANSACCIONES ON IV.IV_TIP_TRANSACCIONES
(COD_COMPANIA, COD_TRANSACCION)
LOGGING
TABLESPACE IV_IDX
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


CREATE PUBLIC SYNONYM IV_TIP_TRANSACCIONES FOR IV.IV_TIP_TRANSACCIONES;


ALTER TABLE IV.IV_TIP_TRANSACCIONES ADD (
  CONSTRAINT PK_IV_TIP_TRANSACCIONES
 PRIMARY KEY
 (COD_COMPANIA, COD_TRANSACCION)
    USING INDEX 
    TABLESPACE IV_IDX
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

ALTER TABLE IV.IV_TIP_TRANSACCIONES
 ADD CONSTRAINT FK_PA_COMPANIA_TRANSACCIONES 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON IV.IV_TIP_TRANSACCIONES TO PUBLIC;

--

CREATE TABLE IV.IV_ENCA_TRANSACCIONES
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  NUM_TRANSACCION   NUMBER(10)                       NOT NULL,
  TIPO_MOVIMIENTO   VARCHAR2(1 BYTE)                 NOT NULL,
  TIPO_TRANSACCION  NUMBER(10)                       NOT NULL,
  COD_MONEDA        VARCHAR2(4 BYTE)                 NOT NULL,
  COD_ESTADO        VARCHAR2(4 BYTE)                 DEFAULT 'REG',
  OBSERVACIONES     VARCHAR2(200 BYTE),
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_ANULA        VARCHAR2(30 BYTE),
  FECHA_ANULA       DATE,
  OBSER_ANULA       VARCHAR2(500 BYTE)
)
TABLESPACE IV_DAT
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


CREATE UNIQUE INDEX IV.PK_IV_ENCA_TRANSACCIONES ON IV.IV_ENCA_TRANSACCIONES
(COD_COMPANIA, NUM_TRANSACCION)
LOGGING
TABLESPACE IV_IDX
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


CREATE PUBLIC SYNONYM IV_ENCA_TRANSACCIONES FOR IV.IV_ENCA_TRANSACCIONES;


ALTER TABLE IV.IV_ENCA_TRANSACCIONES ADD (
  CONSTRAINT PK_IV_ENCA_TRANSACCIONES
 PRIMARY KEY
 (COD_COMPANIA, NUM_TRANSACCION)
    USING INDEX 
    TABLESPACE IV_IDX
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

ALTER TABLE IV.IV_ENCA_TRANSACCIONES
 ADD CONSTRAINT FK_TIP_TRANSAC_ENCA_TRANSAC
 FOREIGN KEY (COD_COMPANIA, TIPO_TRANSACCION) 
 REFERENCES IV.IV_TIP_TRANSACCIONES (COD_COMPANIA, COD_TRANSACCION);

ALTER TABLE IV.IV_ENCA_TRANSACCIONES
 ADD CONSTRAINT FK_MONEDAS_ENCA_TRANSACCIONES
 FOREIGN KEY (COD_COMPANIA, COD_MONEDA) 
 REFERENCES PA.PA_MONEDAS (COD_COMPANIA, COD_MONEDA);

ALTER TABLE IV.IV_ENCA_TRANSACCIONES
 ADD CONSTRAINT FK_PA_COMPANIA_ENCA_TRANSAC
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON IV.IV_ENCA_TRANSACCIONES TO PUBLIC;

--

CREATE TABLE IV.IV_DETA_TRANSACCIONES
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  NUM_TRANSACCION   NUMBER(10)                       NOT NULL,
  COD_PRODUCTO      NUMBER(10)                       NOT NULL,
  EXISTENCIA_ACTUAL NUMBER(10)                       DEFAULT 0,
  CANT_PRODUCTO     NUMBER(10)                       DEFAULT 0,
  COSTO_PRODUCTO    NUMBER(18, 4)                    DEFAULT 0,
  COSTO_TOT_PRODUC  NUMBER(18, 4)                    DEFAULT 0
)
TABLESPACE IV_DAT
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


CREATE UNIQUE INDEX IV.PK_IV_DETA_TRANSACCIONES ON IV.IV_DETA_TRANSACCIONES
(COD_COMPANIA, NUM_TRANSACCION, COD_PRODUCTO)
LOGGING
TABLESPACE IV_IDX
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


CREATE PUBLIC SYNONYM IV_DETA_TRANSACCIONES FOR IV.IV_DETA_TRANSACCIONES;


ALTER TABLE IV.IV_DETA_TRANSACCIONES ADD (
  CONSTRAINT PK_IV_DETA_TRANSACCIONES
 PRIMARY KEY
 (COD_COMPANIA, NUM_TRANSACCION, COD_PRODUCTO)
    USING INDEX 
    TABLESPACE IV_IDX
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

ALTER TABLE IV.IV_DETA_TRANSACCIONES
 ADD CONSTRAINT FK_ENCA_TRANSAC_DETA_TRANSAC
 FOREIGN KEY (COD_COMPANIA, NUM_TRANSACCION) 
 REFERENCES IV.IV_ENCA_TRANSACCIONES (COD_COMPANIA, NUM_TRANSACCION);

ALTER TABLE IV.IV_DETA_TRANSACCIONES
 ADD CONSTRAINT FK_PRODUCTOS_DETA_TRANSAC
 FOREIGN KEY (COD_COMPANIA, COD_PRODUCTO) 
 REFERENCES IV.IV_PRODUCTOS (COD_COMPANIA, COD_PRODUCTO);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON IV.IV_DETA_TRANSACCIONES TO PUBLIC;

--

CREATE TABLE IV.IV_EXIST_COST_PRODUCTOS
(
  COD_COMPANIA       VARCHAR2(4 BYTE)                 NOT NULL,
  COD_PRODUCTO       NUMBER(10)                       NOT NULL,
  TOTAL_EXISTENCIA   NUMBER(10)                       DEFAULT 0,
  COSTO_X_EXISTENCIA NUMBER(18, 4)                    DEFAULT 0
)
TABLESPACE IV_DAT
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


CREATE UNIQUE INDEX IV.PK_IV_EXIST_COST_PRODUCTOS ON IV.IV_EXIST_COST_PRODUCTOS
(COD_COMPANIA, COD_PRODUCTO)
LOGGING
TABLESPACE IV_IDX
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


CREATE PUBLIC SYNONYM IV_EXIST_COST_PRODUCTOS FOR IV.IV_EXIST_COST_PRODUCTOS;


ALTER TABLE IV.IV_EXIST_COST_PRODUCTOS ADD (
  CONSTRAINT PK_IV_EXIST_COST_PRODUCTOS
 PRIMARY KEY
 (COD_COMPANIA, COD_PRODUCTO)
    USING INDEX 
    TABLESPACE IV_IDX
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

ALTER TABLE IV.IV_EXIST_COST_PRODUCTOS
 ADD CONSTRAINT FK_PRODUCTOS_EXIST_COST
 FOREIGN KEY (COD_COMPANIA, COD_PRODUCTO) 
 REFERENCES IV.IV_PRODUCTOS (COD_COMPANIA, COD_PRODUCTO);              

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON IV.IV_EXIST_COST_PRODUCTOS TO PUBLIC;

--
--

CREATE SEQUENCE IV.SQ_CODTRANSACCION
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999999999
NOCACHE 
NOCYCLE 
NOORDER;

GRANT SELECT ON IV.SQ_CODTRANSACCION TO PUBLIC;

CREATE PUBLIC SYNONYM SQ_CODTRANSACCION FOR IV.SQ_CODTRANSACCION;

--
CREATE SEQUENCE IV.SQ_CODPRODUCTO
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999999999
NOCACHE 
NOCYCLE 
NOORDER;

GRANT SELECT ON IV.SQ_CODPRODUCTO TO PUBLIC;

CREATE PUBLIC SYNONYM SQ_CODPRODUCTO FOR IV.SQ_CODPRODUCTO;

--

CREATE SEQUENCE IV.SQ_NOTRANSACCION
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999999999
NOCACHE 
NOCYCLE 
NOORDER;

GRANT SELECT ON IV.SQ_NOTRANSACCION TO PUBLIC;

CREATE PUBLIC SYNONYM SQ_NOTRANSACCION FOR IV.SQ_NOTRANSACCION;
--
--

CREATE OR REPLACE FUNCTION IV.OBT_TOTAL_EXISTENCIA(pCodCompania  IN  VARCHAR2, 
                                                   pCodProducto  IN  NUMBER
                                                  ) RETURN NUMBER IS  
   --
   --  Se encarga de obtener el total de existencias para un producto
   --
   vTotalExist  NUMBER(10) := 0;
   --
BEGIN
   --
   Select Total_Existencia
     into vTotalExist
     from Iv_Exist_Cost_Productos
    where Cod_Compania = pCodCompania
      and Cod_Producto = pCodProducto; 
   --
   Return vTotalExist;
   --
EXCEPTION
   WHEN OTHERS THEN
       Return 0;
END;

GRANT EXECUTE ON IV.OBT_TOTAL_EXISTENCIA TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_TOTAL_EXISTENCIA FOR IV.OBT_TOTAL_EXISTENCIA;

--

CREATE OR REPLACE FUNCTION IV.OBT_DES_PRODUCTO(pCodCompania  IN  VARCHAR2, 
                                               pCodProducto  IN  NUMBER,
                                               pCodEstado    IN  VARCHAR2,
                                               pCodMoneda    IN  VARCHAR2,
                                               pEstadoEj     OUT BOOLEAN,
                                               pError        OUT VARCHAR2
                                              ) RETURN VARCHAR2 IS  
   --
   --  Se encarga de obtener la descripci�n del articulo o producto
   --
   vDesProducto  VARCHAR2(100) := 0;
   --
BEGIN
   --
   Select Des_Producto
     into vDesProducto
     from Iv_Productos 
    where Cod_Compania = pCodCompania
      and Cod_Producto = pCodProducto
      and Cod_Estado   = Nvl(pCodEstado, Cod_Estado)
      and Cod_Moneda   = pCodMoneda;
   --
   pEstadoEj := TRUE;
   --
   Return vDesProducto;
   --
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       --
       pEstadoEj := FALSE;
       --
       If pCodEstado = 'ACT' Then
          pError    := 'El producto no existe o se encuentra inactivo';
       Elsif pCodEstado = 'INA' Then
          pError    := 'El producto '||pCodProducto||' no existe en estado inactivo';
       Else
          pError    := 'El producto '||pCodProducto||' no existe';
       End If;
       --
       Return NULL;
       --
   WHEN OTHERS THEN
       --
       pEstadoEj := FALSE;
       pError    := 'Error al consultar el nombre del producto - '||Sqlerrm;
       Return NULL;
       --
END;

GRANT EXECUTE ON IV.OBT_DES_PRODUCTO TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_DES_PRODUCTO FOR IV.OBT_DES_PRODUCTO;

--

CREATE OR REPLACE FUNCTION IV.OBT_COSTO_X_EXISTENCIA(pCodCompania  IN  VARCHAR2, 
                                                     pCodProducto  IN  NUMBER
                                                    ) RETURN NUMBER IS  
   --
   --  Se encarga de obtener el costo por producto en existencia
   --
   vCostoExist  NUMBER(18, 4) := 0;
   --
BEGIN
   --
   Select Costo_x_Existencia
     into vCostoExist
     from Iv_Exist_Cost_Productos
    where Cod_Compania = pCodCompania
      and Cod_Producto = pCodProducto; 
   --
   Return vCostoExist;
   --
EXCEPTION
   WHEN OTHERS THEN
       Return 0;
END;

GRANT EXECUTE ON IV.OBT_COSTO_X_EXISTENCIA TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_COSTO_X_EXISTENCIA FOR IV.OBT_COSTO_X_EXISTENCIA;

--

CREATE OR REPLACE PROCEDURE IV.CALC_EXIST_COST_PRODUC(pCodCompania    IN  VARCHAR2, 
                                                      pCodProducto    IN  NUMBER,
                                                      pTipoMov        IN  VARCHAR2,
                                                      pMovAnulacion   IN  VARCHAR2,
                                                      pUnidProducto   IN  NUMBER,
                                                      pCostoTotProduc IN  NUMBER,
                                                      pExistFinal     OUT NUMBER,
                                                      pCostoFinal     OUT NUMBER,
                                                      pEstadoEj       OUT BOOLEAN,
                                                      pError          OUT VARCHAR2
                                                     ) IS  
   --
   --  Se encarga de obtener el costo de un producto
   --
   vExistActual      NUMBER(10) := 0;
   vCostoxExist      NUMBER(18, 4) := 0;
   vCostoAcum        NUMBER(18, 4) := 0;
   vMetodoValuacion  VARCHAR2(5);
   --
   vEstadoEj         BOOLEAN;
   vMsjError         VARCHAR2(400);
   --
BEGIN
   --
   -- Obtiene el metodo de valuaci�n utilizado
   vMetodoValuacion := Obt_Param_Empresa(pCodCompania,
                                         'P_METODOVALINV',
                                         vEstadoEj,
                                         vMsjError
                                        );
   --
   If Not vEstadoEj Then
      pEstadoEj := FALSE;
      pError    := vMsjError;
      Return;
   End If;
   --
   vExistActual := Obt_Total_Existencia(pCodCompania, 
                                        pCodProducto
                                       );
   --
   vCostoxExist := Obt_Costo_x_Existencia(pCodCompania, 
                                          pCodProducto
                                         );
   --
   If vMetodoValuacion = 'PROMP' Then
      --
      If pTipoMov = 'E' Then
         --
         vCostoAcum := (vExistActual * vCostoxExist) + pCostoTotProduc;
         --
         pExistFinal := vExistActual + pUnidProducto;
         --
         pCostoFinal := vCostoAcum / pExistFinal;
         --
      Else
         --
         pExistFinal := vExistActual - pUnidProducto;
         --
         If pMovAnulacion = 'S' Then
            --
            If pExistFinal = 0 Then
               pCostoFinal := 0;
            Else
               pCostoFinal := ((vExistActual * vCostoxExist) - pCostoTotProduc) / pExistFinal;
            End If;
            --
         Else
            --
            If pExistFinal = 0 Then
               pCostoFinal := 0;
            Else
               pCostoFinal := vCostoxExist;
            End If;
            -- 
         End If;
         --
      End If; 
      --
   Elsif vMetodoValuacion = 'NA' Then
      --
      If pTipoMov = 'E' Then
         --
         pExistFinal := vExistActual + pUnidProducto;
         pCostoFinal := pCostoTotProduc / pUnidProducto;
         --
      Else
         --
         pExistFinal := vExistActual - pUnidProducto;
         --
         If pExistFinal = 0 Then
            pCostoFinal := 0;
         Else
            pCostoFinal := vCostoxExist;
         End If;         
         --
      End If; 
      --
   Else
      --
      pEstadoEj := FALSE;
      pError    := 'Error al calcular las nuevas existencias y costos, no existe un m�todo de valuaci�n definido';
      Return;
      --
   End If; 
   --
   If pExistFinal < 0 Then
      pEstadoEj := FALSE;
      pError    := 'No hay existencias suficientes para realizar la operaci�n';
      Return;
   End If;
   --
   pEstadoEj := TRUE;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al calcular las nuevas existencias y costos del producto '||pCodProducto||' - '||Sqlerrm;
END;

GRANT EXECUTE ON IV.CALC_EXIST_COST_PRODUC TO PUBLIC;

CREATE PUBLIC SYNONYM CALC_EXIST_COST_PRODUC FOR IV.CALC_EXIST_COST_PRODUC;

--

CREATE OR REPLACE PROCEDURE IV.ACT_EXIST_COSTO(pCodCompania    IN VARCHAR2,
                                               pCodProducto    IN NUMBER,
                                               pTipoMov        IN VARCHAR2,
                                               pMovAnulacion   IN  VARCHAR2,
                                               pUnidProducto   IN NUMBER,
                                               pCostoTotProduc IN NUMBER,
                                               pEstadoEj       OUT BOOLEAN,
                                               pError          OUT VARCHAR2
                                              ) IS
   --
   -- Actualiza o crea las existencias y costo del art�culo o producto
   --
   vExistFinal  NUMBER(10) := 0;
   vCostoFinal  NUMBER(18, 4) := 0;
   --
   vEstadoEj         BOOLEAN;
   vMsjError         VARCHAR2(400);
   --
BEGIN
   --
   Calc_Exist_Cost_Produc(pCodCompania, 
                          pCodProducto,
                          pTipoMov,
                          pMovAnulacion,
                          pUnidProducto,
                          pCostoTotProduc,
                          vExistFinal,
                          vCostoFinal,
                          vEstadoEj,
                          vMsjError
                         );
   --
   If Not vEstadoEj Then
      pEstadoEj := FALSE;
      pError    := vMsjError;
      Return;
   End If;
   --
   Update Iv_Exist_Cost_Productos
      set Total_Existencia   = vExistFinal,
          Costo_x_Existencia = vCostoFinal
    where Cod_Compania = pCodCompania
      and Cod_Producto = pCodProducto;
   --
   If Sql%RowCount <= 0 Then
      --
      Insert into Iv_Exist_Cost_Productos(Cod_Compania, Cod_Producto,
                                          Total_Existencia, Costo_x_Existencia
                                         )
                  Values                 (pCodCompania, pCodProducto,
                                          vExistFinal, vCostoFinal
                                         );
      --
   End If;
   --
   pEstadoEj := TRUE;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al actualizar o crear las existencias o costos del producto '||pCodProducto||' - '||Sqlerrm;
END;

GRANT EXECUTE ON IV.ACT_EXIST_COSTO TO PUBLIC;

CREATE PUBLIC SYNONYM ACT_EXIST_COSTO FOR IV.ACT_EXIST_COSTO;

--

CREATE OR REPLACE FUNCTION IV.OBT_DES_TIPTRANSAC(pCodCompania   IN  VARCHAR2, 
                                                 pCodTipTransac IN  NUMBER,
                                                 pCodEfecto     IN  VARCHAR2,
                                                 pCodEstado     IN  VARCHAR2,
                                                 pEstadoEj      OUT BOOLEAN,
                                                 pError         OUT VARCHAR2
                                                ) RETURN VARCHAR2 IS  
   --
   --  Se encarga de obtener la descripci�n del tipo de transacci�n
   --
   vDesTipTransac  VARCHAR2(100);
   --
BEGIN
   --
   Select Des_Transaccion
     into vDesTipTransac
     from Iv_Tip_Transacciones 
    where Cod_Compania    = pCodCompania
      and Cod_Transaccion = pCodTipTransac
      and Efecto_Transac  = Nvl(pCodEfecto, Efecto_Transac) 
      and Cod_Estado      = Nvl(pCodEstado, Cod_Estado);
   --
   pEstadoEj := TRUE;
   --
   Return vDesTipTransac;
   --
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       --
       pEstadoEj := FALSE;
       --
       If pCodEstado = 'ACT' Then
          pError    := 'La transacci�n no existe o se encuentra inactiva';
       Elsif pCodEstado = 'INA' Then
          pError    := 'La transacci�n '||pCodTipTransac||' no existe en estado inactivo';
       Else
          pError    := 'La transacci�n '||pCodTipTransac||' no existe';
       End If;
       --
       Return NULL;
       --
   WHEN OTHERS THEN
       --
       pEstadoEj := FALSE;
       pError    := 'Error al consultar la descripci�n de la transacci�n - '||Sqlerrm;
       Return NULL;
       --
END;

GRANT EXECUTE ON IV.OBT_DES_TIPTRANSAC TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_DES_TIPTRANSAC FOR IV.OBT_DES_TIPTRANSAC;

--

CREATE OR REPLACE FUNCTION IV.CREA_ENCA_TRANSAC(pCodCompania   IN VARCHAR2,
                                                pTipoMov       IN VARCHAR2,  
                                                pTipoTransac   IN NUMBER,
                                                pCodMoneda     IN VARCHAR2, 
                                                pCodEstado     IN VARCHAR2,
                                                pObservaciones IN VARCHAR2, 
                                                pFechaReg      IN DATE,
                                                pEstadoEj      OUT BOOLEAN,
                                                pError         OUT VARCHAR2
                                               ) RETURN NUMBER IS
   --
   -- Registra el encabezado de una transacci�n en inventario
   --
   vConsTransac  Number(10);
   --
BEGIN
   --
   Begin
     Select SQ_CodTransaccion.NextVal
       into vConsTransac
       from Dual;
   Exception
     When Others Then
         pEstadoEj := FALSE;
         pError    := 'Error al generar el n�mero de transacci�n';
         Return NULL;
   End;
   --
   Insert Into Iv_Enca_Transacciones(Cod_Compania, Num_Transaccion, Tipo_Movimiento,
                                     Tipo_Transaccion, Cod_Moneda, Cod_Estado, 
                                     Observaciones, User_Reg, Fecha_Reg
                                    )
          Values                    (pCodCompania, vConsTransac, pTipoMov,
                                     pTipoTransac, pCodMoneda, pCodEstado,
                                     pObservaciones, User, pFechaReg
                                    );
   --
   pEstadoEj := TRUE;
   --
   Return vConsTransac;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al crear el encabezado del movimiento en inventario - '||Sqlerrm;
       Return NULL;
END;

GRANT EXECUTE ON IV.CREA_ENCA_TRANSAC TO PUBLIC;

CREATE PUBLIC SYNONYM CREA_ENCA_TRANSAC FOR IV.CREA_ENCA_TRANSAC;

--

CREATE OR REPLACE PROCEDURE IV.CREA_DETA_TRANSAC(pCodCompania      IN VARCHAR2,
                                                 pNumTransac       IN NUMBER,
                                                 pCodProducto      IN NUMBER,
                                                 pCantProducto     IN NUMBER,
                                                 pCostoProducto    IN NUMBER,
                                                 pCostoTotalProduc IN NUMBER,
                                                 pEstadoEj         OUT BOOLEAN,
                                                 pError            OUT VARCHAR2
                                                ) IS
   --
   -- Registra el detalle de una transacci�n en inventario
   --
   vExistActual  Number(10);
   --
BEGIN
   --
   vExistActual := Obt_Total_Existencia(pCodCompania, 
                                        pCodProducto
                                       );
   --
   Insert Into Iv_Deta_Transacciones(Cod_Compania, Num_Transaccion, Cod_Producto,
                                     Cant_Producto, Costo_Producto, Costo_Tot_Produc, 
                                     Existencia_Actual
                                    )
          Values                    (pCodCompania, pNumTransac, pCodProducto,
                                     pCantProducto, pCostoProducto, pCostoTotalProduc,
                                     vExistActual
                                    );
   --
   pEstadoEj := TRUE;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al crear el detalle del movimiento en inventario - '||Sqlerrm;
END;

GRANT EXECUTE ON IV.CREA_DETA_TRANSAC TO PUBLIC;

CREATE PUBLIC SYNONYM CREA_DETA_TRANSAC FOR IV.CREA_DETA_TRANSAC;

--

CREATE OR REPLACE TRIGGER IV.TRG_ACT_COSTO_PRODUCTO
   AFTER INSERT OR UPDATE OF 
   COSTO_X_EXISTENCIA ON 
   IV.IV_EXIST_COST_PRODUCTOS 
 REFERENCING NEW AS New OLD AS Old
 FOR EACH ROW
BEGIN
  --
  If Nvl(:New.Costo_x_Existencia, 0) > 0 Then
     --
     Update Iv_Productos
        set Mon_CostoCompra = :New.Costo_x_Existencia
      where Cod_Compania    = :New.Cod_Compania
        and Cod_Producto    = :New.Cod_Producto;
     --
  End If; 
  --
END;

--