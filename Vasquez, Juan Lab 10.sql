--Juan S. Vasquez
--4/19/2016
--Lab 10: Stored Procedure

--
-- Returns the immediate prerequisites for the passed-in course number.
--
create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber   int       := $1;
   resultset      REFCURSOR := $2;
begin
	open resultset for 
		select num, name, credits
		from courses
		where num in (
			select PreReqNum
			from Prerequisites
			where  courseNumber = courseNum
		); 
	return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
Fetch all from results;

--
-- Returns the courses for which the passed-in course number is an immediate pre-requisite.
--
create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber   int       := $1;
   resultset      REFCURSOR := $2;
begin
	open resultset for 
		select num, name, credits
		from courses
		where num in (
			select courseNum
			from Prerequisites
			where  courseNumber = preReqNum
		);
	return resultset;
end;
$$ 
language plpgsql;

select IsPreReqFor(120, 'results');
Fetch all from results;