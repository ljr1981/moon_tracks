note
	description: "[
		Representation of an {MT_MAIN_WINDOW}.
		]"

class
	MT_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize,
			make_with_title
		end

	MT_ANY
		undefine
			default_create,
			copy
		end

create
	make_with_title

feature {NONE} --

	make_with_title (a_title: like title)
			-- <Precursor>
		do
			Precursor (a_title)
		end

	create_interface_objects
			-- <Precursor>
		do
			create_views

				-- List & Details
			create gen_list

				-- View box
			create gen_view_vbx
			create gen_view_content_vbx
			create gen_view_controls_hbx
			create generate_btn

				-- Output box
			create gen_output_vbx

				-- Other boxes
			create main_hbx
			create gen_list_vbx
			create gen_detail_vbx

			Precursor
		end

	create_views
			-- `create_views'.
		do
			create feature_and_setter
			create class_notes
		end

	initialize
			-- <Precursor>
		do
				-- Builders
			build_gen_list

				-- View box
			gen_view_vbx.extend (gen_view_content_vbx)
			gen_view_vbx.extend (gen_view_controls_hbx)
			gen_view_vbx.disable_item_expand (gen_view_controls_hbx)
			gen_view_controls_hbx.extend (create {EV_CELL})
			gen_view_controls_hbx.extend (generate_btn)
			gen_view_controls_hbx.extend (create {EV_CELL})
			gen_view_controls_hbx.disable_item_expand (generate_btn)
			generate_btn.set_text ("Generate")

				-- Other Containerships
			gen_list_vbx.extend (gen_list)
			gen_list.set_minimum_width (150)
			gen_list_vbx.set_padding (2)
			gen_list_vbx.set_border_width (2)

			gen_detail_vbx.extend (gen_view_vbx)
			gen_detail_vbx.extend (gen_output_vbx.view)
			gen_detail_vbx.set_padding (2)
			gen_detail_vbx.set_border_width (2)

			main_hbx.extend (gen_list_vbx)
			main_hbx.extend (gen_detail_vbx)
			main_hbx.disable_item_expand (gen_list_vbx)

			extend (main_hbx)
			Precursor
		end

feature {NONE} -- Implementation: GUI

	main_hbx: EV_HORIZONTAL_SPLIT_AREA

	gen_list_vbx,
	gen_detail_vbx,
	gen_view_vbx,
	gen_view_content_vbx: EV_VERTICAL_BOX
	gen_output_vbx: MT_OUTPUT_VIEW

	gen_view_controls_hbx: EV_HORIZONTAL_BOX

	generate_btn: EV_BUTTON

	gen_list: EV_LIST

		-- Views
	feature_and_setter: MT_SETTER_WRITER_VIEW
	class_notes: MT_CLASS_WRITER_VIEW

feature {NONE} -- Implementation: Init Content

	build_gen_list
			-- `build_gen_list' by adding list items to `gen_list'.
		do
			gen_list.extend (feature_and_setter_list_item)
			gen_list.extend (class_notes_list_item)
		end

	feature_and_setter_list_item: EV_LIST_ITEM
		attribute
			create Result.make_with_text ("Feature & Setter")
			Result.select_actions.extend (agent on_feature_and_setter)
		end

	class_notes_list_item: EV_LIST_ITEM
		attribute
			create Result.make_with_text ("Class notes")
			Result.select_actions.extend (agent on_class_notes)
		end

feature {NONE} -- Implementation: Event Handlers

	on_feature_and_setter
		do
			prep_gen_view_context (feature_and_setter.view, agent on_feature_and_setter_generate)
		end

	on_feature_and_setter_generate
		local
			l_model: SETTER_WRITER
			l_content: EV_RICH_TEXT
		do
			create l_model
			l_model.set_feature_name (feature_and_setter.feature_name_text_field.text)
			l_model.set_feature_type (feature_and_setter.feature_type_text_field.text)
			l_model.set_is_anchored (feature_and_setter.feature_is_anchored.is_selected)
			l_model.set_is_attached (feature_and_setter.feature_is_attached.is_selectable)
			show_generated_output (l_model.out)
		end

	on_class_notes
		do
			prep_gen_view_context (class_notes.view, agent on_class_notes_generate)
		end

	on_class_notes_generate
		local
			l_model: CLASS_WRITER
		do
			create l_model
			l_model.set_is_deferred (class_notes.is_deferred)
			show_generated_output (l_model.out)
		end

feature {NONE} -- Implementation: Generic Event Code

	prep_gen_view_context (a_view: EV_VERTICAL_BOX; a_agent: PROCEDURE)
		do
			gen_view_content_vbx.wipe_out
			gen_view_content_vbx.extend (a_view)
			generate_btn.select_actions.wipe_out
			generate_btn.select_actions.extend (a_agent)
		end

	show_generated_output (a_output: STRING)
		local
			l_content: EV_RICH_TEXT
		do
			create l_content
			gen_output_vbx.set_content_control (l_content)
			l_content.set_text (a_output)
			gen_output_vbx.gen_output_content_vbx.wipe_out
			gen_output_vbx.gen_output_content_vbx.extend (l_content)
		end

end
