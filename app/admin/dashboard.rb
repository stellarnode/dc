ActiveAdmin.register_page "Dashboard" do

	menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

	content title: proc{ I18n.t("active_admin.dashboard") } do
#		div class: "blank_slate_container", id: "dashboard_default_message" do
#			span class: "blank_slate" do
#				span I18n.t("active_admin.dashboard_welcome.welcome")
#				small I18n.t("active_admin.dashboard_welcome.call_to_action")
#			end
#		end

		columns do
			
	    column do
	      panel "Recent Users" do
	        table_for User.last(5) do
	        	column('Avatar') do |user|
      				user.profile.avatar? ? image_tag(user.profile.avatar, size: '30') : image_tag('man.png', size: '30')
    				end
	          column('Username') 	{ |user| link_to(user.username, admin_user_path(user)) }
	          column('E-mail')  	{ |user| user.email }
	        end
	      end
	    end	

			column do
	      panel "Recent Polls" do
	        table_for Poll.last(5) do
						column('Title') 	{ |poll| link_to(poll.display_name, admin_poll_path(poll)) }
						column('Start') 	{ |poll| poll.start }
						column('Finish') 	{ |poll| poll.finish }
						column('State') 	{ |poll| status_tag(poll.state) }
						column('Votes') 	{ |poll| poll.votes.size }
						column('User') 		{ |poll| poll.user.username }
	        end
	      end
	    end	

		end #columns	

		columns do

			column do
				panel "Recent Posts" do
					ul do
						Poll.last(5).map do |post|
							li link_to(post.title, admin_post_path(post))
						end
					end
				end
			end	

			column do
				panel "Recent E-mails" do
					ul do
						Email.last(5).map do |email|
							li link_to(email.subject, admin_email_path(email))
						end
					end
				end
			end
			
			column do
				panel "Recent Payments" do
					ul do
						Payment.last(5).map do |payment|
							li link_to(payment.short_dest, admin_payment_path(payment))
						end
					end
				end
			end	

		end #columns

	end #content

end