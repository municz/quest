#!/usr/bin/env ruby

DATA_FILE = File.expand_path('../ruby.txt', __FILE__)

def parse_data(data)
  data.split(/^=$/).map do |question_data|
    parse_question(question_data)
  end
end

def parse_question(question_data)
  question_text, *answers_data = question_data.split(/^$/).map(&:strip).reject(&:empty?)

  { :question => question_text,
    :answers  => parse_answers(answers_data)    }
end

def parse_answers(answers_data)
  answers_data.map do |answer_data|
    { :answer => answer_data.sub(/^\* */,''),
      :correct => answer_data.start_with?('*') }
  end
end

def run
  while true
    questions = parse_data(File.read(DATA_FILE))
    if questions.empty?
      puts "Congratulation: no more questions to ask"
      exit
    end

    question = questions.delete_at(rand(questions.size))
    ask_question(question)
  end
end

def ask_question(question)
  puts "#{question[:question]}\n"
  correct_choices = offer_answers(question)

  while true
    answer = gets
    exit if answer.nil? || ["q", "quit"].include?(answer.chomp)
    user_choices = answer.split(/[, ]/).map(&:strip)
    if user_choices.sort == correct_choices.sort
      puts "Congratulation"
      puts "\n------------------------------------------------\n"
      break
    else
      puts "We are sorry, try again"
    end
  end
end

def offer_answers(question)
  answers = question[:answers].sort_by { rand }
  choices = ('a'..'z').first(answers.size)
  mapping = Hash[choices.zip(answers)]
  choices.each do |choice|
    answer = mapping[choice]
    puts "#{choice}) #{answer[:answer]}"
    puts
  end
  correct_choices = mapping.find_all { |_, answer| answer[:correct] }.map(&:first)
  return correct_choices
end

if $0 == __FILE__
  run
end
