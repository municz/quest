require './quest'
require 'test/unit'

class QuestTest < Test::Unit::TestCase

  def sample_data
    <<DATA
What's the naming convention for local variables?

`userDetails`

* `user_details`

`UserDetails`

`USER_DETAILS`

=
What's the naming convention for classes and their files?

`user_detail` class in `user_detail.rb` file

`UserDetail` class in `UserDetail.rb` file

* `UserDetail` in `user_detail.rb` file

`user_detail` class in `UserDetail.rb` file
=
Which of these options contains a global variable:

*`$names`

`@names`

`names` defined outside of any method or class

`@@names`

`$$names`
DATA
  end

  def test_parse_data
    questions = parse_data(sample_data)
    assert_equal 3, questions.size
    question = questions.first
    assert_equal 4, question[:answers].size
    assert_equal "What's the naming convention for local variables?", question[:question]

    assert_equal "`userDetails`", question[:answers][0][:answer]
    assert ! question[:answers][0][:correct]

    assert_equal "`user_details`", question[:answers][1][:answer]
    assert question[:answers][1][:correct]

    assert_equal "`UserDetails`", question[:answers][2][:answer]
    assert ! question[:answers][2][:correct]

    assert_equal "`USER_DETAILS`", question[:answers][3][:answer]
    assert ! question[:answers][3][:correct]
  end
end
