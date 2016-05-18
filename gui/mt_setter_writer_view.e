note
	description: "[
		Representation of a {MT_SETTER_WRITER_VIEW}.
		]"

class
	MT_SETTER_WRITER_VIEW

inherit
	MT_VIEW

feature -- GUI Controls

	view: EV_VERTICAL_BOX
		do
			create Result
			Result.extend (frame)
			frame.extend (frame_box)
			frame_box.extend (feature_name_hbx)
			frame_box.extend (feature_is_attached)
			frame_box.extend (feature_is_anchored)
			frame_box.disable_item_expand (feature_name_hbx)
			frame_box.disable_item_expand (feature_is_attached)
			frame_box.disable_item_expand (feature_is_anchored)
			frame_box.set_padding (2)
			frame_box.set_border_width (2)

			feature_name_hbx.extend (feature_name_label)
			feature_name_hbx.extend (feature_name_text_field)
			feature_name_hbx.extend (feature_type_label)
			feature_name_hbx.extend (feature_type_text_field)
			feature_name_hbx.disable_item_expand (feature_name_label)
			feature_name_hbx.disable_item_expand (feature_type_label)
			feature_name_hbx.set_padding (2)
			feature_name_hbx.set_border_width (2)

			feature_name_text_field.set_tooltip (feature_name_text_field_tooltip)
			feature_type_text_field.focus_out_actions.extend (agent change_to_upper)
		end

feature -- Other GUI

	feature_name_hbx: EV_HORIZONTAL_BOX
		once ("object")
			create Result
		end

	feature_name_label: EV_LABEL
		once ("object")
			create Result.make_with_text ("Feature name: ")
		end

	feature_name_text_field: EV_TEXT_FIELD
		once ("object")
			create Result.make_with_text ("<<Undefined>>")
			Result.focus_in_actions.extend (agent Result.select_all)
		end

	feature_type_label: EV_LABEL
		once ("object")
			create Result.make_with_text ("Type: ")
		end

	feature_type_text_field: EV_TEXT_FIELD
		once ("object")
			create Result.make_with_text ("ANY")
			Result.focus_in_actions.extend (agent Result.select_all)
		end

	feature_is_attached: EV_CHECK_BUTTON
		once ("object")
			create Result.make_with_text ("Is anchored? ")
		end

	feature_is_anchored: EV_CHECK_BUTTON
		once ("object")
			create Result.make_with_text ("Is attached? ")
		end

feature {NONE} -- Implementation: Basic Operations

	change_to_upper
		do
			feature_type_text_field.text.to_upper
		end

feature {NONE} -- Implementation: Constants

	feature_name_text_field_tooltip: STRING = "[
Enter Feature_name in lower case with asterisks only.

This is the name that will be used to generate the stubbed code below.
]"

end
