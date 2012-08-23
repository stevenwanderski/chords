class Chord < Music
  
  # @note String
  #   - The root note of the chord. Ex. 'A' or 'C'
  # 
  # @accidental String
  #   - Natural, sharp, flat
  # 
  # @type String
  #   - Chord type: major, minor, dom7, etc..
  
  def initialize params
    @note = params[:note]
    @accidental = params[:accidental]
    @type = params[:type]
    @notes = @accidental == 'flat' || symbol_name == 'F' ? NOTES_FLAT : NOTES_SHARP
  end
  
  def name
    "#{symbol_name} #{@type}"
  end
  
  def symbol_name
    @note + get_accidental_symbol_from_name(@accidental)
  end
  
  def get_notes
    notes = Array.new
    scale = get_major_scale(symbol_name, @accidental, @notes)
    CHORD_TYPES[@type].each do |interval|
      case interval[0]
      when 'b'
        major_note = scale[interval[1].to_i]
        index = NOTES_FLAT.rindex(major_note) || NOTES_FLAT.rindex(NOTE_ALIASES[major_note])
        notes << NOTES_FLAT[index - 1]
      when '#'
        
      else
        notes << scale[interval.to_i]
      end
    end
    notes
  end
  
end