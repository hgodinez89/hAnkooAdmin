--
-- You need to replace ORACLE_HOME for your own Path.
CREATE TABLESPACE PA_DAT DATAFILE 
  'ORACLE_HOME\PA_DAT.DBF' SIZE 2M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--

CREATE TABLESPACE PA_IDX DATAFILE 
  'ORACLE_HOME\PA_IDX.DBF' SIZE 1M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--
-- You should change the user's password
CREATE USER PA
  IDENTIFIED BY PA
  DEFAULT TABLESPACE PA_DAT
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  GRANT RESOURCE TO PA;
  GRANT CONNECT TO PA;
  ALTER USER PA DEFAULT ROLE ALL;
  GRANT ALTER USER TO PA;
  GRANT CREATE SESSION TO PA;
  GRANT CREATE PROCEDURE TO PA;
  GRANT UNLIMITED TABLESPACE TO PA;
  GRANT CREATE ANY INDEX TO PA;
  GRANT CREATE VIEW TO PA;
  GRANT CREATE PUBLIC SYNONYM TO PA;
  ALTER USER PA QUOTA UNLIMITED ON PA_DAT;
  ALTER USER PA QUOTA UNLIMITED ON PA_IDX;

--
-- Tables
--

CREATE TABLE PA.PA_COMPANIAS
(
  COD_COMPANIA  VARCHAR2(4 BYTE)                 NOT NULL,
  DESCRIPCION   VARCHAR2(400 BYTE)
)
TABLESPACE PA_DAT
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


CREATE UNIQUE INDEX PA.PK_PA_COMPANIAS ON PA.PA_COMPANIAS
(COD_COMPANIA)
LOGGING
TABLESPACE PA_IDX
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


CREATE PUBLIC SYNONYM PA_COMPANIAS FOR PA.PA_COMPANIAS;


