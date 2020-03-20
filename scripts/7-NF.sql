--
-- You need to replace ORACLE_HOME for your own Path.
CREATE TABLESPACE NF_DAT DATAFILE 
  'ORACLE_HOME\NF_DAT.DBF' SIZE 2M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--

CREATE TABLESPACE NF_IDX DATAFILE 
  'ORACLE_HOME\NF_IDX.DBF' SIZE 1M AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT MANUAL
FLASHBACK ON;

--
-- You should change the user's password
CREATE USER NF
  IDENTIFIED BY NF 
  DEFAULT TABLESPACE NF_DAT
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;
  GRANT RESOURCE TO NF;
  GRANT CONNECT TO NF;
  ALTER USER NF DEFAULT ROLE ALL;
  GRANT ALTER USER TO NF;
  GRANT CREATE SESSION TO NF;
  GRANT CREATE JOB TO NF;
  GRANT CREATE PROCEDURE TO NF;
  GRANT UNLIMITED TABLESPACE TO NF;
  GRANT CREATE ANY INDEX TO NF;
  GRANT CREATE VIEW TO NF;
  GRANT CREATE PUBLIC SYNONYM TO NF;
  ALTER USER NF QUOTA UNLIMITED ON NF_DAT;
  ALTER USER NF QUOTA UNLIMITED ON NF_IDX;

--
-- Tablas
CREATE TABLE NF.NF_PROC_NOTIFICACION
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  COD_PROCESO       VARCHAR2(30 BYTE)                NOT NULL,
  COD_SISTEMA       VARCHAR2(4 BYTE)                 NOT NULL,
  DES_PROCESO       VARCHAR2(100 BYTE),
  COD_ESTADO        VARCHAR2(4 BYTE)                 DEFAULT 'ACT',
  OBSERVACIONES     VARCHAR2(200 BYTE),
  SQL_NF            VARCHAR2(4000 BYTE),
  USER_REG          VARCHAR2(30 BYTE),
  FECHA_REG         DATE,
  USER_MOD          VARCHAR2(30 BYTE),
  FECHA_MOD         DATE
)
TABLESPACE NF_DAT
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


CREATE UNIQUE INDEX NF.PK_PROC_NOTIFICACION ON NF.NF_PROC_NOTIFICACION
(COD_COMPANIA, COD_PROCESO)
LOGGING
TABLESPACE NF_IDX
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


CREATE PUBLIC SYNONYM NF_PROC_NOTIFICACION FOR NF.NF_PROC_NOTIFICACION;


