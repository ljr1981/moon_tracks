note
	description: "[
		Abstract notion of an {MT_VIEW}.
		]"

deferred class
	MT_VIEW

inherit
	MT_ANY

feature -- GUI Controls

	view: EV_VERTICAL_BOX
			-- View of Current.
		deferred
		end

	frame: EV_FRAME
		once ("object")
			create Result.make_with_text ("Feature && Setter generation data")
		end

	frame_box: EV_VERTICAL_BOX
		once ("object")
			create Result
		end

note
	design_intent: "[
		This ancestor class has the shared basics of all "writer"
		descendents.
		]"

end