ALTER TABLE PA.PA_COMPANIAS ADD (
  CONSTRAINT PK_PA_COMPANIAS
 PRIMARY KEY
 (COD_COMPANIA)
    USING INDEX 
    TABLESPACE PA_IDX
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

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON PA.PA_COMPANIAS TO PUBLIC;

--

CREATE TABLE PA.PA_SISTEMAS
(
  COD_COMPANIA  VARCHAR2(4 BYTE)                 NOT NULL,
  COD_SISTEMA   VARCHAR2(4 BYTE)                 NOT NULL,
  DESCRIPCION   VARCHAR2(400 BYTE)
)
TABLESPACE PA_DAT
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


CREATE UNIQUE INDEX PA.PK_PA_SISTEMAS ON PA.PA_SISTEMAS
(COD_COMPANIA, COD_SISTEMA)
LOGGING
TABLESPACE PA_IDX
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


CREATE PUBLIC SYNONYM PA_SISTEMAS FOR PA.PA_SISTEMAS;


ALTER TABLE PA.PA_SISTEMAS ADD (
  CONSTRAINT PK_PA_SISTEMAS
 PRIMARY KEY
 (COD_COMPANIA, COD_SISTEMA)
    USING INDEX 
    TABLESPACE PA_IDX
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
               
ALTER TABLE PA.PA_SISTEMAS
 ADD CONSTRAINT FK_PA_COMPANIA_SISTEMA 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);               

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON PA.PA_SISTEMAS TO PUBLIC;

--

CREATE TABLE PA.PA_FORMAS
(
  COD_COMPANIA  VARCHAR2(4 BYTE)                 NOT NULL,
  COD_SISTEMA   VARCHAR2(4 BYTE)                 NOT NULL,
  COD_FORMA     VARCHAR2(20 BYTE)                NOT NULL,
  DESCRIPCION   VARCHAR2(400 BYTE)
)
TABLESPACE PA_DAT
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


CREATE UNIQUE INDEX PA.PK_PA_FORMAS ON PA.PA_FORMAS
(COD_COMPANIA, COD_SISTEMA, COD_FORMA)
LOGGING
TABLESPACE PA_IDX
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


CREATE PUBLIC SYNONYM PA_FORMAS FOR PA.PA_FORMAS;


ALTER TABLE PA.PA_FORMAS ADD (
  CONSTRAINT PK_PA_FORMAS
 PRIMARY KEY
 (COD_COMPANIA, COD_SISTEMA, COD_FORMA)
    USING INDEX 
    TABLESPACE PA_IDX
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
               
ALTER TABLE PA.PA_FORMAS
 ADD CONSTRAINT FK_PA_SISTEMAS_FORMAS 
 FOREIGN KEY (COD_COMPANIA, COD_SISTEMA) 
 REFERENCES PA.PA_SISTEMAS (COD_COMPANIA, COD_SISTEMA);                

GRANT DELETE, INSERT, SELECT, UPDATE ON PA.PA_FORMAS TO PUBLIC;

--

CREATE TABLE PA.PA_REPORTES
(
  COD_COMPANIA       VARCHAR2(4 BYTE)           NOT NULL,
  COD_SISTEMA        VARCHAR2(4 BYTE)           NOT NULL,
  COD_REPORTE        VARCHAR2(20 BYTE)          NOT NULL,
  COD_FORMA_LLAMADO  VARCHAR2(20 BYTE),
  DESCRIPCION        VARCHAR2(400 BYTE)
)
TABLESPACE PA_DAT
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


CREATE UNIQUE INDEX PA.PK_PA_REPORTES ON PA.PA_REPORTES
(COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO)
LOGGING
TABLESPACE PA_IDX
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


CREATE PUBLIC SYNONYM PA_REPORTES FOR PA.PA_REPORTES;


ALTER TABLE PA.PA_REPORTES ADD (
  CONSTRAINT PK_PA_REPORTES
 PRIMARY KEY
 (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO)
    USING INDEX 
    TABLESPACE PA_IDX
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

ALTER TABLE PA.PA_REPORTES ADD (
  CONSTRAINT FK_PA_SISTEMAS_REPORTES 
 FOREIGN KEY (COD_COMPANIA, COD_SISTEMA) 
 REFERENCES PA.PA_SISTEMAS (COD_COMPANIA,COD_SISTEMA));

GRANT DELETE, INSERT, SELECT, UPDATE ON PA.PA_REPORTES TO PUBLIC;

--
--
--
CREATE OR REPLACE FUNCTION PA.INSTR_MAX(pCadena   IN VARCHAR2,
                                         pCaracter IN VARCHAR2
                                        ) RETURN NUMBER IS  
   --
   --  Se encarga de buscar el caracter indicado y su posición mayor
   --  dentro de la cadena indicada.
   --
   vCadena       Varchar2(32767);
   vMayorPos     Number;
   vMayorPosAnt  Number;
   vLongitud     Number;
   vCaracter     Varchar2(1);
   --
BEGIN
   --
   vCadena := Ltrim(Rtrim(pCadena, pCaracter), pCaracter);
   --
   vLongitud := Length(pCaracter);
   --
   If vLongitud > 0 Then
      --
      If vLongitud = 1 Then
         --
         If pCaracter = '@' Then
            vCaracter := '%';
         Else
            vCaracter := '@'; 
         End If;
         --
      Else
         --
         For y In 1..vLongitud Loop
            vCaracter := vCaracter||'@';
         End Loop;
         --
      End If;
      --
   Else
      --
      Return 0;
      --
   End If;
   --  
   vLongitud := Length(vCadena);
   --
   For x In 1..vLongitud Loop
      --
      vMayorPos := Instr(vCadena, pCaracter); -- Trae el primer carácter encontrado
      --
      vCadena   := Replace(vCadena, (Substr(vCadena, 0, vMayorPos)), (Replace(Substr(vCadena, 0, vMayorPos), pCaracter, vCaracter)));
      --           
      If vMayorPos < vMayorPosAnt Then
         vMayorPos := vMayorPosAnt;
         Exit;
      End If;
      --
      vMayorPosAnt := vMayorPos;
      --
   End Loop;
   --
   Return vMayorPos;
   --
END;

GRANT EXECUTE ON PA.INSTR_MAX TO PUBLIC;

CREATE PUBLIC SYNONYM INSTR_MAX FOR PA.INSTR_MAX;

--
--
--
CREATE OR REPLACE FUNCTION PA.OBT_NOMCOMPANIA(pCodCompania IN VARCHAR2,
                                              pEstadoEj    OUT BOOLEAN,
                                              pError       OUT VARCHAR2
                                             ) RETURN VARCHAR2 IS  
   --
   -- Retorna el nombre de la compañía indicada
   --
   vNomCompania  VARCHAR2(400);
   --
BEGIN
   -- 
   Select Descripcion
     into vNomCompania
     from Pa_Companias
    where Cod_Compania = pCodCompania;
   --
   pEstadoEj := TRUE;
   --
   Return vNomCompania;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al consultar el nombre de la compañía '||pCodCompania||' - '||Sqlerrm;
       Return NULL;
END;

GRANT EXECUTE ON PA.OBT_NOMCOMPANIA TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_NOMCOMPANIA FOR PA.OBT_NOMCOMPANIA;

--
CREATE TABLE PA.PA_PARAM_EMPRESA
(
  COD_COMPANIA      VARCHAR2(4 BYTE)            NOT NULL,      
  COD_PARAMETRO     VARCHAR2(32 BYTE)           NOT NULL,
  VALOR_PARAMETRO   VARCHAR2(1000 BYTE)         NOT NULL,
  DESCRIPCION       VARCHAR2(150 BYTE)          NOT NULL,
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_MOD          VARCHAR2(30 BYTE),
  FECHA_MOD         DATE
)
TABLESPACE PA_DAT
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

CREATE UNIQUE INDEX PA.PA_PARAM_EMPRESA ON PA.PA_PARAM_EMPRESA
(COD_COMPANIA, COD_PARAMETRO)
LOGGING
TABLESPACE PA_IDX
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

CREATE PUBLIC SYNONYM PA_PARAM_EMPRESA FOR PA.PA_PARAM_EMPRESA;

ALTER TABLE PA.PA_PARAM_EMPRESA ADD (
  CONSTRAINT PK_PA_PARAM_EMPRESA
 PRIMARY KEY
 (COD_COMPANIA, COD_PARAMETRO)
    USING INDEX 
    TABLESPACE PA_IDX
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
               
ALTER TABLE PA.PA_PARAM_EMPRESA
 ADD CONSTRAINT FK_PA_PARAM_EMPRESA 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);               

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON PA.PA_PARAM_EMPRESA TO PUBLIC;

--
--
CREATE OR REPLACE TRIGGER PA.TRG_PA_PARAM_EMPRESA_AUDIT
   BEFORE INSERT OR UPDATE ON 
   PA.PA_PARAM_EMPRESA 
 REFERENCING NEW AS New OLD AS Old
 FOR EACH ROW
BEGIN
  --
  If Updating Then
     :New.User_Mod  := User; 
     :New.Fecha_Mod := Trunc(Sysdate);
  Elsif Inserting Then
     :New.User_Reg  := User; 
     :New.Fecha_Reg := Trunc(Sysdate);
  End If;
  --
END;
/

--
CREATE OR REPLACE FUNCTION PA.OBT_PARAM_EMPRESA(pCodCompania IN VARCHAR2,
                                                pCodParam    IN VARCHAR2,
                                                pEstadoEj    OUT BOOLEAN,
                                                pError       OUT VARCHAR2
                                               ) RETURN VARCHAR2 IS
   --
   -- Retorna el parámetro indicado para la compañía descrita
   --
   vValorParametro  VARCHAR2(1000);
   --
BEGIN
   -- 
   Select Valor_Parametro
     into vValorParametro
     from Pa_Param_Empresa
    where Cod_Compania  = pCodCompania
      and Cod_Parametro = pCodParam;
   --
   pEstadoEj := TRUE;
   --
   Return vValorParametro;
   --
EXCEPTION
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al consultar el parámetro '||pCodParam||' para la compañía '||pCodCompania||' - '||Sqlerrm;
       Return NULL;
END;

GRANT EXECUTE ON PA.OBT_PARAM_EMPRESA TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_PARAM_EMPRESA FOR PA.OBT_PARAM_EMPRESA;

--

CREATE TABLE PA.PA_MONEDAS
(
  COD_COMPANIA      VARCHAR2(4 BYTE)            NOT NULL,
  COD_MONEDA        VARCHAR2(4 BYTE)            NOT NULL,
  DES_MONEDA        VARCHAR2(80 BYTE),
  ABREV_MONEDA      VARCHAR2(4 BYTE),
  MONEDA_DEFAULT    VARCHAR2(1 BYTE)            DEFAULT 'N',      
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_MOD          VARCHAR2(30 BYTE),
  FECHA_MOD         DATE
)
TABLESPACE PA_DAT
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

CREATE UNIQUE INDEX PA.PA_MONEDAS ON PA.PA_MONEDAS
(COD_COMPANIA, COD_MONEDA)
LOGGING
TABLESPACE PA_IDX
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

CREATE PUBLIC SYNONYM PA_MONEDAS FOR PA.PA_MONEDAS;

ALTER TABLE PA.PA_MONEDAS ADD (
  CONSTRAINT PK_PA_MONEDAS
 PRIMARY KEY
 (COD_COMPANIA, COD_MONEDA)
    USING INDEX 
    TABLESPACE PA_IDX
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
               
ALTER TABLE PA.PA_MONEDAS
 ADD CONSTRAINT FK_PA_MONEDAS 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);               

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON PA.PA_MONEDAS TO PUBLIC;

--
CREATE OR REPLACE PROCEDURE PA.OBT_DAT_MONEDA(pCodCompania IN VARCHAR2,
                                              pCodMoneda   IN VARCHAR2,
                                              pDefault     IN VARCHAR2,
                                              pDatMoneda   OUT PA_MONEDAS%ROWTYPE,
                                              pEstadoEj    OUT BOOLEAN,
                                              pError       OUT VARCHAR2
                                             ) IS
   --
   -- Retorna datos referentes a la moneda
   --
BEGIN
   --
   Select *
     into pDatMoneda
     from Pa_Monedas
    where Cod_Compania   = pCodCompania
      and Cod_Moneda     = Nvl(pCodMoneda, Cod_Moneda)
      and Moneda_Default = Nvl(pDefault, Moneda_Default);
   --
   pEstadoEj := TRUE;
   --
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       pEstadoEj := FALSE;
       pError    := 'Error al consultar la moneda '||pCodMoneda;
   WHEN TOO_MANY_ROWS THEN
       pEstadoEj := FALSE;
       pError    := 'Existen varias monedas con los parámetros indicados. Moneda: '||
                    Nvl(pCodMoneda, 'Valor nulo')||
                    ' Default: '||
                    Nvl(pDefault, 'Valor nulo');
   WHEN OTHERS THEN
       pEstadoEj := FALSE;
       pError    := 'Error al consultar datos referentes a la moneda '||Sqlerrm;
END;

GRANT EXECUTE ON PA.OBT_DAT_MONEDA TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_DAT_MONEDA FOR PA.OBT_DAT_MONEDA;

--
CREATE OR REPLACE FUNCTION PA.OBT_NOMDIA(pFecha  IN DATE,
                                         pIndObt IN VARCHAR2, -- D=Día; M=Mes
                                         pIdioma IN VARCHAR2 -- ESPA=Español; ENGL=Inglés 
                                        ) RETURN VARCHAR2 IS  
   --
   -- Retorna el nombre del día, mes o  año 
   -- en el idioma indicado
   --
   vNomInd  VARCHAR2(100);
   --
BEGIN
   -- 
   Select To_Char(pFecha, (Decode(pIndObt, 'D', 'DAY', 'M', 'MONTH')), 
                  'NLS_LANGUAGE='||(Decode(pIdioma, 'ESPA', 'SPANISH', 'ENGL', 'ENGLISH')))
     into vNomInd
     from Dual;
   --
   Return vNomInd;
   --
EXCEPTION
   WHEN OTHERS THEN
       Return Null;
END;

GRANT EXECUTE ON PA.OBT_NOMDIA TO PUBLIC;

CREATE PUBLIC SYNONYM OBT_NOMDIA FOR PA.OBT_NOMDIA;

--
--
CREATE OR REPLACE TRIGGER PA.TRG_PA_MONEDAS_AUDIT
   BEFORE INSERT OR UPDATE ON 
   PA.PA_MONEDAS 
 REFERENCING NEW AS New OLD AS Old
 FOR EACH ROW
BEGIN
  --
  If Updating Then
     :New.User_Mod  := User; 
     :New.Fecha_Mod := Trunc(Sysdate);
  Elsif Inserting Then
     :New.User_Reg  := User; 
     :New.Fecha_Reg := Trunc(Sysdate);
  End If;
  --
  If :New.Abrev_Moneda Is Null Then
     :New.Abrev_Moneda := :New.Cod_Moneda;
  End If;
  --
END;
/

--
-- Datos

Insert into PA.PA_COMPANIAS
   (COD_COMPANIA, DESCRIPCION)
 Values
   ('01', 'hAnkoo Dev');
COMMIT;
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'PA', 'Parámetros');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'SE', 'Seguridad');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'NF', 'Notificaciones');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'VT', 'Ventas');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'RU', 'Rutas');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'PG', 'Pagos');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'IV', 'Inventarios');
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'CL', 'Clientes');
COMMIT;
Insert into PA.PA_SISTEMAS
   (COD_COMPANIA, COD_SISTEMA, DESCRIPCION)
 Values
   ('01', 'CO', 'Cobros');
