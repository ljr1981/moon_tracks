note
	description: "Tests of {MOON_TRACKS}."
	testing: "type/manual"

class
	MOON_TRACKS_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	MOON_TRACKS_tests
			-- `MOON_TRACKS_tests'
		do
			do_nothing -- yet ...
		end

feature -- Testing {SETTER_WRITER}

	setter_writer_tests
			-- `setter_writer_tests'.
		local
			l_setter: SETTER_WRITER
		do
			create l_setter
			l_setter.set_feature_name ("my_feature")
			l_setter.set_feature_type ("STRING")
				-- Feature
			assert_strings_equal ("feature_out", feature_out_string, l_setter.feature_out)
			l_setter.set_is_anchored (True)
			assert_strings_equal ("feature_out_2", feature_out_2_string, l_setter.feature_out)
				-- Setter
			assert_strings_equal ("setter_out", setter_out_string, l_setter.setter_out)
				-- Type anchor
			assert_strings_equal ("type_anchor_out", feature_name_type_anchor_out_string, l_setter.type_anchor_out)
		end

feature {NONE} -- Testing {SETTER_WRITER}: Support

	feature_out_string: STRING = "%Tmy_feature: STRING%N%T%T%T--`my_feature' of Current.%N"
	feature_out_2_string: STRING = "%Tmy_feature: attached like my_feature_type_anchor%N%T%T%T--`my_feature' of Current.%N"
	setter_out_string: STRING = "%Tset_my_feature (a_my_feature: like my_feature)%N%T%T%T-- `set_my_feature' with `a_my_feature'%N%T%Tdo%N%T%T%Tmy_feature := a_my_feature%N%T%Tensure%N%T%T%Tset: my_feature ~ a_my_feature%N%T%Tend%N"
	feature_name_type_anchor_out_string: STRING = "%Tmy_feature_type_anchor: detachable STRING%N%T%T%T-- `my_feature_type_anchor' for `my_feature' and `set_my_feature'.%N"

feature -- Testing: {CLASS_WRITER}

	class_writer_tests
			-- `class_writer_tests'
		local
			l_writer: CLASS_WRITER
		do
			create l_writer
			assert_strings_equal ("effective", top_and_bottom_notes, l_writer.out)
		end

feature {NONE} -- Testing: {CLASS_WRITER} Support

	top_and_bottom_notes: STRING = "note%N%Tdescription: %"[%N%T%TRepresentation of an effected {REPLACE_ME}.%N%T%T]%"%N%Nnote%N%Tdesign_intent: %"[%N%T%TYour_text_goes_here%N%T%T]%"%N%N"

end
