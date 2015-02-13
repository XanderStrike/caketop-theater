class SettingsPage
	include Capybara::DSL

	def initialize
		visit '/settings'
	end

	def reload
		SettingsPage.new
	end

	def set_name name
		within '#name_form' do
			fill_in :content, with: name
			click_button 'Save'
		end
	end

	def set_about content
		within '#about_form' do
			fill_in :content, with: content
			click_button 'Save'
		end
	end

	def set_admin username, password, enabled
		within '#admin_form' do
			fill_in :content, with: username
			fill_in :admin_pass, with: password
			choose (enabled ? 'Yes' : 'No')
			click_button 'Save'
		end
	end

	def set_banner content, enabled
		within '#banner_form' do
			fill_in :content, with: content
			choose (enabled ? 'Show' : 'Hide')
			click_button 'Save'
		end
	end

	def set_footer content, enabled
		within '#footer_form' do
			fill_in :content, with: content
			choose (enabled ? 'Show' : 'Hide')
			click_button 'Save'
		end
	end

	def set_url url
		within '#url_form' do
			fill_in :content, with: url
			click_button 'Save'
		end
	end

	def create_page
		click_link 'Create New Page'
		EditPage.new
	end

	def edit_page name
		within '#pages_table' do
			find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", :text => 'Edit').click
		end
		EditPage.new
	end

	def show_page name
		within '#pages_table' do
			click_link name
		end
		ShowPage.new
	end

	def delete_page name
		within '#pages_table' do
			find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", :text => 'Delete').click
		end
	end
end
