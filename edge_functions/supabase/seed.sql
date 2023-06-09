create table increments (
  id bigint generated by default as identity primary key,
  amount int default 0 not null
);

create function get_count()
returns numeric as $$
  select sum(amount) from increments;
$$ language sql;
