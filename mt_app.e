note
	description: "[
		Representation of a {MT_APP}.
		]"
	design: "See design notes at the end of this class."

class
	MT_APP

inherit
	MT_ANY

create
	make

feature {NONE} -- Initialization

	make
			-- `make' Current.
		do
			create application

			create main_window.make_with_title ("Moon Tracks")
			main_window.set_size (1000, 600)
			main_window.set_icon_pixmap ((create {MT_MOONTRACKS_IMAGE}.make).to_pixmap)

			application.post_launch_actions.extend (agent main_window.show)
			main_window.close_request_actions.extend (agent application.destroy)

			application.launch
		end

feature {NONE} -- Implementation: GUI

	application: EV_APPLICATION
			-- `application' of Current.

	main_window: MT_MAIN_WINDOW
			-- `main_window' of Current.

;note
	design_intent: "[
		"Moon Tracks" is a code-snippet generator designed to provide
		"stub-work" to a programmer for common code patterns he or she
		will need to type as they work to build out some part of code.
		]"

end
