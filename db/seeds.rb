require 'faker'

# ###### User
# # up
# 50.times do 
#   name = Faker::Name.name 
#   email = Faker::Internet.unique.email
#   password = 'password'
#   created_at = Faker::Date.backward(days: 14)
#   User.create!( name: name,
#                 email: email,
#                 password: password,
#                 password_confirmation: password,
#                 created_at: created_at)
# end
# ######
# # down
# User.all.each do |e| e.delete end



# ###### Author
# # up
# User.all.sample(10).each do |user|
#   user.become_author 
# end
# ######
# #down
# User.where(is_author == true).each do |author| author.update_attribute :is_author, false



# ###### Test, Question and AnswerOption
# # up
# 20.times do 
#     name = Faker::Lorem.sentence(word_count: 7)
#     author = User.where(is_author: true).ids.sample
#     Test.create!( name: name,
#                   user_id: author)
# end
# Test.all.each do |test| 
#   10.times do  
#     question_text = Faker::Lorem.paragraph(sentence_count: 2)
#     q = Question.create!(  test_id: test.id,
#                         name: question_text )
#     right_num = rand(4)
#     answers = Array.new
#     answers = (0..4).map do |num|
#       option_text = Faker::Lorem.sentence(word_count: 2)
#       right = num == right_num ? true : false
#       AnswerOption.new( question_id: q.id,
#                         right: right,
#                         name: option_text )
#     end 
#     AnswerOption.transaction do 
#       answers.each do |e| e.save! end
#     end 
#   end
# end  
# ######
# # down
# Test.all.each do |e| e.delete end
# AnswerOption.all.each do |e| e.delete end
# Question.all.each do |e| e.delete end





###### PassedTest and AnswerUser
# up
User.where(is_author: false).sample(25).each do |user|
  test = Test.all.sample
  pass = PassedTest.where(user_id: user).where(test_id: test).count + 1
  user_answers = Array.new
  user_answers = test.questions.map do |question|
    answer = question.answer_options[rand(5)]
    AnswerUser.new( answer_option_id: answer.id,
                    right: answer.right )
  end
  PassedTest.transaction do 
    pt = PassedTest.create!(  test_id: test.id, 
                              user_id: user.id,
                              pass: pass)
    AnswerUser.transaction do 
      user_answers.each do |user_answ|
        user_answ.passed_test_id = pt.id
        user_answ.save! if user_answ.changed?
      end
    end
  end
end
# ######
# # down
# AnswerUser.all.each do |e| e.delete end
# PassedTest.all.each do |e| e.delete end





# ###### PassedTest and AnswerUser
# # up
# User.all.sample(25).each do |user|
#   test = Test.all.sample
#   Star.create!( user_id: user.id,
#                 test_id: test.id )
# end
# ######
# # down
# Star.all.each do |e| e.delete end