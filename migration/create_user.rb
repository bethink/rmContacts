# -- Table: users
# 
# -- DROP TABLE users;
# 
# CREATE TABLE users
# (
  # id serial NOT NULL,
  # "name" character varying(255),
  # dob timestamp without time zone,
  # email character varying(255),
  # phone integer,
  # "password" character varying(255),
  # created_at timestamp without time zone NOT NULL,
  # updated_at timestamp without time zone NOT NULL,
  # CONSTRAINT users_pkey PRIMARY KEY (id)
# )
# WITH (
  # OIDS=FALSE
# );
# ALTER TABLE users OWNER TO postgres;