COMMIT;

--

Insert into PA.PA_PARAM_EMPRESA
   (COD_COMPANIA, COD_PARAMETRO, VALOR_PARAMETRO, DESCRIPCION, USER_REG, FECHA_REG)
 Values
   ('01', 'P_MULTIMONEDA', 'S', 'La compañía trabaja con varias monedas', 
    'PA', SYSDATE);
COMMIT;

Insert into PA.PA_PARAM_EMPRESA
   (COD_COMPANIA, COD_PARAMETRO, VALOR_PARAMETRO, DESCRIPCION, USER_REG, FECHA_REG)
 Values
   ('01', 'P_VALIDAPAGOFEC', 'S', 'Indicador para válidar un pago realizado para la fecha indicada', 
    'PG', SYSDATE);
COMMIT;

Insert into PA.PA_PARAM_EMPRESA
   (COD_COMPANIA, COD_PARAMETRO, VALOR_PARAMETRO, DESCRIPCION, USER_REG, FECHA_REG)
 Values
   ('01', 'P_METODOVALINV', 'PROMP', 'Indicador de método de valuación utilizado (PROMP = Promedio Ponderado; NA = No Aplica Método)', 
    'IV', SYSDATE);
COMMIT;

Insert into PA.PA_PARAM_EMPRESA
   (COD_COMPANIA, COD_PARAMETRO, VALOR_PARAMETRO, DESCRIPCION, USER_REG, FECHA_REG)
 Values
   ('01', 'P_LIMPIANOTIFICA', '30', 'Indicador de cantidad de DÍAS para limpiar la bitácora de notificaciones', 
    'NF', SYSDATE);
