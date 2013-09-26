#!/usr/bin/env ruby

def parse_data(data)
  questions = []
  question = {:answers => []}
  data.lines.each do |line|
    line = line.chomp
    if question[:question].nil?
      question[:question] = line
    elsif line.empty?
    elsif line == '='
      questions << question
      question = {:answers => []}
    else
      answer = { :answer => line, :correct => false }
      if line =~ /^\*/
        answer[:correct] = true
      end
      answer[:answer].sub!(/^\* */, '')
      question[:answers] << answer
    end
  end
  questions << question
  questions
end

def run
  raise NotImplementedError
end

if $0 == __FILE__
  run
end
