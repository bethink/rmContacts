class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :label
      t.string :number
      t.references :user

      t.timestamps
    end
    add_index :contacts, :user_id
  end
end


# -- Table: contacts
# 
# -- DROP TABLE contacts;
# 
#CREATE TABLE contacts
#(
#  id serial NOT NULL,
#  label character varying(255),
#  "number" character varying(255),
#  user_id integer,
#  created_at timestamp without time zone NOT NULL,
#  updated_at timestamp without time zone NOT NULL,
#  CONSTRAINT contacts_pkey PRIMARY KEY (id)
#)
#WITH (
#  OIDS=FALSE
#);
#ALTER TABLE contacts OWNER TO postgres;
# 
# -- Index: index_contacts_on_user_id
# 
# -- DROP INDEX index_contacts_on_user_id;
# 
# CREATE INDEX index_contacts_on_user_id
  # ON contacts
  # USING btree
  # (user_id);
# 