COMMIT;

Insert into PA.PA_PARAM_EMPRESA
   (COD_COMPANIA, COD_PARAMETRO, VALOR_PARAMETRO, DESCRIPCION, USER_REG, FECHA_REG)
 Values
   ('01', 'P_CLSINPAGO', '30', 'Indicador de cantidad de DÍAS de clientes sin realizar un pago', 
    'PG', SYSDATE);
COMMIT;

Insert into PA.PA_PARAM_EMPRESA
   (COD_COMPANIA, COD_PARAMETRO, VALOR_PARAMETRO, DESCRIPCION, USER_REG, FECHA_REG)
 Values
   ('01', 'P_DIASPAGOMINIMO', '60', 'Indicador de cantidad de DÍAS para permitir pagos con antiguedad máxima', 
    'PG', SYSDATE);
COMMIT;

--

Insert into PA.PA_MONEDAS
   (COD_COMPANIA, COD_MONEDA, DES_MONEDA, ABREV_MONEDA, MONEDA_DEFAULT, USER_REG, FECHA_REG)
 Values
   ('01', 'USD', 'Dolares', '$', 
    'N', 'PA', TO_DATE('04/11/2012 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into PA.PA_MONEDAS
   (COD_COMPANIA, COD_MONEDA, DES_MONEDA, ABREV_MONEDA, MONEDA_DEFAULT, USER_REG, FECHA_REG)
 Values
   ('01', 'COL', 'Colones', '¢', 
    'S', 'PA', TO_DATE('04/11/2012 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
Insert into PA.PA_MONEDAS
   (COD_COMPANIA, COD_MONEDA, DES_MONEDA, ABREV_MONEDA, MONEDA_DEFAULT, USER_REG, FECHA_REG)
 Values
   ('01', 'EUR', 'Euros', 'E', 
    'N', 'PA', TO_DATE('04/11/2012 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
COMMIT;

--

Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'SE', 'SE_GENDMP', 'Generación de Respaldo');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'SE', 'SE_USUARIOS', 'Gestión de Usuarios');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'CL', 'CL_CLIENTES', 'Registro de Clientes');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'RU', 'RU_ENCARGADOS', 'Encargados de Rutas');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'PG', 'PG_PAGOS', 'Registro de Pagos');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'RU', 'RU_RUTAS', 'Registro de Rutas');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'IV', 'IV_PRODUCTOS', 'Registro de Productos');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'IV', 'IV_TRANSACCIONES', 'Registro de Tipo Transacciones');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'IV', 'IV_MOV_INV', 'Movimientos de Inventario');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'NF', 'NF_NOTIFICACIONES', 'Notificaciones');
Insert into PA.PA_FORMAS
   (COD_COMPANIA, COD_SISTEMA, COD_FORMA, DESCRIPCION)
 Values
   ('01', 'VT', 'VT_VENTAS', 'Registro de Ventas');
COMMIT;

--

Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'CL', 'CL_REPCLIENTES', 'CL_REPCLIENTES', 'Reporte General de Clientes');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'PG', 'PG_REPPAGOS', 'PG_REPPAGOS', 'Reporte de Pagos');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'PG', 'PG_REPNOPG', 'PG_REPNOPG', 'Reporte de Clientes sin Pagar');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'CL', 'CL_REPDIA', 'CL_REPDIA', 'Reporte de Clientes Día de Visita');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'IV', 'IV_REPPRODUC', 'IV_REPPRODUC', 'Reporte de Productos');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'IV', 'IV_REPINV', 'IV_REPINV', 'Reporte de Inventario Físico');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'IV', 'IV_REPTRANSAC', 'IV_REPTRANSAC', 'Reporte de Transacciones');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'VT', 'VT_REPSVT', 'VT_REPSVT', 'Reporte de Clientes sin Ventas');
Insert into PA.PA_REPORTES
   (COD_COMPANIA, COD_SISTEMA, COD_REPORTE, COD_FORMA_LLAMADO, DESCRIPCION)
 Values
   ('01', 'VT', 'VT_REPVENTAS', 'VT_REPVENTAS', 'Reporte de Ventas');
COMMIT;

--
