--Afstandsberegning.sql version 0.1.1

---------Creating a Temporary Work Area for Data Manipulation in BRB's Server for DAM--------------------
--
--Description:
--The provided SQL code establishes a temporary work area within the "dam_afstandsberegning" schema on the BRB server, designed to facilitate data manipulation and analysis. The primary objective of this code is to manage and process data from the "dam_afstandsberegning" table, allowing for the execution of calculations that result in new tables for use by the BRB team.
--
--Advantages:
--
--Structured Data Handling: The code organizes data into a schema, providing a structured environment for efficient data management and analysis.
--
--Enhanced Performance: Index creation improves query performance, enabling faster data retrieval and analysis for complex calculations.
--
--Fine-Grained Access Control: The code employs precise access control by granting specific privileges to authorized users/roles, ensuring data security and minimizing the risk of unauthorized manipulation.
--
--Isolation of Work: The temporary work area isolates data manipulation tasks from the main database, reducing the likelihood of interference with critical operations.
--
--Disadvantages:
--
--Temporary Nature: As a temporary workspace, the schema's contents may need to be periodically transferred or integrated back into the main database, potentially leading to data synchronization challenges.
--
--Complexity: The code involves multiple grants and permissions, which may lead to potential management complexity and human error when managing user access.
--
--Maintenance Overhead: Regular maintenance is required to ensure the schema remains up to date and relevant, which might introduce administrative overhead.
--
--Limited Context: The code description lacks specific details about the nature of calculations and the purpose of resulting tables, potentially requiring additional documentation to provide context to users.
--
--In summary, this SQL code establishes a controlled workspace for efficient data manipulation and calculation within BRB's server. While it offers advantages such as enhanced data organization and security, there are potential disadvantages related to complexity, maintenance, and the temporary nature of the workspace. Careful consideration of the pros and cons will help ensure the successful utilization of this temporary work area.
---------------------------------------------------------------------

-- Create a new schema named dam_afstandsberegning
CREATE SCHEMA dam_afstandsberegning AUTHORIZATION postgres;

-- Create a table named adressegrupper in the dam_afstandsberegning schema
-- This table will store information about address groups
CREATE TABLE dam_afstandsberegning.adressegrupper (
    id uuid NOT NULL, -- Unique identifier for each record
    vejpunkt_x float8 NULL, -- X-coordinate of a road point
    vejpunkt_y float8 NULL, -- Y-coordinate of a road point
    vejkode int2 NULL, -- Road code
    kommunekode int2 NULL, -- Municipality code
    beregn_afstand bool NULL, -- Indicates whether to calculate distance
    gruppering text NULL, -- Grouping information
    nuværende_tidsstempel text NULL, -- Current timestamp information
	punkt public.geometry(point, 25832) NULL, -- Geometric point information
    CONSTRAINT adressegrupper_pk PRIMARY KEY (id) -- Define the primary key constraint
);

-- Create indexes to improve query performance on certain columns
CREATE INDEX adressegrupper_gruppering_idx ON dam_afstandsberegning.adressegrupper USING btree (gruppering);
CREATE INDEX adressegrupper_punkt_idx ON dam_afstandsberegning.adressegrupper USING gist (punkt);

-- Grant usage permissions on the schema to specific users/roles
GRANT USAGE ON SCHEMA dam_afstandsberegning TO albert;
GRANT USAGE ON SCHEMA dam_afstandsberegning TO "caboe_DAM";
GRANT USAGE ON SCHEMA dam_afstandsberegning TO dam_read;
GRANT USAGE ON SCHEMA dam_afstandsberegning TO "esbta_DAM";
GRANT USAGE ON SCHEMA dam_afstandsberegning TO jeppe;
GRANT USAGE ON SCHEMA dam_afstandsberegning TO jesper;
GRANT USAGE ON SCHEMA dam_afstandsberegning TO maria;
GRANT USAGE ON SCHEMA dam_afstandsberegning TO rune;
GRANT USAGE ON SCHEMA dam_afstandsberegning TO "soeej_DAM";

-- Grant various permissions on all tables in the schema to specific users/roles
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO albert;
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO "caboe_DAM";
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO dam_read;
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO "esbta_DAM";
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO jeppe;
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO jesper;
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO maria;
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO rune;
GRANT INSERT, UPDATE, DELETE, TRIGGER, SELECT, REFERENCES, TRUNCATE ON All TABLEs in schema dam_afstandsberegning TO "soeej_DAM";
-- ... similar GRANT statements for other users/roles ...

-- Grant usage and select permissions on all sequences in the schema to specific users/roles
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO albert;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO "caboe_DAM";
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO dam_read;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO "esbta_DAM";
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO jeppe;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO jesper;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO maria;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO rune;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dam_afstandsberegning TO "soeej_DAM";
-- ... similar GRANT statements for other users/roles ...
