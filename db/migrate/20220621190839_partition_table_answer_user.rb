class PartitionTableAnswerUser < ActiveRecord::Migration[7.0]
    
  STEP = 100
  def find_hundred number
    while number % STEP != 0 
      number += 1
    end
    number
  end

  def change
    partition_top = find_hundred (AnswerUser.maximum(:passed_test_id))

    reversible do |dir|
      dir.up do
        remove_foreign_key :answer_users, :passed_tests, if_exists: true
        remove_foreign_key :answer_users, :answer_options, if_exists: true
        
        execute <<-pSQL
          ALTER TABLE answer_users RENAME TO answer_users_old;

          CREATE TABLE answer_users (
            LIKE answer_users_old INCLUDING DEFAULTS INCLUDING CONSTRAINTS
          ) PARTITION BY RANGE (passed_test_id);

          ALTER TABLE answer_users 
            ALTER COLUMN passed_test_id SET NOT NULL;

           ALTER TABLE answer_users_old 
             ADD CONSTRAINT  answer_users_old  
               CHECK (passed_test_id > 0
                 AND passed_test_id <= #{partition_top});

          ALTER TABLE answer_users_old 
            ALTER COLUMN passed_test_id SET NOT NULL;
          
          ALTER TABLE answer_users 
            ATTACH PARTITION answer_users_old
              FOR VALUES FROM (1) TO (#{partition_top});

          CREATE TABLE answer_users_#{partition_top + STEP}
            (LIKE answer_users INCLUDING DEFAULTS INCLUDING CONSTRAINTS);

          ALTER TABLE answer_users_#{partition_top + STEP} 
            ALTER COLUMN passed_test_id SET NOT NULL;

          ALTER TABLE answer_users_#{partition_top + STEP} 
          ADD 
            CHECK ( passed_test_id > #{partition_top} 
              AND passed_test_id <= #{partition_top + STEP} );

          ALTER TABLE answer_users ATTACH PARTITION answer_users_#{partition_top + STEP} 
            FOR VALUES 
              FROM (#{partition_top}) 
              TO (#{partition_top + STEP});

          SELECT setval(pg_get_serial_sequence('answer_users', 'id'), coalesce(max(id)+1, 1), false) FROM answer_users;
        pSQL

        add_foreign_key :answer_users, :passed_tests, on_delete: :cascade, if_not_exists: true
        add_foreign_key :answer_users, :answer_options, on_delete: :cascade, if_not_exists: true
      end # up

      dir.down do
        remove_foreign_key :answer_users, :passed_tests, if_exists: true
        remove_foreign_key :answer_users, :answer_options, if_exists: true

        remove_check_constraint :answer_users_old, name: "answer_users_old"
        drop_table "answer_users_#{partition_top + STEP}"
        execute("ALTER TABLE  answer_users DETACH PARTITION answer_users_old;")
        drop_table :answer_users
        execute("ALTER TABLE answer_users_old RENAME TO answer_users;")

        add_foreign_key :answer_users, :passed_tests, on_delete: :cascade, if_not_exists: true
        add_foreign_key :answer_users, :answer_options, on_delete: :cascade, if_not_exists: true

      end # down
    end # reversible
  end # change
end
