--liquibase formatted sql
--changeset changelog:grants runAlways:true
GRANT USAGE ON SCHEMA "public" TO "neondb_owner"
--rollback not required