ALTER TABLE NF.NF_PROC_NOTIFICACION ADD (
  CONSTRAINT PK_PROC_NOTIFICACION
 PRIMARY KEY
 (COD_COMPANIA, COD_PROCESO)
    USING INDEX 
    TABLESPACE NF_IDX
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

ALTER TABLE NF.NF_PROC_NOTIFICACION
 ADD CONSTRAINT FK_PA_SISTEMAS_PROC_NF
 FOREIGN KEY (COD_COMPANIA, COD_SISTEMA) 
 REFERENCES PA.PA_SISTEMAS (COD_COMPANIA, COD_SISTEMA);

ALTER TABLE NF.NF_PROC_NOTIFICACION
 ADD CONSTRAINT FK_PA_COMPANIA_PROC_NF 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON NF.NF_PROC_NOTIFICACION TO PUBLIC;

--

CREATE TABLE NF.NF_BIT_NOTIFICACION
(
  COD_COMPANIA       VARCHAR2(4 BYTE)                 NOT NULL,
  COD_PROCESO        VARCHAR2(30 BYTE)                NOT NULL,
  NUM_NOTIFICACION   NUMBER(10)                       NOT NULL,
  DES_NOTIFICACION   VARCHAR2(4000 BYTE)              NOT NULL,
  COD_ESTADO         VARCHAR2(2 BYTE)                 DEFAULT 'SL',
  FECHA_NOTIFICACION DATE,
  IND_IMPORTANTE     VARCHAR2(1 BYTE)                 DEFAULT 'N',
  USER_MOD           VARCHAR2(30 BYTE),
  FECHA_MOD          DATE
)
TABLESPACE NF_DAT
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


CREATE UNIQUE INDEX NF.PK_BIT_NOTIFICACION ON NF.NF_BIT_NOTIFICACION
(COD_COMPANIA, COD_PROCESO, NUM_NOTIFICACION)
LOGGING
TABLESPACE NF_IDX
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


CREATE PUBLIC SYNONYM NF_BIT_NOTIFICACION FOR NF.NF_BIT_NOTIFICACION;


ALTER TABLE NF.NF_BIT_NOTIFICACION ADD (
  CONSTRAINT PK_BIT_NOTIFICACION
 PRIMARY KEY
 (COD_COMPANIA, COD_PROCESO, NUM_NOTIFICACION)
    USING INDEX 
    TABLESPACE NF_IDX
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

ALTER TABLE NF.NF_BIT_NOTIFICACION
 ADD CONSTRAINT FK_PROC_NF_BIT_NF
 FOREIGN KEY (COD_COMPANIA, COD_PROCESO) 
 REFERENCES NF.NF_PROC_NOTIFICACION (COD_COMPANIA, COD_PROCESO);

ALTER TABLE NF.NF_BIT_NOTIFICACION
 ADD CONSTRAINT FK_PA_COMPANIA_BIT_NF 
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON NF.NF_BIT_NOTIFICACION TO PUBLIC;

--

CREATE TABLE NF.NF_BIT_EJECUCION_NF
(
  COD_COMPANIA      VARCHAR2(4 BYTE)                 NOT NULL,
  COD_PROCESO       VARCHAR2(30 BYTE)                DEFAULT 'NOTIFICACIONES',
  COD_ESTADO        VARCHAR2(10 BYTE)                DEFAULT 'EXITOSO',
  DETALLE_EJECUCION VARCHAR2(4000 BYTE),
  USER_EJECUTO      VARCHAR2(30 BYTE),
  FEC_EJECUCION     DATE
)
TABLESPACE NF_DAT
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


CREATE INDEX NF.IDX_NF_BIT_EJECUCION ON NF.NF_BIT_EJECUCION_NF
(COD_COMPANIA, COD_PROCESO, FEC_EJECUCION)
LOGGING
TABLESPACE NF_IDX
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

CREATE PUBLIC SYNONYM NF_BIT_EJECUCION_NF FOR NF.NF_BIT_EJECUCION_NF;

ALTER TABLE NF.NF_BIT_EJECUCION_NF
 ADD CONSTRAINT FK_PA_COMPANIA_BIT_EJEC_NF
 FOREIGN KEY (COD_COMPANIA) 
 REFERENCES PA.PA_COMPANIAS (COD_COMPANIA);

GRANT DELETE, INSERT, SELECT, UPDATE, REFERENCES ON NF.NF_BIT_EJECUCION_NF TO PUBLIC;

--

CREATE SEQUENCE NF.SQ_NUMNOTIFICACION
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9999999999
NOCACHE 
NOCYCLE 
NOORDER;

GRANT SELECT ON NF.SQ_NUMNOTIFICACION TO PUBLIC;

CREATE PUBLIC SYNONYM SQ_NUMNOTIFICACION FOR NF.SQ_NUMNOTIFICACION;

--

CREATE OR REPLACE PROCEDURE NF.BITACORA_EJECUCION_NF(pCodCompania IN VARCHAR2,
                                                     pCodProceso  IN VARCHAR2, -- NOTIFICACIONES; BORRA_BIT; BORRA_NF
                                                     pEstadoEj    IN VARCHAR2, -- EXITOSO; ERROR
                                                     pDetalleEj   IN VARCHAR2
                                                    ) IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   --
   -- Registra la bitácora de ejecución de notificaciones
   --
BEGIN
   --
   Insert Into Nf_Bit_Ejecucion_Nf(Cod_Compania, Cod_Proceso, Cod_Estado,
                                   Detalle_Ejecucion, User_Ejecuto, Fec_Ejecucion
                                  )
          Values                  (pCodCompania, pCodProceso, pEstadoEj,
                                   pDetalleEj, User, Sysdate
                                  );
   --
   Commit;
   --
EXCEPTION
   WHEN OTHERS THEN
       RollBack;
END;

GRANT EXECUTE ON NF.BITACORA_EJECUCION_NF TO PUBLIC;

CREATE PUBLIC SYNONYM BITACORA_EJECUCION_NF FOR NF.BITACORA_EJECUCION_NF;

--

CREATE OR REPLACE PROCEDURE NF.GENERA_NOTIFICACIONES(pCodCompania IN VARCHAR2
                                                    ) IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   --
   -- Genera las notificaciones parámetrizadas
   --
   Cursor cSqlNf Is 
     Select Cod_Compania, Cod_Proceso, Cod_Sistema, 
            Des_Proceso, Sql_Nf
       from Nf_Proc_Notificacion
      where Cod_Compania = pCodCompania
        and Cod_Estado   = 'ACT' -- Activo
     Order by Cod_Sistema, Cod_Proceso; 
   --
   Type CurTyp Is Ref Cursor;
   cCursor     CurTyp;
   --
   vFila                Varchar2(4000);
   vNumNotificacion     Number(10);
   vCantNotificaciones  Number(10) := 0;
   --
BEGIN
   --
   For x In cSqlNf Loop
     --
     Open cCursor For x.Sql_Nf Using x.Cod_Compania;
       Loop
        Fetch cCursor Into vFila;
        Exit When cCursor%NotFound;
          --
          vCantNotificaciones := vCantNotificaciones + 1;
          --
          Select SQ_NumNotificacion.NextVal
            into vNumNotificacion
            from Dual;
          --
          Insert Into Nf_Bit_Notificacion(Cod_Compania, Cod_Proceso, Num_Notificacion,
                                          Des_Notificacion, Cod_Estado, Fecha_Notificacion, 
                                          Ind_Importante
                                         )
                 Values                  (x.Cod_Compania, x.Cod_Proceso, vNumNotificacion,
                                          vFila, 'SL', Sysdate,
                                          'N'
                                         );
          -- 
       End Loop;
     Close cCursor;
     --
   End Loop;
   --
   Commit;
   --
   If vCantNotificaciones > 0 Then
      --
      Bitacora_Ejecucion_Nf(pCodCompania,
                            'NOTIFICACIONES',
                            'EXITOSO',
                            'Se generarón exitosamente '||To_Char(vCantNotificaciones, 'FM9,999,999,990')||
                            ' Notificacion(es)' 
                           );
      --
   End If;
   --
EXCEPTION
   WHEN OTHERS THEN
       --
       RollBack;
       --
       Bitacora_Ejecucion_Nf(pCodCompania,
                             'NOTIFICACIONES',
                             'ERROR',
                             Sqlerrm
                            );
       --
END;

GRANT EXECUTE ON NF.GENERA_NOTIFICACIONES TO PUBLIC;

CREATE PUBLIC SYNONYM GENERA_NOTIFICACIONES FOR NF.GENERA_NOTIFICACIONES;

--

CREATE OR REPLACE PROCEDURE NF.BORRA_BIT_NF(pCodCompania IN VARCHAR2
                                           ) IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   --
   -- Registra la bitácora de ejecución de notificaciones
   --
   vEstadoEj   BOOLEAN;
   vMsjError   Varchar2(400);
   vValor      Number(10);
   vRegNf      Number(10) := 0;
   vRegEj      Number(10) := 0;
   --
BEGIN
   --
   -- Obtiene parámetro de tiempo de limpieza
   vValor := Obt_Param_Empresa(pCodCompania,
                               'P_LIMPIANOTIFICA',
                               vEstadoEj,
                               vMsjError
                              );
   --
   If Not vEstadoEj Then
      --
      Bitacora_Ejecucion_Nf(pCodCompania,
                            'BORRA_BIT',
                            'ERROR',
                            vMsjError
                           );
      --
      Return;
      --
   End If;
   --
   -- Elimina las notificaciones
   Delete Nf_Bit_Notificacion
    where Cod_Compania               = pCodCompania
      and Trunc(Fecha_Notificacion) <= (Trunc(Sysdate) - vValor);
   --
   vRegNf := Sql%RowCount; 
   --
   -- Elimina datos de la bitácora de ejecuciones
   Delete Nf_Bit_Ejecucion_Nf
    where Cod_Compania          = pCodCompania
      and Trunc(Fec_Ejecucion) <= (Trunc(Sysdate) - vValor);
   --
   vRegEj := Sql%RowCount;
   --
   Commit;
   --
   If (vRegNf + vRegEj) > 0 Then
      --
      Bitacora_Ejecucion_Nf(pCodCompania,
                            'BORRA_BIT',
                            'EXITOSO',
                            'Se han eliminado '||vRegNf||' notificaciones y '||vRegEj||
                            ' registros de bitácora de ejecución, menores o iguales a la fecha '||
                            To_Char((Trunc(Sysdate) - vValor), 'DD/MM/RRRR')
                           );
      --
   End If;
   --
EXCEPTION
   WHEN OTHERS THEN
       --
       Bitacora_Ejecucion_Nf(pCodCompania,
                             'BORRA_BIT',
                             'ERROR',
                             Sqlerrm
                            );
       --
END;

GRANT EXECUTE ON NF.BORRA_BIT_NF TO PUBLIC;

CREATE PUBLIC SYNONYM BORRA_BIT_NF FOR NF.BORRA_BIT_NF;

CREATE OR REPLACE PACKAGE NF.NF_UTILITARIOS AS
   --
   -- Constantes para el manejo del estado de los JOBS
   kJOB_INEXISTENTE   CONSTANT VARCHAR2(50) := 'INEXISTENTE'; -- El job no existe
   kJOB_EJECUTANDO    CONSTANT VARCHAR2(50) := 'RUNNING'; -- The job is currently running.
   kJOB_EXITOSO       CONSTANT VARCHAR2(50) := 'SUCCEEDED'; -- The job was scheduled to run once and completed successfully.
   kJOB_COMPLETADO    CONSTANT VARCHAR2(50) := 'COMPLETED'; -- The job has completed, and is not scheduled to run again.
   kJOB_FALLIDO       CONSTANT VARCHAR2(50) := 'FAILED'; -- The job was scheduled to run once and failed.
   kJOB_DESHABILITADO CONSTANT VARCHAR2(50) := 'DISABLED'; -- The job is disabled.
   kJOB_PROGRAMADO    CONSTANT VARCHAR2(50) := 'SCHEDULED'; -- The job is scheduled to be executed.
   kJOB_DETENIDO      CONSTANT VARCHAR2(50) := 'STOPPED'; -- The job was scheduled to run once and was stopped while it was running.
   --
   -- Rutina encargada de crear un job, en caso que este exista se valida el estado del
   -- mismo, en caso que no se encuentre en ejecución se elimina y se vuelve a crear
   -- con nuevos valores.
   PROCEDURE CreaJob
   (
      pNombreJob       IN VARCHAR2, -- Nombre del job
      pDescripcionJob  IN VARCHAR2, -- Descripción o comentarios del job
      pFrecuenciaJob   IN VARCHAR2, -- Frecuencia del job (MINUTELY/HOURLY/...)
      pEjecucionActiva IN BOOLEAN, -- Ejecución activa del Job
      pIntervaloEjec   IN NUMBER, -- Tiempo intervalo para cada ejecución del job (Según frecuencia)
      pHorasEjec       IN VARCHAR2, -- Cadena con horas de ejecución (Ej: 12, 13, 14)
      pAccionJob       IN VARCHAR2, -- Proceso o rutina a ejecutar,
      pAutoEliminacion IN BOOLEAN, -- Ejecutar y luego eliminar el job
      pEstadoEj        OUT BOOLEAN, -- Estado de la ejecución del proceso
      pError             OUT VARCHAR2 -- Mensaje de error generado
   );
   --
   -- Rutina encargada de detener un job
   PROCEDURE DetieneEjecJob
   (
       pNombreJob IN VARCHAR2, -- Nombre del JOB
       pEstadoEj     OUT BOOLEAN, -- Estado de la ejecución del proceso
       pError          OUT VARCHAR2 -- Mensaje de error generado
   );
   --
   -- Rutina encargada de obtener el estatus de un job
   FUNCTION ObtieneEstadoJob
   (
       pNombreJob IN VARCHAR2, -- Nombre del JOB
       pEstadoEj     OUT BOOLEAN, -- Estado de la ejecución del proceso
       pError          OUT VARCHAR2 -- Mensaje de error generado
   ) RETURN VARCHAR2;
   --
END NF_UTILITARIOS;

CREATE OR REPLACE PACKAGE BODY NF.NF_UTILITARIOS AS
   --
   -- Rutina encargada de crear un job, en caso que este exista se valida el estado del
   -- mismo, en caso que no se encuentre en ejecución se elimina y se vuelve a crear
   -- con nuevos valores.
   PROCEDURE CreaJob
   (
      pNombreJob       IN VARCHAR2, -- Nombre del job
      pDescripcionJob  IN VARCHAR2, -- Descripción o comentarios del job
      pFrecuenciaJob   IN VARCHAR2, -- Frecuencia del job (MINUTELY/HOURLY/...)
      pEjecucionActiva IN BOOLEAN, -- Ejecución activa del Job
      pIntervaloEjec   IN NUMBER, -- Tiempo intervalo para cada ejecución del job (Según frecuencia)
      pHorasEjec       IN VARCHAR2, -- Cadena con horas de ejecución (Ej: 12, 13, 14)
      pAccionJob       IN VARCHAR2, -- Proceso o rutina a ejecutar,
      pAutoEliminacion IN BOOLEAN, -- Ejecutar y luego eliminar el job
      pEstadoEj        OUT BOOLEAN, -- Estado de la ejecución del proceso
      pError             OUT VARCHAR2 -- Mensaje de error generado
   ) IS
      --
      vEstadoJob      VARCHAR2(100);
      vRepeatInterval VARCHAR2(100) := NULL;
      vJobType        VARCHAR2(30) := 'PLSQL_BLOCK';
      vJobClass       VARCHAR2(100) := 'DEFAULT_JOB_CLASS';
      --
      vNumberArguments NUMBER := 0;
      --
   BEGIN
      --
      vEstadoJob := NF_UTILITARIOS.ObtieneEstadoJob(pNombreJob, pEstadoEj, pError);
      --
      If Not pEstadoEj Then
         Return;
      End If;
      --
      IF vEstadoJob = NF_UTILITARIOS.kJOB_EJECUTANDO Then
          --
          pEstadoEj := FALSE;
          pError := 'Error el job se encuentra en ejecución';
          Return;
          --
      Elsif vEstadoJob != NF_UTILITARIOS.kJOB_INEXISTENTE Then
          --
          NF_UTILITARIOS.DetieneEjecJob(pNombreJob, pEstadoEj, pError);
          --
          If Not pEstadoEj Then
             Return;
          End If;
          --
      End If;
      --
      If pFrecuenciaJob Is Not Null And pHorasEjec Is Not Null And 
         pIntervaloEjec Is Not Null Then
         --
         vRepeatInterval := 'FREQ=' || pFrecuenciaJob || '; BYHOUR=' || pHorasEjec || '; INTERVAL=' ||
                      To_Char(pIntervaloEjec);
         --
      End If;
      --
      Begin
          DBMS_SCHEDULER.Create_Job(pNombreJob, vJobType, pAccionJob, vNumberArguments, SYSTIMESTAMP, vRepeatInterval, NULL,
                                                            vJobClass, pEjecucionActiva, pAutoEliminacion, pDescripcionJob);
      Exception
          When Others Then
                  pEstadoEj := FALSE;
                  pError := 'Error al crear el job - '||Sqlerrm;
                  Return;
      End;
      --
      pEstadoEj := TRUE;
      --
   EXCEPTION
       WHEN OTHERS THEN
               pEstadoEj := FALSE;
               pError := 'Error al crear el job - '||Sqlerrm;
   END;
   --
   -- Rutina encargada de detener un job
   PROCEDURE DetieneEjecJob
   (
       pNombreJob IN VARCHAR2, -- Nombre del JOB
       pEstadoEj     OUT BOOLEAN, -- Estado de la ejecución del proceso
       pError          OUT VARCHAR2 -- Mensaje de error generado
   ) IS
      --
      PRAGMA AUTONOMOUS_TRANSACTION;
      --
      vForce BOOLEAN := TRUE;
      --
   BEGIN
      --
      DBMS_SCHEDULER.DROP_JOB(pNombreJob, vForce);
      --
      COMMIT;
      --
      pEstadoEj := TRUE;
      --
   EXCEPTION
       WHEN OTHERS THEN
                pEstadoEj := FALSE;
                pError := 'Error al detener o eliminar job - '||Sqlerrm;
   END;
   --
   -- Rutina encargada de obtener el estatus de un job
   FUNCTION ObtieneEstadoJob
   (
       pNombreJob IN VARCHAR2, -- Nombre del JOB
       pEstadoEj     OUT BOOLEAN, -- Estado de la ejecución del proceso
       pError          OUT VARCHAR2 -- Mensaje de error generado
   ) RETURN VARCHAR2 IS
      --
      CURSOR cEstadoJob(pcJobName IN VARCHAR2) IS
          SELECT STATE FROM USER_SCHEDULER_JOBS WHERE JOB_NAME = pcJobName;
      --
      vEstadoJob VARCHAR2(100);
      --
   BEGIN
      --
      OPEN cEstadoJob(pNombreJob);
      FETCH cEstadoJob
          INTO vEstadoJob;
      --
      IF cEstadoJob%NOTFOUND THEN
          vEstadoJob := NF_UTILITARIOS.kJOB_INEXISTENTE;
      END IF;
      --
      CLOSE cEstadoJob;
      --
      pEstadoEj := TRUE;
      --
      RETURN vEstadoJob;
      --
   EXCEPTION
       WHEN OTHERS THEN
                pEstadoEj := FALSE;
                pError := 'Error al obtener el estado del job - '||Sqlerrm;
                Return Null;
   END;
   --
END NF_UTILITARIOS;

GRANT EXECUTE ON NF.NF_UTILITARIOS TO PUBLIC;

CREATE PUBLIC SYNONYM NF_UTILITARIOS FOR NF.NF_UTILITARIOS;

--
Insert into NF.NF_PROC_NOTIFICACION
   (COD_COMPANIA, COD_PROCESO, COD_SISTEMA, DES_PROCESO, COD_ESTADO, SQL_NF)
 Values
   ('01', 'PG_CLSINPAGO', 'PG', 'Clientes sin Pago', 
    'ACT', 'Select ''El cliente ''||b.Cod_Cliente||'' - ''||Ltrim(Rtrim(b.Nombre_Cliente))||
       (Select '' visitado por la ruta ''||d.Cod_Ruta||'' (''||r.Des_Ruta||'') ''
          from Cl_Dias_Clientes d, Ru_Rutas r
         where d.Cod_Compania = b.Cod_Compania 
           and d.Cod_Cliente  = b.Cod_Cliente
           and d.Cod_Compania = r.Cod_Compania
           and d.Cod_Ruta     = r.Cod_Ruta)||
       Decode(Max(a.Fecha_Pago), NULL, '' no ha realizado pagos'', '' tiene como última fecha de pago ''||To_Char(Max(a.Fecha_Pago), ''DD/MM/RRRR''))
  from Pg_Maestro_Pagos a, Cl_Clientes b
 where a.Cod_Compania (+) = :pCompania
   and a.Cod_Estado   (+) = ''APL''
   and b.Cod_Estado   (+) = ''ACT''
   and (Select Nvl(Sum(c.Monto_Saldo), 0)
          from Co_Saldos_Clientes c
         where c.Cod_Compania     = b.Cod_Compania
           and c.Cod_Cliente      = b.Cod_Cliente
           and c.Cod_Estado       = ''REG'') > 0  
   and a.Cod_Compania (+) = b.Cod_Compania
   and a.Cod_Cliente  (+) = b.Cod_Cliente
having Max(Nvl(a.Fecha_Pago, (Select Nvl(Min(c.Fecha_Reg_Cobro), Trunc(Sysdate))
                                from Co_Saldos_Clientes c
                               where c.Cod_Compania     = b.Cod_Compania
                                 and c.Cod_Cliente      = b.Cod_Cliente
                                 and c.Cod_Estado       = ''REG''))) <= (Trunc(Sysdate) - Nvl((Select d.Valor_Parametro
                                                                                               from Pa_Param_Empresa d
                                                                                              where d.Cod_Compania  = ''01'' 
                                                                                                and d.Cod_Parametro = ''P_CLSINPAGO''), 30))
group by b.Cod_Compania, a.Cod_Ruta, a.Cod_Moneda, b.Cod_Cliente, b.Nombre_Cliente
order by b.Cod_Cliente, b.Nombre_Cliente, Max(a.Fecha_Pago)');

Insert into NF.NF_PROC_NOTIFICACION
   (COD_COMPANIA, COD_PROCESO, COD_SISTEMA, DES_PROCESO, COD_ESTADO, SQL_NF)
 Values
   ('01', 'IV_EXISTMIN', 'IV', 'Existencias Mínimas', 
    'ACT', 'Select ''El producto ''||a.Cod_Producto||'' - ''||b.Des_Producto||
       '' ha alcanzado las existencias mínimas, existencia actual: ''||
       To_Char(a.Total_Existencia, ''FM9,999,999,990'')
  from Iv_Exist_Cost_Productos a, Iv_Productos b
 where a.Cod_Compania     = :pCompania
   and a.Total_Existencia <= b.Cant_ExistMinima
   and b.Cod_Estado       = ''ACT''
   and b.Cant_ExistMinima is not null
   and a.Cod_Compania     = b.Cod_Compania
   and a.Cod_Producto     = b.Cod_Producto
Order by a.Cod_Producto, b.Des_Producto, a.Total_Existencia');
COMMIT;


Insert into NF.NF_PROC_NOTIFICACION
   (COD_COMPANIA, COD_PROCESO, COD_SISTEMA, DES_PROCESO, COD_ESTADO, SQL_NF)
 Values
   ('01', 'SE_RESPALDO', 'SE', 'Aviso de Respaldo', 
    'ACT', 'Select ''Se recomienda realizar un respaldo de hAnkoo, último realizado ''||to_char(max(a.Date_Generation), ''DD/MM/RRRR'')
  from Se_BackUps a
 where (Select p.Cod_Compania
          from Pa_Companias p
         where RowNum = 1) = :pCompania
     having max(a.Date_Generation) < Sysdate - 7');
COMMIT;


--
