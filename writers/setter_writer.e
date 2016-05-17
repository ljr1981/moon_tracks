note
	description: "[
		Representation of a {SETTER_WRITER}.
		]"

class
	SETTER_WRITER

inherit
	ANY
		redefine
			out
		end

feature -- Setters

	set_feature_name (a_feature_name: attached like feature_name_type_anchor)
			-- `set_feature_name' with `a_feature_name'
		do
			feature_name := a_feature_name
		ensure
			set: feature_name ~ a_feature_name
		end

	set_feature_type (a_feature_type: attached like feature_type_type_anchor)
			-- `set_feature_type' with `a_feature_type'
		do
			feature_type := a_feature_type
			feature_type.to_upper
		ensure
			set: feature_type ~ a_feature_type
		end

	set_is_attached (a_flag: BOOLEAN)
		do
			is_attached := a_flag
		ensure
			set: is_attached = a_flag
		end

	set_is_anchored (a_flag: BOOLEAN)
		do
			is_anchored := a_flag
		ensure
			set: is_anchored = a_flag
		end

feature -- Output

	feature_out: STRING
			-- `feature_out' of Current.
			-- "my_feature: STRING"
			-- "		-- `my_feature' of Current."
		do
			Result := "%T"
			Result.append_string (feature_name)
			Result.append_character (':')
			Result.append_character (' ')
			if is_attached then
				Result.append_string ("attached")
				Result.append_character (' ')
			end
			if is_anchored then
				if is_attached then
					Result.append_string ("like")
				else
					Result.append_string ("attached like")
				end
				Result.append_character (' ')
				Result.append_string (type_anchor_name)
			else
				Result.append_string (feature_type)
			end
			Result.append_character ('%N')
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_string ("--`" + feature_name + "' of Current.")
			Result.append_character ('%N')
		end

	setter_out: STRING
			-- `setter_out' of Current.
			-- "	set_my_feature (a_my_feature: like my_feature)"
			-- "			-- `set_my_feature' with `a_my_feature' into `my_feature'."
			-- "		do"
			-- "			my_feature := a_my_feature"
			-- "		ensure"
			-- "			set: my_feature ~ a_my_feature"
			-- "		end"
		do
				-- Signature
			Result := "%T"
			Result.append_string (setter_feature_name)
			Result.append_character (' ')
			Result.append_character ('(')
			Result.append_string (setter_argument)
			Result.append_character (')')
			Result.append_character ('%N')
				-- Comment
				-- `set_my_feature' with `a_my_feature'
			Result.append_string ("%T%T%T-- ")
			Result.append_character ('`')
			Result.append_string (setter_feature_name)
			Result.append_character ('%'')
			Result.append_string (" with ")
			Result.append_character ('`')
			Result.append_string ("a_")
			Result.append_string (feature_name)
			Result.append_character ('%'')
			Result.append_character ('%N')
				-- do
			Result.append_string ("%T%Tdo%N")
				-- assign
			Result.append_string ("%T%T%T")
			Result.append_string (feature_name)
			Result.append_string (" := a_")
			Result.append_string (feature_name)
			Result.append_character ('%N')
				-- ensure
			Result.append_string ("%T%Tensure%N")
				-- set
			Result.append_string ("%T%T%Tset: ")
			Result.append_string (feature_name)
			Result.append_string (" ~ a_")
			Result.append_string (feature_name)
			Result.append_character ('%N')
				-- end
			Result.append_string ("%T%Tend%N")
		end

	type_anchor_out: STRING
			-- `type_anchor_out' of Current.
			-- "	my_feature_type_anchor: detachable like STRING"
			-- "			-- `my_feature_type_anchor' for `my_feature' and `set_my_feature'."
		do
			Result := "%T"
			Result.append_string (type_anchor_name)
			Result.append_string (": detachable ")
			Result.append_string (feature_type)
			Result.append_character ('%N')
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_string ("-- `" + feature_name + "_type_anchor' for `" + feature_name + "' and `set_" + feature_name + "'.")
			Result.append_character ('%N')
		end

	out: STRING
			-- <Precursor>
		do
			-- Feature ...
			Result := feature_out
			Result.append_character ('%N')
			-- Feature setter ...
			Result.append_string (setter_out)
			Result.append_character ('%N')
			-- Feature anchor ...
			if is_anchored then
				Result.append_string (type_anchor_out)
			end
		end

feature {NONE} -- Implementation: Access

	feature_name: attached like feature_name_type_anchor
		attribute
			create Result.make_empty
		end

	feature_type: attached like feature_type_type_anchor
		attribute
			Result := "ANY"
		end

feature {NONE} -- Implementation: Queries

	is_attached: BOOLEAN
			-- Setter feature argument `is_attached' like feature?

	is_anchored: BOOLEAN
			-- `feature_name' is "type-anchored"?

feature {NONE} -- Implementation

	setter_feature_name: STRING
			-- `setter_feature_name' of Current.
		do
			Result := "set_"
			Result.append_string (feature_name)
		end

	setter_argument: STRING
			-- `setter_argument'
			-- "a_my_feature like my_feature"
		do
			Result := "a_"
			Result.append_string (feature_name)
			Result.append_character (':')
			Result.append_character (' ')
			Result.append_string ("like")
			Result.append_character (' ')
			Result.append_string (feature_name)
		end

	type_anchor_name: STRING
			-- `type_anchor_name' of Current.
			-- "my_feature_type_anchor"
		do
			Result := feature_name.twin
			Result.append_string ("_type_anchor")
		end

feature {NONE} -- Implementation: Anchors

	feature_name_type_anchor: detachable STRING
			-- `feature_name_type_anchor' for `feature_name' and `set_feature_name'.

	feature_type_type_anchor: detachable STRING
			-- `feature_type_type_anchor' for `feature_type' and `set_feature_type'.


end
