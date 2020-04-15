CREATE OR REPLACE
            VIEW v_file_obs AS
   SELECT n.nid,
    u.uid,
    string_agg(fm.uri::text, ','::text) AS uri
   FROM node n
     JOIN field_data_field_observation_image foi ON foi.entity_id = n.nid
     JOIN file_managed fm ON foi.field_observation_image_fid = fm.fid
     JOIN users u ON u.uid = n.uid
  WHERE n.type::text = 'observation'::text
  GROUP BY n.nid, u.uid
  ORDER BY n.nid;

GRANT ALL PRIVILEGES ON public.v_file_obs TO mission;

CREATE OR REPLACE VIEW public.v_all_obs AS
    SELECT vfo.nid,
        vfo.uid,
        mission.field_observation_id_mission_value AS mission_id,
        cdnom.field_cd_nom_value AS cd_nom,
        lname.field_last_name_value AS lastname,
        fname.field_first_name_value AS firstname,
        ot.field_observation_timestamp_value AS "timestamp",
        latlong.field_lat_long_value AS latlong,
        note.field_observation_note_value AS note,
        vfo.uri AS public_uri,
        ac.field_geolocation_accuracy_value AS accuracy,
        prov.field_geolocation_provider_value AS location_provider,
        tm.field_geolocation_timestamp_value AS location_timestamp
    FROM v_file_obs vfo
        JOIN field_data_field_last_name lname ON vfo.uid = lname.entity_id
        JOIN field_data_field_first_name fname ON vfo.uid = fname.entity_id
        JOIN field_data_field_observation_timestamp ot ON vfo.nid = ot.entity_id
        JOIN field_data_field_lat_long latlong ON vfo.nid = latlong.entity_id
        JOIN field_data_field_observation_id_mission mission ON vfo.nid = mission.entity_id
        LEFT JOIN field_data_field_observation_note note ON vfo.nid = note.entity_id
        LEFT JOIN field_data_field_cd_nom cdnom ON vfo.nid = cdnom.entity_id
        LEFT JOIN field_data_field_geolocation_accuracy ac ON vfo.nid = ac.entity_id
        LEFT JOIN field_data_field_geolocation_provider prov ON vfo.nid = prov.entity_id
        LEFT JOIN field_data_field_geolocation_timestamp tm ON vfo.nid = tm.entity_id
    ORDER BY vfo.nid;

GRANT ALL PRIVILEGES ON public.v_all_obs TO mission;


