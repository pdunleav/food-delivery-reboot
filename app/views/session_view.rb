class SessionView
  def ask_user_for(stuff)
    puts "Please give me a #{stuff}"
    gets.chomp
  end

  def user_doesnt_exist
    puts "Couldn't find a user with that username"
  end

  def wrong_password
    puts "Incorrect password!"
  end
end
