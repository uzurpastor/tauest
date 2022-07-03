class CreateTriggerOnStar < ActiveRecord::Migration[7.0]
  def up
    execute <<-pSQL
      create function fn_unique_stars()
      returns trigger 
      as $func$
      begin
        if exists ( select 1 from stars 
          where user_id = new.user_id and test_id = new.test_id )
        then 
          raise exception 'you cant like this becouse you already liked it';
        end if;
        return new;
      end
      $func$ language 'plpgsql';

      create trigger trg_unique_stars
      before insert on stars
      for each row 
      execute function fn_unique_stars();
    pSQL
  end
  def down
    execute <<-pSQL
      drop trigger  if exists trg_unique_stars;
      drop function if exists fn_unique_stars;
    pSQL
  end
end
