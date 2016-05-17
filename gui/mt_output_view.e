note
	description: "Summary description for {MT_OUTPUT_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MT_OUTPUT_VIEW

inherit
	EV_CLIPBOARD

	MT_ANY
		undefine
			default_create,
			copy
		end

feature -- GUI Controls

	view: EV_VERTICAL_BOX
		do
			create Result
			Result.extend (frame)
			frame.extend (frame_box)
			frame_box.extend (gen_output_content_vbx)
			frame_box.extend (gen_output_controls_hbx)
			frame_box.disable_item_expand (gen_output_controls_hbx)
			gen_output_controls_hbx.extend (create {EV_CELL})
			gen_output_controls_hbx.extend (copy_btn)
			gen_output_controls_hbx.extend (create {EV_CELL})
			gen_output_controls_hbx.disable_item_expand (copy_btn)
			copy_btn.set_text ("Copy")
			copy_btn.select_actions.extend (agent on_copy)
		end

	set_content_control (a_control: like text_source)
			-- `set_content_control' with `a_control' into `text_source'.
		do
			text_source := a_control
		ensure
			set: text_source ~ a_control
		end

	on_copy
		do
			if attached text_source as al_source then
				set_text (al_source.text)
			end
		end

	text_source: detachable EV_RICH_TEXT

	frame: EV_FRAME
		once ("object")
			create Result.make_with_text ("Generated output")
		end

	frame_box: EV_VERTICAL_BOX
		once ("object")
			create Result
		end

	gen_output_content_vbx: EV_VERTICAL_BOX
		once ("object")
			create Result
		end

	gen_output_controls_hbx: EV_HORIZONTAL_BOX
		once ("object")
			create Result
		end

	copy_btn: EV_BUTTON
		once ("object")
			create Result.make_with_text ("Copy")
		end

end
