
user table

CREATE TABLE IF NOT EXISTS public.users
(
    userid integer NOT NULL DEFAULT nextval('users_userid_seq'::regclass),
    fname text COLLATE pg_catalog."default" NOT NULL,
    lname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    monumber character varying(15) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address text COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (userid),
    CONSTRAINT users_email_key UNIQUE (email),
    CONSTRAINT users_monumber_key UNIQUE (monumber)
)


product table

CREATE TABLE IF NOT EXISTS public.product
(
    productid integer NOT NULL DEFAULT nextval('product_productid_seq'::regclass),
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    price numeric(10,2) NOT NULL,
    image character varying(255) COLLATE pg_catalog."default",
    categoryid integer NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (productid),
    CONSTRAINT product_categoryid_fkey FOREIGN KEY (categoryid)
        REFERENCES public.category (categoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)


orders table

CREATE TABLE IF NOT EXISTS public.orders
(
    orderid integer NOT NULL DEFAULT nextval('orders_orderid_seq'::regclass),
    userid integer NOT NULL,
    orderdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) COLLATE pg_catalog."default" NOT NULL,
    amount numeric(10,2) NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (orderid),
    CONSTRAINT orders_userid_fkey FOREIGN KEY (userid)
        REFERENCES public.users (userid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT orders_status_check CHECK (status::text = ANY (ARRAY['Pending'::character varying, 'Shipped'::character varying, 'Delivered'::character varying, 'Cancelled'::character varying]::text[]))
)


orderitem table

CREATE TABLE IF NOT EXISTS public.orderitem
(
    orderitemid integer NOT NULL DEFAULT nextval('orderitem_orderitemid_seq'::regclass),
    orderid integer NOT NULL,
    productid integer NOT NULL,
    qty integer NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT orderitem_pkey PRIMARY KEY (orderitemid),
    CONSTRAINT orderitem_orderid_fkey FOREIGN KEY (orderid)
        REFERENCES public.orders (orderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT orderitem_productid_fkey FOREIGN KEY (productid)
        REFERENCES public.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT orderitem_qty_check CHECK (qty > 0)
)

category table

CREATE TABLE IF NOT EXISTS public.category
(
    categoryid integer NOT NULL DEFAULT nextval('category_categoryid_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (categoryid)
)


cartitem table

CREATE TABLE IF NOT EXISTS public.cartitem
(
    cartitemid integer NOT NULL DEFAULT nextval('cartitem_cartitemid_seq'::regclass),
    cartid integer NOT NULL,
    productid integer NOT NULL,
    qty integer NOT NULL,
    CONSTRAINT cartitem_pkey PRIMARY KEY (cartitemid),
    CONSTRAINT cartitem_cartid_fkey FOREIGN KEY (cartid)
        REFERENCES public.cart (cartid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT cartitem_productid_fkey FOREIGN KEY (productid)
        REFERENCES public.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT cartitem_qty_check CHECK (qty > 0)
)


cart table

CREATE TABLE IF NOT EXISTS public.cart
(
    cartid integer NOT NULL DEFAULT nextval('cart_cartid_seq'::regclass),
    userid integer NOT NULL,
    CONSTRAINT cart_pkey PRIMARY KEY (cartid),
    CONSTRAINT cart_userid_fkey FOREIGN KEY (userid)
        REFERENCES public.users (userid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

