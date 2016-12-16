insert into persons (given_name, family_name, address, dob, email) VALUES ('homer', 'chin', '3240 curlew st', '1940-05-31', 'homer@home.com'), ('vicki', 'chin', '3240 curlew st', '1950-01-13', 'vicki@home.com'), ('susan', 'james', '2225 mendocino lane', '1954-10-19', 'susan@home.com'), ('larry', 'james', '2225 mendocino lane', '1956-08-08', 'larry@home.com'), ('alexis', 'wagner', '1234 address', '1983-03-14', 'alexis@home.com');

-- Selcting by date

countryclub_db=#
  select bookings.start_time, facilities.name
  from facilities join bookings on facilities.id = bookings.facility_id
  where facilities.name LIKE '%Tennis Court%' AND bookings.start_time::date = date '2016-09-21';

-- Selecting users that have used tennis Court
countryclub_db=#
  select distinct members.first_name, members.surname, facilities.name
  from members join bookings on members.id = bookings.member_id join facilities on bookings.facility_id = facilities.id
  where facilities.name LIKE '%Tennis Court%' order by members.first_name;

--Show number of times nancy booked pool table
countryclub_db=#
  select members.first_name, members.surname, facilities.name, count(*)
  from members join bookings on members.id = bookings.member_id join facilities on bookings.facility_id = facilities.id
  where facilities.name = 'Pool Table' and members.first_name = 'Nancy' and members.surname = 'Dare'
  group by members.first_name, members.surname, facilities.name;

--Show number of times Nancy Dare booked all facilities
countryclub_db=# s
  elect members.first_name, members.surname, facilities.name, count(*)
  from members join bookings on members.id = bookings.member_id join facilities on bookings.facility_id = facilities.id
  where members.first_name = 'Nancy' and members.surname = 'Dare'
  group by members.first_name, members.surname, facilities.name;

--show name of users who have recommended other users
countryclub_db=#
  select distinct mem1.first_name, mem1.surname
  from members as mem1 join members as mem2 on mem1.id = mem2.recommended_by
  order by mem1.surname, mem1.first_name;


  select distinct
  mem1.first_name,
  mem1.surname
  from
  members as mem1,
  members as mem2
  where
  mem1.id = mem2.recommended_by
  order by
  mem1.surname, mem1.first_name;

--show list of all members and members they recommended (if any)
countryclub_db=#
  select
    members.first_name || ' ' || members.surname AS member,
    (select
        mem1.first_name || ' ' || mem1.surname AS recommender
      FROM
        members AS mem1,
        members AS mem2
      WHERE
        mem1.id = mem2.recommended_by and
        members.recommended_by = mem1.id
      LIMIT
        1)
  from
    members
  order by
    member;

    --

    select
      members.first_name || ' ' || members.surname AS member,
      (select
          recommenders.first_name || ' ' || recommenders.surname AS recommender
        FROM
          members AS recommenders
        WHERE
          members.recommended_by = recommenders.id)
    from
      members
    order by
      member;
