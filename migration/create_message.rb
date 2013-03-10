# -- Table: users
#
# -- DROP TABLE users;
#
#CREATE TABLE messages
#(
#  id serial NOT NULL,
#  contact_id integer,
#  "message" character varying(255),
#  timestamp timestamp without time zone,
#  created_at timestamp without time zone NOT NULL,
#  updated_at timestamp without time zone NOT NULL,
#  CONSTRAINT messages_pkey PRIMARY KEY (id)
#)
#WITH (
#  OIDS=FALSE
#);
#ALTER TABLE messages OWNER TO postgres;
