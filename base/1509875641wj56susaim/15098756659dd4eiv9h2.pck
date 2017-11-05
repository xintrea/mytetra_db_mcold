create or replace package pkg_unique_address is

  /*Возвращает курсор с адресом + patient_id по patient_id и tag*/
FUNCTION get_pat_addr(pat_id NUMBER, tag addrs.tag%TYPE) RETURN SYS_REFCURSOR;

/*Возвращает курсор участок + адрес*/
FUNCTION get_pat_sect_addr RETURN SYS_REFCURSOR;


/*Обновление значения номера участка пациента
при наличии прикрепления данного адреса к участку*/

PROCEDURE update_sect_pat;
  


end pkg_unique_address;
/
create or replace package body pkg_unique_address is


  /*==========================================================================*/
  /*Возвращает курсор с адресом + patient_id по patient_id и tag*/
  /*==========================================================================*/
FUNCTION get_pat_addr(pat_id NUMBER
                      , tag addrs.tag%TYPE) -- 1 - прописка
                                            -- 2 - проживание
                       
  RETURN SYS_REFCURSOR
AS
  c_return SYS_REFCURSOR;

BEGIN
  
  OPEN c_return FOR
       SELECT p.keyid
              , a.region
              , a.region_code
              , a.area
              , a.city
              , a.town
              , a.street
              , a.house
              , a.corp
              , a.flat
       FROM patient p
            , addrs a 
       WHERE a.patientid = p.keyid
             AND p.keyid = pat_id;
  
   RETURN c_return;
END get_pat_addr;
  /*==========================================================================*/
  /*Возвращает курсор участок + адрес*/
  /*==========================================================================*/
FUNCTION get_pat_sect_addr 
  RETURN SYS_REFCURSOR
AS
  c_return SYS_REFCURSOR;
BEGIN
  OPEN c_return FOR
      SELECT s.text
             , s.code
             , sos.region
             , sos.area
             , sos.city
             , sos.town
             , sos.street_name
             , sos.house
             , sos.corp
             , sos.flat_from
             , sos.flat_to
      --       , sos.addr
      FROM SECTION s
           , (SELECT sad.*
                              --, sa.region || ' ' || sa.area || ' ' || sa.city || ' ' || sa.town || ' ' || sa.street_name || ' ' || sa.house || ' ' || sa.corp  addr
                      FROM (select sa.keyid
                   , sa.sectionid said
                   , 1 as status
                   , (select k.name || ' ' || k.socr
                        from solution_kladr.kladr k
                       where k.code = rpad(substr(sa.area_code, 1, 2), 13, '0')) as region
                   , (select k.name || ' ' || k.socr
                        from solution_kladr.kladr k
                       where k.code = rpad(substr(sa.area_code, 1, 5), 13, '0')
                         and k.code <> rpad(substr(sa.area_code, 1, 2), 13, '0')) as area
                   , (select k.name || ' ' || k.socr
                        from solution_kladr.kladr k
                       where k.code = rpad(substr(sa.city_code, 1, 8), 13, '0')
                         and k.code <> rpad(substr(sa.city_code, 1, 5), 13, '0')) as city
                   , (select k.name || ' ' || k.socr
                        from solution_kladr.kladr k
                       where k.code = rpad(substr(sa.town_code, 1, 11), 13, '0')
                         and k.code <> rpad(substr(sa.town_code, 1, 8), 13, '0')) as town
                   , sa.street_name
                   , sa.house
                   , sa.corp
                   , sa.flat_from
                   , sa.flat_to
                   --, decode(trim(sa.flat_from || sa.flat_to), null, '', sa.flat_from || ' - ' || sa.flat_to) as flats
                   , sa.bgndat
                   , sa.enddat
                   , sa.note
                from section_addr sa
               where 1=1 --sa.sectionid = p_section_id
                 and (sa.bgndat is null or sa.bgndat <= trunc(sysdate))
                 and (sa.enddat is null or sa.enddat >= trunc(sysdate))
                 and sa.region_id is null and sa.street_id is null
              union
              select sa.keyid
                     , sa.sectionid said
                   , 1 as status
                   , (select r.text
                        from region r
                           , region a
                           , region t
                       where r.root_id = 0
                         and a.root_id = r.keyid
                         and t.root_id = a.keyid
                         and (r.keyid = sa.region_id or a.keyid = sa.region_id or t.keyid = sa.region_id)) as region
                   , (select a.text
                        from region r
                           , region a
                           , region t
                       where r.root_id = 0
                         and a.root_id = r.keyid
                         and t.root_id = a.keyid
                         and (r.keyid = sa.region_id or a.keyid = sa.region_id or t.keyid = sa.region_id)) as area
                   , (select t.text
                        from region r
                           , region a
                           , region t
                       where r.root_id = 0
                         and a.root_id = r.keyid
                         and t.root_id = a.keyid
                         and nvl(t.city_status, 1) = 1
                         and (r.keyid = sa.region_id or a.keyid = sa.region_id or t.keyid = sa.region_id)) as city
                   , (select t.text
                        from region r
                           , region a
                           , region t
                       where r.root_id = 0
                         and a.root_id = r.keyid
                         and t.root_id = a.keyid
                         and t.city_status = 2
                         and (r.keyid = sa.region_id or a.keyid = sa.region_id or t.keyid = sa.region_id)) as town
                   , sa.street_name
                   , sa.house
                   , sa.corp
                   , sa.flat_from
                   , sa.flat_to
                 --  , decode(trim(sa.flat_from || sa.flat_to), null, '', sa.flat_from || ' - ' || sa.flat_to) as flats
                   , sa.bgndat
                   , sa.enddat
                   , sa.note
                from section_addr sa
               where 1=1 --sa.sectionid = p_section_id
                 and (sa.bgndat is null or sa.bgndat <= trunc(sysdate))
                 and (sa.enddat is null or sa.enddat >= trunc(sysdate))
                 and (sa.region_id is not null or sa.street_id is not null)
               order by bgndat desc nulls last, region, area, city, town) sad) sos
      WHERE s.Keyid = sos.SAID;

RETURN c_return;
END get_pat_sect_addr;

/*==========================================================================*/
/*Обновление значения номера участка пациента
при наличии прикрепления данного адреса к участку*/
  /*==========================================================================*/
PROCEDURE update_sect_pat
  AS
  
  BEGIN
    -- нужно ли обновлять значение участка при наличии значения для пациента?
    -- проверять ли наличие прикрепления данного адреса к участку?
    -- осуществлять ли укрупненный анализ или по точному совпадению?
    -- прописка или проживание или при отсутствии одного смотреть на другое?
  
  
    NULL;
  
  END update_sect_pat;

end pkg_unique_address;
/
