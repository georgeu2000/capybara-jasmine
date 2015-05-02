RSpec::Matchers.define :jasmine_success do
  match do |actual|
    ! actual.match /([1-9]|\d{2,}) failures/
  end

  failure_message do |actual|
    jasmine_result
  end
end