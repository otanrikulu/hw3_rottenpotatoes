# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /^I should see (.*) before (.*)$/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
  regexp = /#{e1}.*#{e2}/m 
  page.body.to_s =~ regexp
end

And /^I should not see (.*) before (.*)$/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
  regexp = /#{e1}.*#{e2}/m 
  page.body.to_s =~ regexp
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	ratings = rating_list.split(", ")
	ratings.each do |rating|
		if uncheck then
			uncheck("ratings_#{rating}")
		else
			check("ratings_#{rating}")
		end
	end
end

Then /I shouldn't see any movies/ do
        assert all("table#movies tbody tr").count == 0
end

Then /I should see all the movies/ do
        assert all("table#movies tbody tr").count == Movie.count
end

When /^I press (.*)$/ do |button|
  click_button(button)
end

Then /^I should see: (.*)$/ do |titles_list|
  titles = titles_list.split(", ")
  titles.each do |title|
	if page.respond_to? :should
    		page.should have_content(title)
	else
		assert page.has_content?(title)
	end
  end
end

And /^I should not see: (.*)$/ do |titles_list|
  titles = titles_list.split(", ")
  titles.each do |title|
  	if page.respond_to? :should
    		page.should have_no_content(title)
  	else
    		assert page.has_no_content?(title)
	end
  end
end


