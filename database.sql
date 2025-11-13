DROP TABLE detalle_pedidos CASCADE CONSTRAINTS;
DROP TABLE pedidos CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE direcciones_usuario CASCADE CONSTRAINTS;
DROP TABLE usuario CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;

CREATE TABLE region (
    id_region NUMBER(2) NOT NULL,
    nom_region VARCHAR2(50) NOT NULL
);

CREATE TABLE comuna (
    id_comuna NUMBER(5) NOT NULL,
    nom_comuna VARCHAR2(50) NOT NULL,
    id_region NUMBER(2) NOT NULL
);

CREATE TABLE usuario (
    id_usuario NUMBER(6) NOT NULL,
    correo_usuario VARCHAR2(100) NOT NULL,
    contraseña_hash VARCHAR2(255) NOT NULL,
    pnombre_usuario VARCHAR2(50) NOT NULL,
    snombre_usuario VARCHAR2(50),
    papellido_usuario VARCHAR2(50) NOT NULL,
    sapellido_usuario VARCHAR2(50),
    nrotelefono_usuario NUMBER(12)
);

CREATE TABLE direcciones_usuario (
    id_direccion NUMBER(5) NOT NULL,
    nombre_direccion VARCHAR2(100) NOT NULL,
    codigo_postal NUMBER(7) NOT NULL,
    id_comuna NUMBER(5) NOT NULL,
    id_usuario NUMBER(6) NOT NULL
);

CREATE TABLE cliente (
    id_usuario NUMBER(6) NOT NULL
);

CREATE TABLE empleado (
    id_usuario NUMBER(6) NOT NULL,
    fecha_contrato DATE NOT NULL,
    cargo VARCHAR2(100) NOT NULL
);

CREATE TABLE producto (
    id_producto NUMBER(13) NOT NULL,
    nombre_producto VARCHAR2(100) NOT NULL,
    descripcion_producto VARCHAR2(250),
    id_empleado_editor NUMBER(6),
    precio_producto NUMBER(10,2) NOT NULL,
    stock_disponible NUMBER(3)
);

CREATE TABLE pedidos (
    id_pedido NUMBER(8) NOT NULL,
    id_direccion NUMBER(5) NOT NULL,
    id_usuario NUMBER(6) NOT NULL
);

CREATE TABLE detalle_pedidos (
    id_detalle NUMBER(10,2) NOT NULL,
    id_pedido NUMBER(8) NOT NULL,
    id_producto NUMBER(13) NOT NULL,
    precio_unitario_compra NUMBER(6) NOT NULL
);

-- RESTRICCIONES DE CLAVE PRIMARIA (PK)
ALTER TABLE region ADD CONSTRAINT region_PK PRIMARY KEY (id_region);
ALTER TABLE comuna ADD CONSTRAINT comuna_PK PRIMARY KEY (id_comuna);
ALTER TABLE usuario ADD CONSTRAINT usuario_PK PRIMARY KEY (id_usuario);
ALTER TABLE direcciones_usuario ADD CONSTRAINT direcciones_usuario_PK PRIMARY KEY (id_direccion);
ALTER TABLE cliente ADD CONSTRAINT cliente_PK PRIMARY KEY (id_usuario);
ALTER TABLE empleado ADD CONSTRAINT empleado_PK PRIMARY KEY (id_usuario);
ALTER TABLE producto ADD CONSTRAINT producto_PK PRIMARY KEY (id_producto);
ALTER TABLE pedidos ADD CONSTRAINT pedidos_PK PRIMARY KEY (id_pedido);
ALTER TABLE detalle_pedidos ADD CONSTRAINT detalle_pedidos_PK PRIMARY KEY (id_detalle, id_pedido, id_producto);

-- RESTRICCIONES DE CLAVE ÚNICA (UN)
ALTER TABLE usuario ADD CONSTRAINT usuario_UN UNIQUE (correo_usuario);

-- RESTRICCIONES DE CLAVE FORÁNEA (FK)
ALTER TABLE comuna ADD CONSTRAINT comuna_region_FK FOREIGN KEY (id_region) REFERENCES region (id_region);
ALTER TABLE direcciones_usuario ADD CONSTRAINT direcciones_usuario_comuna_FK FOREIGN KEY (id_comuna) REFERENCES comuna (id_comuna);
ALTER TABLE direcciones_usuario ADD CONSTRAINT direcciones_usuario_usuario_FK FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE cliente ADD CONSTRAINT cliente_usuario_FK FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE empleado ADD CONSTRAINT empleado_usuario_FK FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE producto ADD CONSTRAINT producto_empleado_FK FOREIGN KEY (id_empleado_editor) REFERENCES empleado (id_usuario);
ALTER TABLE pedidos ADD CONSTRAINT pedidos_cliente_FK FOREIGN KEY (id_usuario) REFERENCES cliente (id_usuario);
ALTER TABLE pedidos ADD CONSTRAINT pedidos_direcciones_usuario_FK FOREIGN KEY (id_direccion) REFERENCES direcciones_usuario (id_direccion);
ALTER TABLE detalle_pedidos ADD CONSTRAINT detalle_pedidos_pedidos_FK FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido);
ALTER TABLE detalle_pedidos ADD CONSTRAINT detalle_pedidos_producto_FK FOREIGN KEY (id_producto) REFERENCES producto (id_producto);