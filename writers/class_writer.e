note
	description: "[
		Representation of a {CLASS_WRITER}
		]"
	design: "[
		A thing that knows how to write stubs for Eiffel classes like:
		(1) Note_clause - Top of class
			(a) Deferred Abstraction
			(b) Concrete Representation
			(c) Includes notes for: Description, Design_intent, EIS_stub
		(2) Note_clause - Bottom of class
			(c) Includes notes for: Design_intent, EIS_stub, Glossary, Glossary_terms
		]"

class
	CLASS_WRITER

inherit
	ANY
		redefine
			out
		end

feature -- Access

	is_deferred: attached BOOLEAN
			--`is_deferred' of Current.

feature -- Setters

	set_is_deferred (a_is_deferred: like is_deferred)
			-- `set_is_deferred' with `a_is_deferred'
		do
			is_deferred := a_is_deferred
		ensure
			set: is_deferred ~ a_is_deferred
		end

feature -- Output

	top_note: STRING
			-- `top_note' (e.g. the one at the top of a class).
		do
			create Result.make_empty
			Result.append_string ("note%N%Tdescription: ")
			Result.append_character ('"')
			Result.append_character ('[')
			Result.append_character ('%N')
			Result.append_character ('%T')
			Result.append_character ('%T')
			if is_deferred then
				Result.append_string ("Abstraction notion of a {REPLACE_ME}.%N")
			else
				Result.append_string ("Representation of an effected {REPLACE_ME}.%N")
			end
			Result.append_character (']')
			Result.append_character ('"')
			Result.append_character ('%N')
			Result.append_character ('%N')
		end

	bottom_note: STRING
			-- `bottom_note' (e.g. the one at the end of a class).
		do
			create Result.make_empty
			Result.append_string ("note%N%Tdesign_intent: ")
			Result.append_character ('"')
			Result.append_character ('[')
			Result.append_character ('%N')
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_string ("Your_text_goes_here")
			Result.append_character ('%N')
			Result.append_character (']')
			Result.append_character ('"')
			Result.append_character ('%N')
			Result.append_character ('%N')
		end


	out: STRING
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_string (top_note)
			Result.append_string (bottom_note)
		end


end
